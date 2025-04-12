class EnrolledCourse < ApplicationRecord
  self.table_name = 'enrolled_courses'
  
  belongs_to :user
  belongs_to :course

  # Validations
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :course_id, presence: true, numericality: { only_integer: true }
end
