# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#table_names = %w(buildings members)

table_names = %w(employees workreports)
#table_names = %w(workreports)
table_names = %w(splittimes clients projects jobgroups jobitems jobplaces states addcomments departments employees grades workreports)


table_names.each do |table_name|
   path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
   if File.exist?(path)
      puts "Createing #{table_name}..."
      require path
   else
      puts "path not found!"
   end
end
