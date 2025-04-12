class Course < ApplicationRecord
  # Set the table name to 'courses'
  self.table_name = "courses"
  self.primary_key = "id"

  has_many :user, through: :enrolled_course


  validates :code, presence: true
  validates :name, presence: true
  validates :maxStudents, presence: true
  validates :numStudents, presence: true
  validates :section, presence: true
end

class Course < ApplicationRecord
  self.table_name = "courses"
  self.primary_key = "id"

  # Associations
  has_many :user, through: :enrolled_course # Assuming you have an EnrolledCourse model for the many-to-many relationship

  validates :code, presence: true
  validates :name, presence: true
  validates :maxStudents, :numStudents, presence: true, numericality: { only_integer: true }

  validates :section, presence: true

  validates :class_number, presence: true, numericality: { only_integer: true }, length: { is: 4 }

  validates :days, presence: true, format: { with: /\A[A-Z]{1,2}\z/, message: "should be 1–2 uppercase letters like 'MW', 'TTh', or 'WS'" }

  validates :time, presence: true, format: {
    with: /\A([01]?[0-9]|2[0-3]):[0-5][0-9] - ([01]?[0-9]|2[0-3]):[0-5][0-9]\z/,
    message: "should be in format 'HH:MM - HH:MM'"
  }

  validates :room, presence: true, format: { with: /\A[A-Z]\d{3}\z/, message: "should be like 'G102'" }

  validates :remarks, length: { maximum: 50 }, allow_blank: true
end

