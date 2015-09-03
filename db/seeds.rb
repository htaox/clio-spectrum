# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

DATASOURCES_CONFIG ||= YAML.load(File.read(Rails.root.to_s + '/config/datasources.yml'))

DATASOURCES_CONFIG['datasources'].each_key do |datasource|
  Datasource.find_or_create_by(name: datasource)
end
