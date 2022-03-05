require "time"

class SortActivitiesService
  attr_reader :activities

  def initialize(activities)
    @activities = activities
  end

  def sort
    # Complexity: O(n)
    convert_timestamps
    sort_activities_by_first_seen_at
    activities_grouped_by_user
  end

  private

  def convert_timestamps
    # Complexity: O(n)
    activities.each do |activity|
      activity[:first_seen_at] = Time.parse(activity[:first_seen_at]).utc
      activity[:answered_at] = Time.parse(activity[:answered_at]).utc
    end
  end

  def sort_activities_by_first_seen_at
    # Complexity: O(n)
    activities.sort_by! { |activity| activity[:first_seen_at] }
  end

  def activities_grouped_by_user
    # Complexity: O(1)
    activities.group_by { |activity| activity[:user_id] }
  end
end
