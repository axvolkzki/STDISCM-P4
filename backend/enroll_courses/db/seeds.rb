# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Enrolling students in courses..."

enrollments = [
  { student_id: 12100001, class_number: 2526 },
  { student_id: 12100001, class_number: 4345 },
]

enrollments.each do |enrollment|
  Enrollment.create!(enrollment)
  puts "Enrolled student #{enrollment[:student_id]} in course #{enrollment[:class_number]}"
end