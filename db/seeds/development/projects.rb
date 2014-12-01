#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Projectテーブル
#


projects = ["Ｙ駅前プロジェクト", "Ｘプラザ", "Ｚ本社ビル新築工事", "ＤＫマンション新築工事","Ｆ港湾工事", "管理"]


#debugger # << (1)


0.upto(5) do |idx|
   Project.create(
   {  prjname: projects[idx],
      client_id: idx + 1,
      splittime_id: 1
   }, without_protection: true)
end
