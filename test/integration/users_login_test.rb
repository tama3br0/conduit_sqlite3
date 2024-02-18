require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

def setup # fixtureのusers.ymlにあるサンプルデータ
    @user = users(:michael)
end

    test "無効なログイン情報を確認する" do
        get login_path
        assert_template 'sessions/new'
        post login_path, params: { session: { email:    @user.email,
                                              password: "invalid" } }
        assert_not is_logged_in?
        assert_response :unprocessable_entity
        assert_template 'sessions/new'
        assert_not flash.empty?
        get root_path
        assert flash.empty?
    end

    test "有効なログイン情報とログアウトを確認する" do
        post login_path, params: { session: { email:    @user.email,
                                              password: 'password' } }
        assert is_logged_in?
        assert_redirected_to @user
        follow_redirect!
        assert_template 'users/show'
        assert_select "a[href=?]", login_path, count: 0
        assert_select "a[href=?]", logout_path
        assert_select "a[href=?]", user_path(@user)
        
        delete logout_path
        assert_not is_logged_in?
        assert_response :see_other
        assert_redirected_to root_path
        follow_redirect!
        assert_select "a[href=?]", login_path
        assert_select "a[href=?]", logout_path,      count: 0
        assert_select "a[href=?]", user_path(@user), count: 0
    end
end

=begin

ストーリー仕立てで書くのがインテグレーションテスト
1 GET /login ページに行く
2 sessionsにあるnewテンプレートが表示される
3 POSTリクエストが /login に送られる。パラメータは空
4 ログインに失敗する
5 失敗するとnewテンプレートに戻ってくる
6 assert_not flash.empty? → 失敗したら、flashはnotではない（必ずflashされているはず）
7 別のページにアクセスする
8 flashの表示は消えているはず ←ここが上手くいっていない！ flash.nowをcontrollerで使うと治る

=end

