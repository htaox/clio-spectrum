class CreateScopeSubjects < ActiveRecord::Migration
  def change
    create_table :scope_subjects do |t|
      t.string :name
      t.integer :scope_subject_id

      t.timestamps
    end
  end
end
