class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.text :message
      t.string :color, default: 'yellow'
      t.string :icon, default: ''
      t.string :iconcolor, default: ''

      t.boolean :active, default: true, null: false
      t.datetime :start_date
      t.datetime :end_date

      t.string :created_by, null: false
      t.string :updated_by
      t.timestamps
    end

    create_table :banners_datasources do |t|
      t.integer :banner_id
      t.integer :datasource_id
    end

  end
end
