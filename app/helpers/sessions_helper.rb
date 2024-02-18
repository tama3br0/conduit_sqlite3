module SessionsHelper

    # 渡されたユーザーでログインする
    def log_in(user)
        session[:user_id] = user.id
        # セッションを渡すことで、ブラウザの中とRailsサーバの中に情報が入る
        # その2つの情報が一致している限り、ログイン情報を保持し続けられる
    end

      # 現在ログイン中のユーザーを返す（いる場合）
    def current_user                                # このメソッドは、1回のリクエストに対して何度も呼び出される可能性がある = できるだけ問い合わせ階数を減らす方がスマート
                                                    # DBへの「ログインしていますか？」という問い合わせの数を可能な限り減らしたい
        if session[:user_id]                        # これがなくてもUser.find_byだけで動くが、ログイン忠であっても毎回データベースに「いますか！？いますか！？」と問い合わせることになるので、その回数を減らした
            # User.find_by(id: session[:user_id])
            # if @current_user.nil? # @current_userというインスタンス変数が無ければ(nilだったら)
            #     @current_user = User.find_by(id: session[:suer_id]) # もしnilだったら、@インスタンス変数にしておけば、User.find_byでいちいち問い合わせなくても済む！
            #     @current_user
            # else
            #     @current_user # ログインしていれば、データベースに問い合わせずとも、インスタンス変数として使いまわせる！
            # end
            @current_user ||= User.find_by(id: session[:user_id]) # 上のコードを全部1行で書くとこうなる
        end
    end

      # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil? # current_userがnilかどうかをチェック current_userがnilではない＝ログインしている。nilかどうかは、sessionにuser_idが入っているかどうか。
    end

      # 現在のユーザーをログアウトする
    def log_out
        reset_session
        @current_user = nil   # 安全のため
    end
end
