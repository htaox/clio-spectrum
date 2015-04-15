class ContentProvider < ActiveRecord::Base
  has_and_belongs_to_many :quick_sets
  attr_accessible :name

  default_scope order('name ASC')

end
