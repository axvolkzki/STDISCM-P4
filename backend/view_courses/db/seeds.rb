# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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