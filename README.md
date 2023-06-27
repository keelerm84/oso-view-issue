# OSO View Reproduction Case

I am experiencing an issue when basing OSO authorization rules on a view.

## Setup

```shell
bundle install
rails db:migrate
rails db:seed
```

## Authorization overview

My domain is made up of:

- Users :: administrative users who access the system
- Students :: A list of kids in the program
- Posts :: Blog posts a student might create
- PostComments :: Responses to posts
- BlogUpdate :: A view that combines posts and post comments into one entity.

The view definition can be seen [here](./db/migration/20230626235418_create_blog_update_view.rb).

Each student is associated with a country. Users have permissions granted to them either through

- UserRoles :: This is a system-wide permission role
- UserCountryRoles :: Roles that only apply to specific countries.

## Authorization Error

I have setup some sample users, posts, etc. Then I have created some permission definitions as part of the `app/policy/authorization.polar` file.

Attempting to run `OSO.authorized_query(User.first, "read", BlogUpdate).count` generates the following outcome:

```shell
❯ rails c
Loading development environment (Rails 7.0.4.3)
irb(main):001:0> OSO.authorized_query(User.first, "read", BlogUpdate).count
  User Load (0.2ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  UserRole Load (0.2ms)  SELECT DISTINCT "user_roles".* FROM "user_roles" WHERE (user_roles.user_id = 1)
  UserCountryRole Load (0.1ms)  SELECT DISTINCT "user_country_roles".* FROM "user_country_roles" WHERE (user_country_roles.user_id = 1)
  Country Load (0.1ms)  SELECT DISTINCT "countries".* FROM "countries" WHERE (countries.id = 1)
  UserRole Load (0.1ms)  SELECT DISTINCT "user_roles".* FROM "user_roles" WHERE (user_roles.user_id = 1)
  UserCountryRole Load (0.1ms)  SELECT DISTINCT "user_country_roles".* FROM "user_country_roles" WHERE (user_country_roles.user_id = 1)
BlogUpdate
student
PolarBoolean
Boolean
Integer
Integer
Float
Float
Array
List
Hash
Dictionary
String
String
User
User
Student
Student
BlogUpdate
BlogUpdate
Country
Country
UserRole
UserRole
UserCountryRole
UserCountryRole
Student
country
PolarBoolean
Boolean
Integer
Integer
Float
Float
Array
List
Hash
Dictionary
String
String
User
User
Student
Student
BlogUpdate
BlogUpdate
Country
Country
UserRole
UserRole
UserCountryRole
UserCountryRole
  BlogUpdate Count (0.4ms)  SELECT COUNT(DISTINCT ) FROM "blog_updates" LEFT JOIN students ON blog_updates.student_id = students.id LEFT JOIN countries ON students.country_id = countries.id WHERE (1 = countries.id)
[...]/database.rb:152:in `initialize': SQLite3::SQLException: DISTINCT aggregates must have exactly one argument (ActiveRecord::StatementInvalid)
[...]/database.rb:152:in `initialize': DISTINCT aggregates must have exactly one argument (SQLite3::SQLException)
irb(main):002:0>
```

Interestingly enough, these alternatives do work:

- `OSO.authorized_query(User.first, "read", BlogUpdate).order('body').count`
- `OSO.authorized_resources(User.first, "read", BlogUpdate).count`
