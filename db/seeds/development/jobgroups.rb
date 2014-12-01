#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Jobgroupテーブル
#


jbgs = ["斫作業チーム", "鍛冶作業チーム", "土工チーム", "多能工チーム","勤怠管理チーム"]


#debugger # << (1)


0.upto(4) do |idx|
   Jobgroup.create(
   {  jgname: jbgs[idx]

   }, without_protection: true)
end
