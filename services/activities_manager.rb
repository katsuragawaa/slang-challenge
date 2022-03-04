class ActivitiesManager
  attr_reader :activities

  def initialize(activities)
    @activities = activities
  end

  def sort_activities_by_answered_at
    activities.sort! { |a, b| a["first_seen_at"] <=> b["first_seen_at"] }
  end
end
