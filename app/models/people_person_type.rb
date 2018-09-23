class PeoplePersonType < ActiveRecord::Base
  belongs_to :person
  belongs_to :person_type
end
