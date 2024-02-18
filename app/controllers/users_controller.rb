class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "ユーザー情報の登録が完了しました！"
            # GET users/"#{@user.id}"
            redirect_to user_path(@user)
            # redirect_to user_path(@user.id)の省略形
            # redirect_to @user ← これでも認識される
        else
            render :new, status: :unprocessable_entity
        end
    end


    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
