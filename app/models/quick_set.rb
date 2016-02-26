class QuickSet < ActiveRecord::Base
  has_and_belongs_to_many :content_providers
  attr_accessible :name, :description, :suppressed, :content_provider_ids

  default_scope order('lower(name)')

  def content_provider_names
    self.content_providers.collect do |content_provider|
      content_provider.name + (content_provider.active ? '' : ' [INACTIVE]')
    end.sort_by!{ |name| name.downcase }
  end

  def content_provider_byte_length
    self.content_providers.sum{ |cp| cp.name.length}
  end

end
