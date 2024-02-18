class ApplicationController < ActionController::Base
    include SessionsHelper
    # どのコントローラからでもログイン関連のメソッドを呼び出せる
end
