class ActivitiesManager
  attr_reader :activities

  def initialize(activities)
    @activities = activities
  end

  def parse_activities_by_user
    convert_timestamp
    sort_activities_by_answered_at
    activities.group_by { |activity| activity["user_id"] }
  end

  def convert_timestamp
    activities.each do |activity|
      activity["first_seen_at"] = Time.parse(activity["first_seen_at"]).iso8601
      activity["answered_at"] = Time.parse(activity["answered_at"]).iso8601
    end
  end

  def sort_activities_by_answered_at
    activities.sort! { |a, b| a["first_seen_at"] <=> b["first_seen_at"] }
  end
end
