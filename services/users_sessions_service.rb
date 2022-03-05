class UsersSessionsService
  attr_reader :users_sessions

  NEW_SESSION_TIMER_LIMIT = 5 * 60 # 5 minutes

  def initialize(users_activities)
    @users_activities = users_activities
    @users_sessions = {}
  end

  def create
    @users_activities.each_pair do |user_id, user_activities|
      activities_by_sessions = get_sessions(user_activities)
      activities_by_sessions.each { |session_activities| parse_user_sessions(user_id, session_activities) }
    end

    users_sessions
  end

  private

  def get_sessions(activities)
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
    minimum_first_seen_at = pick_attribute(user_activities, :first_seen_at).min
    latest_answer_at = pick_attribute(user_activities, :answered_at).max
    activity_ids = pick_attribute(user_activities, :id)

    users_sessions[user_id] ||= []
    users_sessions[user_id] << {
      started_at: minimum_first_seen_at,
      ended_at: latest_answer_at,
      duration: latest_answer_at - minimum_first_seen_at,
      activity_ids: activity_ids
    }
  end

  def pick_attribute(user_activities, attribute)
    user_activities.map { |activity| activity[attribute] }
  end
end
