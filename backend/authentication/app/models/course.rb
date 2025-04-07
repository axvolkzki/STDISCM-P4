class Course < ApplicationRecord
  self.primary_key = "id"

  has_many :user, through: :enrolled_course


  validates :code, presence: true
  validates :name, presence: true
  validates :maxStudents, presence: true
  validates :numStudents, presence: true
  validates :section, presence: true
end
