class CreateCpqs < ActiveRecord::Migration
  def change
    create_table :content_providers_quick_sets, id: false do |t|
      t.belongs_to :content_provider, index: true
      t.belongs_to :quick_set, index: true
    end

  end
end