class CreateQuickSets < ActiveRecord::Migration
  def change
    create_table :quick_sets do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :suppressed, default: true

      t.timestamps
    end
  end
end
