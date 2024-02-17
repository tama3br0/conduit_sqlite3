require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
    test "サインアップのページが表示されるはずだ" do
        get signup_path
        assert_response :success
    end
end
