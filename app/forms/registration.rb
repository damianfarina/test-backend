class TestApp
  module Forms
    class Registration < Wedge::Plugins::Form
      name :registration_form

      attr_accessor :username,
        :password,
        :password_confirmation,
        :email,
        :phone_number

      def validate
        assert_present :username
        assert_present :password
        assert_present :password_confirmation
        assert_equal :password_confirmation, password unless password.empty?
        assert_email :email
        assert_format :phone_number, /\(\d{3}\) \d{3} - \d{4}/
      end
    end
  end
end
