class QuickSet < ActiveRecord::Base
  has_and_belongs_to_many :content_providers
  attr_accessible :name, :description, :suppressed, :content_provider_ids
end
