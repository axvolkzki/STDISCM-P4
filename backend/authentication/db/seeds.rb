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