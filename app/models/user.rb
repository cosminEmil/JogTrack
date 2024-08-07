class User < ApplicationRecord
    has_many :activities, dependent: :destroy
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness:  true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def admin?
      admin
    end
    
    def manager?
      manager
    end
    
    # Optionally, add a method to return the user's role as a string
    def role
      return 'Admin' if admin?
      return 'Manager' if manager?
      'User'
    end
  
    def feed 
      Activity.where("user_id = ?", id)
    end
end
