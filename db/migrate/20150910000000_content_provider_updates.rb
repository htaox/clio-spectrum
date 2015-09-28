class ContentProviderUpdates < ActiveRecord::Migration
  def change
    add_column :content_providers, :eds_database_id, :string
    add_column :content_providers, :last_seen, :datetime
    add_column :content_providers, :active, :boolean, :default => false
  end
end
