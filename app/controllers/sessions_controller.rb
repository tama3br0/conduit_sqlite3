class SessionsController < ApplicationController
    
    # GET /login
    def new
        # × @session = Session.new (今回は、Sessionモデルやデータベースに保存するほどではないので)
        # 〇 scope: :session + url: login_path 代わりに、ここに情報を保存していく
    end

    # POST /login
    def create
        # { session: { password: "foobar", email: "user@example.com" } } パラメータはこのような入れ子構造になっている
        user = User.find_by(email: params[:session][:email].downcase)

        # if !user.nil? => user.authenticate(params[:session][:password])  つまり、userの中がnilじゃなかったら、user.authenticateを実行したい、それを以下のように書く
        # if !user.nil? && user.authenticate(params[:session][:password]) # CPUは左から読むので、!user.nil = userがnilだったらここがfalseになるので、この時点でrender :newに行く
        if user && user.authenticate(params[:session][:password]) # Rubyだとこのようにも書ける nilガード
            # Successy
            log_in(user)
            # session[:user_id] = user.id と、ここに直接書いても良いのだが、読みやすさ向上のために、log_inというメソッドをヘルパーに置く。
            redirect_to user_path(user)
        else
            # Failure
            flash.now[:danger] = "メールアドレスまたはパスワードが間違っています"
            render :new, status: :unprocessable_entity
            # redirect_to のときはflash[]だけでよかったのに
            # render のときは、flash.now[]なのはなぜ？　→ renderは、リクエストを送ってページを返しているわけではないので、render "new"が0回目というイメージ。そして、次のページに行ったら1回目(=つまり、flashが反応してしまう)
        end
    end

    # DELETE /logout
    def destroy
        log_out # helperで定義
        redirect_to root_path
    end
end
