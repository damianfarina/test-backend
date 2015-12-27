class UserCreator
  def self.run user_attrs
    user = User.new
    user.username = user_attrs[:username]
    user.password = user_attrs[:password]
    user.phone_number = user_attrs[:phone_number]
    user.email = user_attrs[:email]

    user.save
    user
  end
end
