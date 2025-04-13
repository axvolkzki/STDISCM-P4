# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# alice = User.create!({
#   id: 12100001,
#   first_name: "Alice",
#   last_name: "Kingsleigh",
#   middle_name: "W.",
#   password: "password123",
#   password_confirmation: "password123",
#   is_professor: false
# })

# sheldon = User.create!(
#   id: 12100009,
#   first_name: "Sheldon",
#   last_name: "Cooper",
#   middle_name: "L.",
#   password: "securepass456",
#   password_confirmation: "securepass456",
#   is_professor: true
# )

# discm_s11 = Course.create!(
#   {
#     code: "STDISCM",
#     name: "Distributed Computing",
#     maxStudents: 45,
#     numStudents: 0,
#     section: "S11"
#   }
# )

# ths_s11 = Course.create!(
#   {
#     code: "THS-ST2",
#     name: "Thesis in Software Technology 2",
#     maxStudents: 40,
#     numStudents: 0,
#     section: "S11"
#   }
# )

# discm_s12 = Course.create!(
#   {
#     code: "STDISCM",
#     name: "Distributed Computing",
#     maxStudents: 45,
#     numStudents: 0,
#     section: "S12"
#   }
# )

# EnrolledCourse.create!({
#   grade: 3.5,
#   users_id: alice.id,
#   courses_id: discm_s11.id
# })

# EnrolledCourse.create!({
#   users_id: alice.id,
#   courses_id: ths_s11.id
# })

## Testing for docker env
puts "[Authentication] Creating users..."

users = [
  {
    id: 12100001,
    first_name: "Alice",
    last_name: "Kingsleigh",
    middle_name: "W.",
    password: "password123",
    password_confirmation: "password123",
    is_professor: false
  },
  {
    id: 12100009,
    first_name: "Sheldon",
    last_name: "Cooper",
    middle_name: "L.",
    password: "securepass456",
    password_confirmation: "securepass456",
    is_professor: true
  },
  {
    id: 12100002,
    first_name: "John",
    last_name: "Doe",
    middle_name: "A.",
    password: "pass123",
    password_confirmation: "pass123",
    is_professor: false
  }
]

users.each do |user_attrs|
  User.create!(user_attrs)
  puts "Created user: #{user_attrs[:first_name]} #{user_attrs[:last_name]}"
end

# Creating courses
puts "[Authentication] Creating courses..."

courses = [
  {
    code: 'GERIZAL',
    name: 'Life and Works of Rizal',
    maxStudents: 45,
    numStudents: 0,
    section: 'Z21',
  },
  {
    code: 'STDISCM',
    name: 'Distributed Computing',
    maxStudents: 44,
    numStudents: 1,
    section: 'S11',
  },
  {
    code: 'THS-ST2',
    name: 'Thesis in Software Technology 2',
    maxStudents: 39,
    numStudents: 1,
    section: 'S11',
  },
  {
    code: 'STDISCM',
    name: 'Distributed Computing',
    maxStudents: 45,
    numStudents: 0,
    section: 'S12',
  }
]

courses.each do |course_attrs|
  Course.create!(course_attrs)
  puts "Created course: #{course_attrs[:code]} - #{course_attrs[:name]} in section #{course_attrs[:section]}"
end


# Creating enrolled courses
puts "[Authentication] Creating enrolled courses..."

enrolled_courses = [
  {
    grade: 3.5,
    users_id: 12100001,
    courses_id: 4 # discm_s11
  },
  {
    users_id: 12100001,
    courses_id: 3 # ths_s11
  }
]

enrolled_courses.each do |enrolled_course_attrs|
  EnrolledCourse.create!(enrolled_course_attrs)
  puts "Created enrolled course for user ID: #{enrolled_course_attrs[:users_id]} in course ID: #{enrolled_course_attrs[:courses_id]}"
end