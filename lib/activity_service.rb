class ActivityService
  attr_reader :user_id

  class << self
    def average_duration
      Hash[UserService.all.map do |user|
        [user['name'], new(user['id']).average_duration]
      end]
    end
  end

  def initialize(user_id)
    @user_id = user_id
  end

  def average_duration
    return 0 if call_durations.size == 0
    duration_sum / call_durations.size
  end

  def duration_sum
    call_durations.inject(:+) || 0
  end

  def call_durations
    @call_durations ||= calls_this_week.map do |activity|
      parse_duration(activity['duration'])
    end
  end

  def calls_this_week
    @calls_this_week ||= PipedriveClient
      .activities(
        done: 1,
        start_date: a_week_ago,
        type: 'call',
        user_id: user_id
    )
  end

  def a_week_ago
    Date.new - 70
  end

  def parse_duration(s)
    t = Time.parse("2015-01-01 00:#{s}")
    t.min * 60 + t.sec
  end
end
