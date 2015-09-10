class ContentProviderUpdates < ActiveRecord::Migration
  def change
    add_column :content_providers, :eds_database_id, :string
  end
end
