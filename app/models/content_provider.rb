class ContentProvider < ActiveRecord::Base
  has_and_belongs_to_many :quick_sets
  attr_accessible :name, :eds_database_id, :last_seen, :active

  default_scope order('lower(name)')

end
