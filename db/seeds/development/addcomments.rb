#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Addcommentテーブル
#


comments = ["通常勤務", "残業", "深夜残業", "休日出勤"]


#debugger # << (1)


0.upto(3) do |idx|
   Addcomment.create(
   {  comment: comments[idx]

   }, without_protection: true)
end
