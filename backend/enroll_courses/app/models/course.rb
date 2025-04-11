class Course < ApplicationRecord
  # Set the table name to 'courses'
  self.table_name = "courses"
  self.primary_key = "id"

  has_many :enrolled_courses
  has_many :users, through: :enrolled_courses


  validates :code, presence: true
  validates :name, presence: true
  validates :maxStudents, presence: true
  validates :numStudents, presence: true
  validates :section, presence: true

  validates :id, presence: true, uniqueness: true, numericality: { only_integer: true }
  
end