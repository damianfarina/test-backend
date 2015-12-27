class TestApp
  module Components
    module LoginServer
      def login_user form
        if login(User, form[:username], form[:password])
          { success: true }
        else
          { success: false, errors: {
            username: ['Invalid user name or password'] }
          }
        end
      end
    end
  end
end
