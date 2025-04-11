# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
alice = User.create!({
  id: 12100001,
  first_name: "Alice",
  last_name: "Kingsleigh",
  middle_name: "W.",
  password: "password123",
  password_confirmation: "password123",
  is_professor: false
})

sheldon = User.create!(
  id: 12100009,
  first_name: "Sheldon",
  last_name: "Cooper",
  middle_name: "L.",
  password: "securepass456",
  password_confirmation: "securepass456",
  is_professor: true
)

discm_s11 = Course.create!(
  {
    code: "STDISCM",
    name: "Distributed Computing",
    maxStudents: 45,
    numStudents: 0,
    section: "S11"
  }
)

ths_s11 = Course.create!(
  {
    code: "THS-ST2",
    name: "Thesis in Software Technology 2",
    maxStudents: 40,
    numStudents: 0,
    section: "S11"
  }
)

discm_s12 = Course.create!(
  {
    code: "STDISCM",
    name: "Distributed Computing",
    maxStudents: 45,
    numStudents: 0,
    section: "S12"
  }
)

EnrolledCourse.create!({
  grade: 3.5,
  users_id: alice.id,
  courses_id: discm_s11.id
})

EnrolledCourse.create!({
  users_id: alice.id,
  courses_id: ths_s11.id
})