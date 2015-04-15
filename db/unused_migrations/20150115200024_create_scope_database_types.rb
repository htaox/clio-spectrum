class CreateContentProviderTypes < ActiveRecord::Migration
  def change
    create_table :content_provider_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
