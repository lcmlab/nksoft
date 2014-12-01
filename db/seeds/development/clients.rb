#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Clientテーブル
#


clients = ["小林興業", "清水工務店", "田島建設", "竹内工務","太平建設", "自社"]


#debugger # << (1)


0.upto(5) do |idx|
   Client.create(
   {  clientname: clients[idx]

   }, without_protection: true)
end
