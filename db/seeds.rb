# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

countries = Country.create([{ name: 'US' }, { name: 'Mexico' }])
students = Student.create([{ name: 'US student' }, { name: 'Mexico student' }])
users = User.create([{ name: 'US user' }, { name: 'Mexico user' }])

roles = UserCountryRole.create(
  [
    { user: users.first, country: countries.first, name: 'admin' },
    { user: users.last, country: countries.last, name: 'admin' }
  ]
)
