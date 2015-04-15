class CreateContentProviders < ActiveRecord::Migration
  def change
    create_table :content_providers do |t|
      t.string :code
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
