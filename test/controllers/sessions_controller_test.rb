require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "ログインページが表示されることを確認する" do
    get login_path
    assert_response :success
  end
end
