class PersonType < ActiveRecord::Base
  has_many :people_person_types, dependent: :destroy
  has_many :people, through: :people_person_types, source: :person
end
