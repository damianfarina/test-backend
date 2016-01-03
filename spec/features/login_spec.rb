require 'spec_helper'

describe "Login", :type => :feature do
  describe "GET /login" do
    before(:each) do
      @user_hash = {
        username: 'test_user1',
        password: 'password'
      }
      @user = User.create(@user_hash)
    end

    after(:each) do
      @user.destroy
    end

    it "should display a login form" do
      visit "/login"

      login(@user_hash) && wait_for_ajax

      expect(page).to have_current_path('/')
      expect(find('.logout')).to have_content('LOG OUT')
    end
  end
end
