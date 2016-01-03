module TodoTestHelpers
  def login(user)
    visit('/login')
    fill_in('user[username]', :with => user[:username])
    fill_in('user[password]', :with => user[:password])
    click_button 'Login'
    find('p.tagline')
  end
end

RSpec.configure do |config|
  config.include TodoTestHelpers, :type => :feature
end
