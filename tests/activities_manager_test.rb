require "minitest/autorun"
require "minitest/pride"
require_relative "../services/activities_manager"

class ActivityManagerTest < Minitest::Test
  def test_parse_activities
    expected = {
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
        }
      ]
    }

    activities = [
      {
        id: 1,
        user_id: "u1",
        answered_at: "2022-03-04T09:20:00.000+00:00",
        first_seen_at: "2022-03-04T09:10:00.000+00:00"
      },
      {
        id: 2,
        user_id: "u1",
        answered_at: "2022-03-04T09:30:00.000+00:00",
        first_seen_at: "2022-03-04T09:26:00.000+00:00"
      },
      {
        id: 3,
        user_id: "u2",
        answered_at: "2022-03-05T10:10:00.000+00:00",
        first_seen_at: "2022-03-05T10:00:00.000+00:00"
      }
    ]

    activities.each { |activity| activity.transform_keys!(&:to_s) }

    assert_equal expected, ActivitiesManager.new(activities).parse_activities_by_user
  end
end
