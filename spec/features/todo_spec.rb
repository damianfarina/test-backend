require 'spec_helper'

describe "Tasks", :type => :feature do
  describe "Not logged in" do
    it "should redirect to login if not logged in" do
      visit('/')
      expect(page).to have_current_path('/login')
    end
  end

  describe "Logged in" do
    before(:each) do
      user_hash = {
        username: 'test_user1',
        password: 'password'
      }
      @user = User.create(user_hash)
      @task = @user.add_task({
        description: 'Task 1',
        category: 'work',
        due_date: Date.today
      })
      login(user_hash) && wait_for_ajax
      visit('/')
    end

    after(:each) do
      @user.destroy
    end

    it "displays tasks" do
      expect(page).to have_current_path('/')
      expect(page).to have_content(@task.description)
      expect(page).to have_content('WORK')
    end

    it "should mark a task as read" do
      expect(page).to have_selector('.status.read-false')
      find('.status.read-false').click && wait_for_ajax
      expect(page).to have_selector('.description.read-true')
    end

    it "should create a new unread task" do
      expect(page).to have_current_path('/')
      fill_in('task[description]', with: 'New task description' )
      select 'School', from: 'task[category]'
      find('.hasDatepicker').click
      click_link('15')
      click_button('Add task') && wait_for_ajax
      expect(page).to have_content('New task description')
      expect(page).to have_content('SCHOOL')
      expect(page).to have_selector('.status.read-false')
    end

    describe "Other users tasks" do
      before(:each) do
        @other_user = User.create({
          username: 'test_user2',
          password: 'password'
        })
        @other_user.add_task({
          description: 'Task 2',
          category: 'work',
          due_date: Date.today
        })
      end

      after(:each) do
        @other_user.destroy
      end

      it "should display other users tasks" do
        expect(page).to have_current_path('/')

        expect(page).to have_selector('.taskItem', count: 1)

        find('#show-mine').click && wait_for_ajax

        expect(page).to have_selector('.taskItem', count: 2)
        expect(page).to have_content('Task 2')
        expect(page).to have_content('WORK')
      end
    end
  end
end
