class User < Sequel::Model
  include Shield::Model
  plugin :validation_helpers
  def self.fetch(username)
    find(:username => username)
  end

  def validate
    super
    validates_presence [:username, :crypted_password]
    validates_unique :username
  end
end
