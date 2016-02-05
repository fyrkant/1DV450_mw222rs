# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Admin.destroy_all
User.destroy_all
ApiKey.destroy_all

Admin.create!(
  email: "root@foo.com",
  password: "sosecretpass",
  password_confirmation: "sosecretpass"
)
p "Created admin"

user1 = User.create!(
  email: "mail@test.com",
  password: "sosecretpass",
  password_confirmation: "sosecretpass"
)

user2 = User.create!(
  email: "mail2@test.com",
  password: "sosecretpass",
  password_confirmation: "sosecretpass"
)

p "Created #{User.count} users"

ApiKey.create!(
  [
    {
      name: "Stupid App #1",
      user_id: user1.id
    },
    {
      name: "Stupid App #2",
      user_id: user2.id
    }
  ])

p "Created #{ApiKey.count} api keys"
