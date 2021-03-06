class Planner < ApplicationRecord
  belongs_to :user
  belongs_to :performance

  before_save :set_top_and_duration

  def set_top_and_duration
    dur_in_5 = (self.performance.end - self.performance.start) / 300
    self.duration = ((dur_in_5 / 288) * 100).round(2).to_s + "%"

    top_in_5 = (self.performance.start - (self.performance.start.beginning_of_day + (3600 * 6))) / 300
    if performance.start.hour >= 0 && performance.start.hour < 6
      self.top = (((top_in_5 / 288) * 100).round(2) + 100).to_s + "%"
    else
      self.top = ((top_in_5 / 288) * 100).round(2).to_s + "%"
    end
  end

  def planner_clash(planners, planner)
    planners.each do |p|
      if (planner.performance.start >= p.performance.start && planner.performance.start <= p.performance.end && planner != p) ||
        (planner.performance.end >= p.performance.start && planner.performance.end <= p.performance.end && planner != p)
        return "planner-clash"
      end
    end
  end

  def walk_duration(journey_info)
    num = (journey_info["routes"].first["duration"] / 12).ceil
    if num > 25
      (num / 2).to_s + "px"
    else
      25.to_s + "px"
    end
  end

  def walk_end(journey_info)
    self.performance.end + journey_info["routes"].first["duration"]
  end

  def date
    self.performance.start
  end

  def calc_distance(planners, index)
    venue = self.performance.show.venue
    next_venue = planners[index + 1].performance.show.venue
    response = RestClient.get "https://api.mapbox.com/directions/v5/mapbox/walking/#{venue.longitude},#{venue.latitude};#{next_venue.longitude},#{next_venue.latitude}?geometries=geojson&access_token=#{ENV['MAPBOX_API_KEY']}"
    return JSON.parse(response)
  end

end
