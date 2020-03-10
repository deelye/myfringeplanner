# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require "open-uri"

Planner.destroy_all
Performance.destroy_all
Show.destroy_all
Venue.destroy_all

FringeJob.perform_now


# file = URI.open('https://i.imgur.com/F9G16oJ.png')
jess = User.new(first_name: 'Jessica', last_name: 'DeWitt', email: 'jess@gmail.com', password: 'password')
  # jess.photo.attach(io: file, filename: '', content_type: 'image/png')
  jess.save
file = URI.open('https://avatars0.githubusercontent.com/u/56324000?v=4.png')
dee = User.new(first_name: 'Dee', last_name: 'Lye', email: 'dee@gmail.com', password: 'password')
  # dee.photo.attach(io: file, filename: '', content_type: 'image/png')
  dee.save
# file = URI.open('https://avatars1.githubusercontent.com/u/50817798?v=4.png')
agis = User.new(first_name: 'Agisilaos', last_name: 'Karkalos', email: 'agis@gmail.com', password: 'password')
  # agis.photo.attach(io: file, filename: '', content_type: 'image/png')
  agis.save
# file = URI.open('https://avatars3.githubusercontent.com/u/57145417?v=4.png')
ja = User.new(first_name: 'Jahaira', last_name: 'Castaneda', email: 'jahaira@gmail.com', password: 'password')
  # ja.photo.attach(io: file, filename: '', content_type: 'image/png')
  ja.save
