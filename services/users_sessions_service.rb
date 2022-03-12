class UsersSessionsService
  attr_reader :users_sessions

  NEW_SESSION_TIMER_LIMIT = 5 * 60 # 5 minutes

  def initialize(users_activities)
    @users_activities = users_activities
    @users_sessions = {}
  end

  def self.create(users_activities)
    new(users_activities).create
  end

  def create
    # Complexity: O(n^2) - nested loop
    @users_activities.each_pair do |user_id, user_activities|
      activities_by_sessions = get_sessions(user_activities)
      activities_by_sessions.each { |session_activities| parse_user_sessions(user_id, session_activities) }
    end

    users_sessions
  end

  private

  def get_sessions(activities)
    # Complexity: O(n)
    sessions = []
    activities.each_with_index do |activity, index|
      time_between_activities = activity[:first_seen_at] - activities[index - 1][:answered_at]

      if index.zero? || time_between_activities > NEW_SESSION_TIMER_LIMIT
        sessions << [activity]
      else
        sessions.last << activity
      end
    end
    sessions
  end

  def parse_user_sessions(user_id, user_activities)
    # Complexity: O(n) - because of the #map to pick only the id
    minimum_first_seen_at = user_activities.first[:first_seen_at]
    latest_answer_at = user_activities.last[:answered_at]
    activity_ids = user_activities.map { |activity| activity[:id] }

    users_sessions[user_id] ||= []
    users_sessions[user_id] << {
      started_at: minimum_first_seen_at,
      ended_at: latest_answer_at,
      duration: latest_answer_at - minimum_first_seen_at,
      activity_ids: activity_ids
    }
  end
end
