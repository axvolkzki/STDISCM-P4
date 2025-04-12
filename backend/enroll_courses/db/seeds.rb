# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Creating users..."

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
  }
]

users.each do |user|
  User.create!(user)
  puts "Created user: #{user[:first_name]} #{user[:last_name]}"
end

puts "Creating courses..."

courses = [
  { 
    class_number: 2526,
    code: 'GERIZAL',
    name: 'Life and Works of Rizal',
    maxStudents: 45,
    numStudents: 0,
    section: 'Z21',
    days: 'WS',
    time: '12:45 - 14:15',
    room: 'G102',
    remarks: 'None'
  },
  { 
    class_number: 2527,
    code: 'GERIZAL',
    name: 'Life and Works of Rizal',
    maxStudents: 45,
    numStudents: 0,
    section: 'Z22',
    days: 'WS',
    time: '14:30 - 16:00',
    room: 'G101',
    remarks: 'None'
  },
  { 
    class_number: 4345,
    code: 'STDISCM',
    name: 'Distributed Computing',
    maxStudents: 45,
    numStudents: 0,
    section: 'S11',
    days: 'TF',
    time: '14:30 - 16:00',
    room: 'G103',
    remarks: 'None'
  },
  { 
    class_number: 4346,
    code: 'STDISCM',
    name: 'Distributed Computing',
    maxStudents: 45,
    numStudents: 0,
    section: 'S12',
    days: 'TF',
    time: '12:45 - 14:15',
    room: 'G103',
    remarks: 'None'
  }
]

courses.each do |course_attrs|
  Course.create!(course_attrs)
  puts "Created course: #{course_attrs[:code]} - #{course_attrs[:name]}"
end


# puts "Enrolling students in courses..."

# enrollments = [
#   { student_id: 12100001, class_number: 2526 , grade: "4.0" },
#   { student_id: 12100001, class_number: 4345 , grade: "3.5" },
# ]

# enrollments.each do |enrollment|
#   Enrollment.create!(enrollment)
#   puts "Enrolled student #{enrollment[:student_id]} in course #{enrollment[:class_number]} with grade #{enrollment[:grade]}"
# end