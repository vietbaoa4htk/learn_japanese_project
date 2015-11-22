# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "betonamu", email: "betonamu@mail.com", password: "betonamu", role: 1)
User.create!(name: "tranee", email: "tranee@mail.com", password: "tranee", role: 0)
