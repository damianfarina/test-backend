class User < Sequel::Model
  include Shield::Model
  def self.fetch(username)
    find(:username => username)
  end
end
