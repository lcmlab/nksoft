#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Jobplaceテーブル
#


jbplaces = ["Ｙ駅前作業所（１）", "Ｙ駅前現場（２）", "Ｘプラザ作業所（１）", "Ｘプラザ現場（２）","Ｚ本社ビル新築工事作業所（１）", "Ｚ本社ビル新築工事現場（２）", "ＤＫマンション新築工事作業所（１）", "ＤＫマンション新築工事現場（２）", "Ｆ港湾工事作業所（１）", "Ｆ港湾工事現場（２）", "本社"]


#debugger # << (1)


0.upto(10) do |idx|
   Jobplace.create(
   {  jobplacename: jbplaces[idx]

   }, without_protection: true)
end
