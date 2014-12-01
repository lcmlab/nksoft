#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Stateテーブル
#


states = ["在宅", "外出", "会議中", "休暇", "自宅勤務"]


#debugger # << (1)


0.upto(4) do |idx|
   State.create(
   {  stname: states[idx]

   }, without_protection: true)
end
