class DealStatsService
  class << self
    def aggregate
      new.aggregate
    end
  end

  def aggregate
    deals_by_user.map do |user_id, deals|
      [user_id, deals.size]
    end
  end

  def deals_by_user
    all_deals.group_by do |deal|
      deal['user_id']['id']
    end
  end

  def all_deals
    PipedriveClient.deals
  end
end
