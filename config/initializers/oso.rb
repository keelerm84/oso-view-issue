ActiveSupport::Reloader.to_prepare do
  require 'exceptions'
  OSO = Oso::Oso.new not_found_error: Exceptions::NotFound, forbidden_error: Exceptions::Forbidden

  Relation = Oso::Polar::DataFiltering::Relation
  require 'oso/polar/data/adapter/active_record_adapter'
  OSO.data_filtering_adapter = Oso::Polar::Data::Adapter::ActiveRecordAdapter.new

  OSO.register_class(
    User,
    fields: {
      user_roles: Relation.new(
        kind: 'many',
        other_type: UserRole,
        my_field: 'id',
        other_field: 'user_id'
      ),
      user_country_roles: Relation.new(
        kind: 'many',
        other_type: UserCountryRole,
        my_field: 'id',
        other_field: 'user_id'
      )
    }
  )

  OSO.register_class(
    Student,
    fields: {
      country: Relation.new(
        kind: 'one',
        other_type: Country,
        my_field: 'country_id',
        other_field: 'id'
      )
    }
  )

  OSO.register_class(
    BlogUpdate,
    fields: {
      student: Relation.new(
        kind: 'one',
        other_type: Student,
        my_field: 'student_id',
        other_field: 'id'
      )
    }
  )

  OSO.register_class(
    Country,
    fields: {
      name: String
    }
  )

  OSO.register_class(
    UserRole,
    fields: {
      name: String,
      user: Relation.new(
        kind: 'one',
        other_type: User,
        my_field: 'user_id',
        other_field: 'id'
      )
    }
  )

  OSO.register_class(
    UserCountryRole,
    fields: {
      name: String,
      user: Relation.new(
        kind: 'one',
        other_type: User,
        my_field: 'user_id',
        other_field: 'id'
      ),
      country: Relation.new(
        kind: 'one',
        other_type: Country,
        my_field: 'country_id',
        other_field: 'id'
      )
    }
  )

  OSO.load_files ['app/policy/authorization.polar']
end
