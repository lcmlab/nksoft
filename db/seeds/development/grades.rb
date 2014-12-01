#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Gradeテーブル：職能別時間単価テーブル
#


grades = ["特殊斫作業", "一般斫作業", "熟練鍛冶作業", "一般鍛冶作業", "土工世話役", "土工作業", "特殊多能工作業","一般多能工作業", "管理指導", "管理補佐"]
unitprices = [2800, 2200, 2800, 2200, 2800, 2200, 2800, 2200, 3000, 2700]


#debugger # << (1)


0.upto(9) do |idx|
   Grade.create(
   {  gradename: grades[idx],
      unitpayment: unitprices[idx],
      unitdemand: (unitprices[idx] * 1.30).to_i,
      holidayschg: 1.50
   }, without_protection: true)
end
