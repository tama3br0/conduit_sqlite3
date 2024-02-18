class User < ApplicationRecord
    before_save { self.email = self.email.downcase } #=>データベースの世界で、渡されたメールアドレスをsaveする前に、全部小文字にしてね
    
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                                      format: { with: VALID_EMAIL_REGEX },
                                      uniqueness: true
    
    
    
    has_secure_password # => 入力されたパスワードをハッシュ化＆見られないようにフィルター
    validates :password, presence: true, length: { minimum: 6 }

    def User.digest(string) # クラス変数
        # 引数に渡された文字列をハッシュ化
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost # 三項演算子
        BCrypt::Password.create(string, cost: cost)
    end
end
