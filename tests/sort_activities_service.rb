require "minitest/autorun"
require "minitest/pride"
require "json"
require "time"
require_relative "../services/sort_activities_service"

class SortActivitiesServiceTest < Minitest::Test
  def test_sort
    expected = {
      u1: [
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
        }
      ],
      u2: [
        {
          id: 3,
          user_id: "u2",
          answered_at: "2022-03-05T10:10:00.000+00:00",
          first_seen_at: "2022-03-05T10:00:00.000+00:00"
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

    expected.each_value do |expected_activities|
      expected_activities.each do |activity|
        activity[:answered_at] = Time.parse(activity[:answered_at]).utc
        activity[:first_seen_at] = Time.parse(activity[:first_seen_at]).utc
      end
    end

    assert_equal expected, SortActivitiesService.new(activities).sort
  end
end
