# frozen_string_literal: true

User.create!(name: "Example User",
             email: "e@example.com",
             password: "password",
             password_confirmation: "password")

99.times do |n|
  name = Faker::Name.name
  email = "e-#{n + 1}@example.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
