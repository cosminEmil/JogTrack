require 'faker'

# Create a main sample user
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             manager: true)

# Generate a bunch of additional users
5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Generate activities for a subset of users
users = User.order(:created_at).take(6)
users.each do |user|
  50.times do
    distance = Faker::Number.between(from: 1, to: 20)
    hours = Faker::Number.between(from: 0, to: 5)
    minutes = Faker::Number.between(from: 0, to: 59)
    seconds = Faker::Number.between(from: 0, to: 59)
    title = Faker::Lorem.sentence(word_count: 3)
    description = Faker::Lorem.sentence(word_count: 5)
    run_at = Faker::Time.between(from: 30.days.ago, to: Time.zone.now)

    user.activities.create!(
      distance: distance,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      title: title,
      description: description,
      run_at: run_at
    )
  end
end