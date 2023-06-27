allow(actor, action, resource) if
  has_permission(actor, action, resource);

actor User {}

# Student {{{
resource Student {
    # Keep this in sync with the User::USER_ROLES values
    roles = ["admin", "root"];
    permissions = ["create", "read", "update", "delete"];

    "read" if "admin";
    "read" if "root";
}

has_role(user: User, name: String, student: Student) if
    has_global_role(user, name) or
    has_country_role(user, name, student.country);
# }}}

# BlogUpdate {{{
resource BlogUpdate {
    # Keep this in sync with the User::USER_ROLES values
    roles = ["admin", "root"];
    permissions = ["create", "read", "update", "delete"];

    "read" if "admin";
    "read" if "root";
}

has_role(user: User, name: String, blog_update: BlogUpdate) if
    has_global_role(user, name) or
    has_country_role(user, name, blog_update.student.country);
# }}}

# Utility functions {{{
has_global_role(user: User, name: String) if
    role in user.user_roles and
    role.name = name;

has_country_role(user: User, name: String, country: Country) if
    role in user.user_country_roles and
    role.name = name and
    role.country.id = country.id;
# }}}

# vim: foldmethod=marker
