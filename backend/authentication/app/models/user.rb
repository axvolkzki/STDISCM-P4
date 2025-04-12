class User < ApplicationRecord
  self.table_name = 'users' # Set the table name to 'users'
  self.primary_key = 'id' # Keep since using admin-provided IDs
  
  has_many :courses, through: :enrolled_courses
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :id, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :password, length: { minimum: 6 }, allow_nil: true # For updates without password change

  # Role determination
  def role
    is_professor ? 'faculty' : 'student'
  end
end