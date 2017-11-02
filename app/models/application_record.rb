class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # ActiveRecord expects a sequential identifier. Since
  # the record identifiers are UUIDs and therefore not
  # sequential the records need to first be sorted by
  # creation date
  default_scope { order(created_at: :asc) }
end
