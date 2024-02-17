require "test_helper"

class UserTest < ActiveSupport::TestCase
    def setup
        @user = User.new(name:  "Example User", 
                         email: "hogehoge@example.com",
                      password: "foobar",
                      password_confirmation: "foobar")
    end
    
    test "空でないデータが与えられた場合、有効であることを確認する" do #=> assertがtrueになるべきだ
        # puts "------ Test: 空でないデータが与えられた場合、有効であることを確認 ------"
        # puts "@user: #{@user.inspect}"
        assert @user.valid?
    end

    test "名前が空白で与えられた場合、無効であることを確認する" do #=> assert_notがtrueになるべきだ
        # puts "------ Test: 名前が空白で与えられた場合、無効であることを確認 ------"
        # puts "@user: #{@user.inspect}"
        @user.name = "     "
        assert_not @user.valid?
    end

    test "メールアドレスが空白で与えられた場合、無効であることを確認する" do
        # puts "------ Test: メールアドレスが空白で与えられた場合、無効であることを確認 ------"
        # puts "@user: #{@user.inspect}"
        @user.email = "     "
        assert_not @user.valid?
    end

    test "名前が長すぎる場合、無効であることを確認する" do
        # puts "------ Test: 名前が長すぎる場合、無効であることを確認 ------"
        # puts "@user: #{@user.inspect}"
        @user.name = "a" * 51 #=> 51文字以上だったら弾く
        assert_not @user.valid?
    end
    
    test "メールアドレスが長すぎる場合、無効であることを確認する" do
        # puts "------ Test: メールアドレスが長すぎる場合、無効であることを確認 ------"
        # puts "@user: #{@user.inspect}"
        @user.email = "a" * 244 + "@example.com" #=>256文字以上だったら弾く
        assert_not @user.valid?
    end

    test "次の5つのパターンに当てはまるメールアドレスは、有効であることを確認する" do 
        # puts "------ Test: 次の5つのパターンに当てはまるメールアドレスは、有効であることを確認 ------"
        valid_addresses = %w[user@example.com 
                             USER@foo.COM 
                             A_US-ER@foo.bar.org
                             first.last@foo.jp 
                             alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
            @user.email = valid_address # @user.emailにvalid_addressを代入（setupメソッドのemailを上書き）
            # puts "@user: #{@user.inspect}"
            assert @user.valid?, "#{valid_address.inspect} は、無効なアドレスと認識されてしまっています"
        end
    end

    test "次の5つのパターンに当てはまるメールアドレスは、無効であることを確認する" do
        # puts "------ Test: 次の5つのパターンに当てはまるメールアドレスは、無効であることを確認 ------"
        invalid_addresses = %w[user@example,com 
                               user_at_foo.org 
                               user.name@example. 
                               foo@bar_baz.com 
                               foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            # puts "@user: #{@user.inspect}"
            assert_not @user.valid?, "#{invalid_address.inspect} は、有効なアドレスと認識されてしまっています"
        end
    end

    test "同じメールアドレスを登録しようとした場合、無効であることを確認する" do
        # puts "------ Test: 同じメールアドレスを登録しようとした場合、無効であることを確認 ------"
        duplicate_user = @user.dup                  # => userを2人作る(重複 duplicate)
        # duplicate_user.email = @user.email.upcase # =>大文字で書いていても、小文字のアドレスパターンと一致していたら
        @user.save
        assert_not duplicate_user.valid?            # => 登録しようとしたら、弾かれるべき
    end

    test "パスワードが空白で与えられた場合、無効であることを確認する" do
      # @user.password = @user.password_confirmation = " " * 6  こんな風にも書ける
        @user.password              = " " * 6
        @user.password_confirmation = " " * 6
        assert_not @user.valid?
    end
    
    test "パスワードが6文字未満で与えられた場合、無効であることを確認する" do
        @user.password              = "a" * 5
        @user.password_confirmation = "a" * 5
        assert_not @user.valid?
    end

end
