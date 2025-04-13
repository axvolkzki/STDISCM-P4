class EnrolledCourse < ApplicationRecord
  self.table_name = 'enrolled_courses'
  
  belongs_to :user, foreign_key: "users_id"
  belongs_to :course, foreign_key: "courses_id"

  # Validations
  validates :users_id, presence: true, numericality: { only_integer: true }
  validates :courses_id, presence: true, numericality: { only_integer: true }

  # decimal for grades
  validates :grade, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }, allow_nil: true

  # Custom validation to check if the user is already enrolled in the course
  validate :user_not_already_enrolled

  private

  def user_not_already_enrolled
    if EnrolledCourse.exists?(users_id: users_id, courses_id: courses_id)
      errors.add(:base, "User is already enrolled in this course")
    end
  end
end
