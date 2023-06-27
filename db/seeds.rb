# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

countries = Country.create([{ name: 'US' }, { name: 'Mexico' }])
students = Student.create(
  [
    { name: 'US student', country: countries[0] },
    { name: 'Mexico student', country: countries[1] }
  ]
)
users = User.create(
  [
    { name: 'US only user' },
    { name: 'Mexico only user' },
    { name: 'Admin' }
  ]
)

_user_country_roles = UserCountryRole.create(
  [
    { user: users[0], country: countries[0], name: 'admin' },
    { user: users[1], country: countries[1], name: 'admin' }
  ]
)

_user_roles = UserRole.create(
  [
    { user: users[2], name: 'root' }
  ]
)

posts = Post.create(
  [
    { title: 'US Post #1', body: 'Example body #1', student: students[0] },
    { title: 'US Post #2', body: 'Example body #2', student: students[0] }
  ]
)

_post_comments = PostComment.create(
  [
    { comment: 'Comment #1', post: posts[0], author: students[1] },
    { comment: 'Comment #2', post: posts[1], author: students[1] },
    { comment: 'Comment #3', post: posts[1], author: students[0] }
  ]
)
