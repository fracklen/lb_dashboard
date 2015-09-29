class UserService
  class << self
    def all
      new.all
    end

    def by_user_id
      new.by_user_id
    end
  end

  def by_user_id
    Hash[all.map do |user|
      [user['id'], user]
    end]
  end

  def all
    PipedriveClient.users
  end
end
