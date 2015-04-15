class CreateScopeSubcategories < ActiveRecord::Migration
  def change
    create_table :scope_subcategories do |t|
      t.string :name
      t.belongs_to :scope_subject, index: true

      t.timestamps
    end
  end
end
