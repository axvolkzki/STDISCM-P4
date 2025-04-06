class User < ApplicationRecord
    self.primary_key = 'id'
    
    # Add password encryption
    has_secure_password
    
    # Validations
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password_digest, presence: true
    validates :id, presence: true, uniqueness: true, numericality: { only_integer: true }
end