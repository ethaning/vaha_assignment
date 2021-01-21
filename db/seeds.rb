# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

exercise_durations = {
  "Overhead Squat" => 15,
  "Side Plank Clam" => 30,
  "Push-Up to chair" => 45,
  "Squat Hold" => 30,
  "Toe Tap" => 20,
  "Reverse Lunge" => 25,
  "Lateral Walk" => 37,
  "Dumbbell Swing" => 40,
  "Forward Raise" => 55,
  "Front Squat" => 43,
  "Overhead Press" => 25,
  "1min Cardio" => 60,
  "Knee to Elbow" => 25,
  "Star Jump" => 30,
  "Step Up" => 45,
}

exercise_durations.each do |name, duration|
  Exercise.create! name: name, duration: duration
end

expertises = %i(yoga fitness strength)

expertises.each do |name|
  Expertise.create!(name: name)
end
