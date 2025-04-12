class EnrolledCourse < ApplicationRecord
  self.table_name = 'enrolled_courses'
  
  belongs_to :user
  belongs_to :course

  # Validations
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :course_id, presence: true, numericality: { only_integer: true }
  
  # decimal for grades
  validates :grade, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }, allow_nil: true

  # Custom validation to check if the user is already enrolled in the course
  validate :user_not_already_enrolled

  private

  def user_not_already_enrolled
    if EnrolledCourse.exists?(user_id: user_id, course_id: course_id)
      errors.add(:base, "User is already enrolled in this course")
    end
  end
end