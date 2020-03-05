class FringeJob < ApplicationJob
  require "json"
  require "rest-client"

  def perform
    url = "https://api.edinburghfestivalcity.com/events?festival=demofringe&key=#{ENV['FRINGE_KEY']}&signature=#{ENV['FRINGE_SIGNATURE']}&size=100"
    response = RestClient.get(url)
    shows = JSON.parse(response)
    shows.each do |show|
      @venue = Venue.find_or_create_by!(venue_hash(show))
      @show = Show.find_by_url(show['url'])
      if @show
        @show.venue = @venue
        @show.update!(show_params(show))
        puts "UPDATED"
      else
        @show = Show.new(show_params(show))
        @show.venue = @venue
        @show.save!
        show['performances'].each do |perf|
          performance = Performance.find_or_create_by(performance_hash(perf, @show))
        end
      end
    end
  end

  def show_params(show)
    show_hash = {
      url: show['url'],
      artist: show['artist'],
      title: show['title'],
      description: show['description'],
      genre: show['genre'],
      original_image: "https:" + show['images'].values.first['versions']['original']['url'],
      thumb_image: "https:" + show['images'].values.first['versions']['thumb-100']['url'],
      age_category: show['age_category'],
      warnings: show['warnings'],
      website: show['website'],
      active: show['status'] == 'active',
      updated: show['updated'].to_datetime,
      twitter: show['twitter']
    }
  end

  def venue_hash(show)
    venue_hash = {
      name: show['venue']['name'],
      space: show['performance_space']['name'],
      address: show['venue']['address'],
      postcode: show['venue']['post_code'],
      longitude: show['venue']['position']['lon'],
      latitude: show['venue']['position']['lat'],
      wheelchair_access: show['performance_space']['wheelchair_access'],
      disabled_description: show['venue']['disabled_description']
    }
  end

  def performance_hash(performance, show)
    performance_hash = {
      start: performance['start'].to_datetime,
      end: performance['end'].to_datetime,
      price: performance['price'],
      show: show
    }
  end

end
