#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Jobitemテーブル
#


jbitemgs = ["床斫り", "壁斫り", "天井斫り", "ガス切断", "電気溶接", "ガス溶接", "コンクリート打設", "資材運搬", "清掃・片付", "警備・交通整理", "その他雑作業", "勤怠管理作業"]
jbgroups = [1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 5]


#debugger # << (1)


0.upto(11) do |idx|
   Jobitem.create(
   {  jobname: jbitemgs[idx],
      jobgroup_id: jbgroups[idx]
   }, without_protection: true)
end
