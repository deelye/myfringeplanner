class FringeCalendar < SimpleCalendar::Calendar
  private

  def date_range
    beginning = "2020-08-03 T00:00:00+00:00".to_datetime
    ending    = "2020-08-31 T00:00:00+00:00".to_datetime
    (beginning..ending).to_a
  end
end
