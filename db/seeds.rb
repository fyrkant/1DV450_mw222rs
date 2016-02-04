# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ApiKey.destroy_all
# User.destroy_all

ApiKey.create!(
  [
    {
      name: "Stupid App #1",
      user_id: 1
    },
    {
      name: "Stupid App #2",
      user_id: 1
    }
  ])

p "Created #{ApiKey.count} api keys"
