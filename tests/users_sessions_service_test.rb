require "minitest/autorun"
require "minitest/pride"
require "time"
require_relative "../services/users_sessions_service"

class UsersSessionsServiceTest < Minitest::Test
  def test_parse_sessions
    expected = {
      u1: [
        {
          started_at: "2022-03-04 09:10:00 UTC",
          ended_at: "2022-03-04 09:20:00 UTC",
          duration: 600.0,
          activity_ids: [1]
        },
        {
          started_at: "2022-03-04 09:26:00 UTC",
          ended_at: "2022-03-04 09:30:00 UTC",
          duration: 240.0,
          activity_ids: [2]
        }
      ],
      u2: [
        {
          started_at: "2022-03-05 10:00:00 UTC",
          ended_at: "2022-03-05 10:20:00 UTC",
          duration: 1200.0,
          activity_ids: [3, 4]
        }
      ]

    }

    parsed_activities = {
      u1: [
        {
          id: 1,
          user_id: "u1",
          answered_at: "2022-03-04 09:20:00 UTC",
          first_seen_at: "2022-03-04 09:10:00 UTC"
        },
        {
          id: 2,
          user_id: "u1",
          answered_at: "2022-03-04 09:30:00 UTC",
          first_seen_at: "2022-03-04 09:26:00 UTC"
        }
      ],
      u2: [
        {
          id: 3,
          user_id: "u2",
          answered_at: "2022-03-05 10:10:00 UTC",
          first_seen_at: "2022-03-05 10:00:00 UTC"
        },
        {
          id: 4,
          user_id: "u2",
          answered_at: "2022-03-05 10:20:00 UTC",
          first_seen_at: "2022-03-05 10:12:00 UTC"
        }
      ]
    }

    parsed_activities.each_value do |activities|
      activities.each do |activity|
        activity[:answered_at] = Time.parse(activity[:answered_at]).utc
        activity[:first_seen_at] = Time.parse(activity[:first_seen_at]).utc
      end
    end

    expected.each_value do |expected_activities|
      expected_activities.each do |activity|
        activity[:started_at] = Time.parse(activity[:started_at]).utc
        activity[:ended_at] = Time.parse(activity[:ended_at]).utc
      end
    end

    assert_equal expected, UsersSessionsService.new(parsed_activities).create
  end
end
