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

      def register_user form
        user = UserCreator.run(form)
        if user.errors.any?
          { success: false, errors: user.errors }
        else
          { success: true }
        end
      end
    end
  end
end
