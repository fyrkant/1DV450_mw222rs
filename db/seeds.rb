# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
ApiKey.destroy_all

User.create!(
  email: "admin@mail.com",
  password: "adminpassword",
  password_confirmation: "adminpassword"
)
p "Created an admin user"

user_john = User.create!(
  email: "john@doe.com",
  password: "agreatpassword",
  password_confirmation: "agreatpassword"
)

user_jane = User.create!(
  email: "jane@doe.com",
  password: "evengreaterpassword",
  password_confirmation: "evengreaterpassword"
)

p "Created #{User.count} users"

ApiKey.create!(
  [
    {
      name: "Johns application",
      user_id: user_john.id
    },
    {
      name: "Janes application",
      user_id: user_jane.id
    }
  ])

p "Created #{ApiKey.count} api keys"
