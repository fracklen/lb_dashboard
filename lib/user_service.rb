class UserService
  class << self
    def all
      new.all
    end
  end

  def all
    PipedriveClient.users
  end
end
