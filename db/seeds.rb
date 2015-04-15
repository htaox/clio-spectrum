
# # SCOPE DATABASES
# 
# puts "loading content_providers..."
# 
# ContentProvider.delete_all
# open("#{Rails.root}/db/data/content_providers.txt") do |filehandle|
#   filehandle.read.each_line do |line|
#     code, name = line.chomp.split("|")
#     if name.length > 0 && code.length > 0
#       ContentProvider.create!(:name => name, :code => code)
#     end
#   end
# end
# 
# puts "loaded #{ContentProvider.count} content_providers"



# CONTENT PROVIDERS

puts "loading content providers..."

ContentProvider.delete_all
open("#{Rails.root}/db/data/content_providers.txt") do |filehandle|
  filehandle.read.each_line do |line|
    name = line.chomp
    ContentProvider.create!(:name => name) if name.length > 0
  end
end

puts "loaded #{ContentProvider.count} content providers"


# QUICK SETS

puts "loading quick sets..."

QuickSet.delete_all
open("#{Rails.root}/db/data/quick_sets.txt") do |filehandle|
  filehandle.read.each_line do |line|
    name = line.chomp
    QuickSet.create!(:name => name) if name.length > 0
  end
end

puts "loaded #{QuickSet.count} quick sets"



# # SCOPE SUBJECTS
# 
# puts "loading scope_subjects..."
# 
# ScopeSubject.delete_all
# open("#{Rails.root}/db/data/scope_subjects.txt") do |filehandle|
#   filehandle.read.each_line do |line|
#     name = line.chomp
#     ScopeSubject.create!(:name => name) if name.length > 0
#   end
# end
# 
# puts "loaded #{ScopeSubject.count} scope_subjects"
# 
# 
# # SCOPE SUBCATEGORIES
# 
# puts "loading scope_subcategories..."
# 
# ScopeSubcategory.delete_all
# open("#{Rails.root}/db/data/scope_subcategories.txt") do |filehandle|
#   filehandle.read.each_line do |line|
#     subject_name, name = line.chomp.split("|")
#     # puts "subject_name=[#{subject_name}] name=[#{name}]"
#     if name && subject_name && subject_name.length > 0 && name.length > 0
#       subject = ScopeSubject.where(name: subject_name).first
#       raise "subject_name #{subject_name} not found in ScopeSubjects" unless subject
#       ScopeSubcategory.create!(:name => name, :scope_subject_id => subject.id)
#     end
#   end
# end
# 
# puts "loaded #{ScopeSubcategory.count} scope_subcategories"



