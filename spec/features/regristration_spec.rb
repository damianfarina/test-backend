require 'spec_helper'

describe "Registration", :type => :feature do
  before(:each) do
    @user_hash = {
      username: 'newuser',
      password: 'password',
      email: 'email@email.com',
      phone_number: '1112223333'

    }
    visit "/login"
    find('i.fa-pencil').click
  end

  it "should display a register form" do
    expect(find('h2')).to have_content('Create an account')
    expect(page).to have_selector('#registration-form input[name="user[username]"]')
    expect(page).to have_selector('#registration-form input[name="user[email]"]')
    expect(page).to have_selector('#registration-form input[name="user[phone_number]"]')
    expect(page).to have_selector('#registration-form input[name="user[password]"]')
    expect(page).to have_selector('#registration-form input[name="user[password_confirmation]"]')
  end

  it "should register a new user" do
    find('#registration-form').fill_in('user[username]', :with => @user_hash[:username])
    find('#registration-form').fill_in('user[password]', :with => @user_hash[:password])
    find('#registration-form').fill_in('user[password_confirmation]', :with => @user_hash[:password])
    find('#registration-form').fill_in('user[email]', :with => @user_hash[:email])
    find('#registration-form').fill_in('user[phone_number]', :with => @user_hash[:phone_number])
    click_button 'Register' && wait_for_ajax
    expect(page).to have_current_path('/login')
    login(@user_hash) && wait_for_ajax
    expect(page).to have_current_path('/')

    User.where(username: @user_hash[:username]).destroy
  end

  it "should fail if missing properties" do
    find('#registration-form').fill_in('user[password]', :with => @user_hash[:password])
    find('#registration-form').fill_in('user[password_confirmation]', :with => @user_hash[:password])
    find('#registration-form').fill_in('user[email]', :with => @user_hash[:email])
    find('#registration-form').fill_in('user[phone_number]', :with => @user_hash[:phone_number])
    click_button 'Register' && wait_for_ajax
    expect(find('#registration-form')).to have_content('Required')

    find('#registration-form').fill_in('user[username]', :with => @user_hash[:username])
    find('#registration-form').fill_in('user[email]', :with => 'invalid')
    click_button 'Register' && wait_for_ajax
    expect(find('#registration-form')).to have_content("Email Isn't Valid")

    find('#registration-form').fill_in('user[password_confirmation]', :with => 'different')
    find('#registration-form').fill_in('user[email]', :with => @user_hash[:email])
    click_button 'Register' && wait_for_ajax
    expect(find('#registration-form')).to have_content("Password does not match.")
  end
end
