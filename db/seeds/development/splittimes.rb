#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Splittimeテーブル：勤務時間帯境界時刻テーブル
#


splitmodes = ["基本就労時間帯", "タイプＡ就労時間帯"]

#debugger # << (1)


0.upto(1) do |idx|
   Splittime.create(
   {  timesplitmode: splitmodes[idx],
      splittime1: Time.new(2000, 1, 1, 0, 0, 0),
      splittime2: Time.new(2000, 1, 1, 3, 0, 0),
      splittime3: Time.new(2000, 1, 1, 8, 0, 0),
      splittime4: Time.new(2000, 1, 1, 12, 0, 0),
      splittime5: Time.new(2000, 1, 1, 17, 0, 0),
      splittime6: Time.new(2000, 1, 1, 22, 0, 0)
   }, without_protection: true)
end
