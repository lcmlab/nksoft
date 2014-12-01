#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


2.upto(20) do |e_id| # 各勤務者について
  1.upto(5) do |wd|  # 各勤務日について
     workreport = Workreport.create(
        {  employee_id: e_id,
           project_id: [1, 2, 3, 3, 1][e_id % 5],
           jobplace_id: [1, 2, 3, 3, 5, 6, 7, 8, 9, 10] [e_id % 10],
           jobitem_id:  [1, 2, 2, 4, 5, 6, 7, 8, 9, 10] [e_id % 10],
           workdate: "2014-5-" + wd.to_s,
           timefrom: Time.new(2000, 1, 1, 8, 30, 0),
           timeto: Time.new(2000, 1, 1, 17, 30, 0),
           addcomment_id: [1, 2, 3, 4][wd % 4],
           grade_id: [1, 2, 3, 3, 5, 5, 7, 8][e_id % 8]
        }, without_protection: true)
  end
end

 # 管理者について
  1.upto(5) do |wd|  # 各勤務日について
     workreport = Workreport.create(
        {  employee_id: 1,
           project_id: 6,
           jobplace_id: 11,
           jobitem_id:  12,
           workdate: "2014-5-" + wd.to_s,
           timefrom: Time.new(2000, 1, 1, 8, 30, 0),
           timeto: Time.new(2000, 1, 1, 18, 0, 0),
           addcomment_id: [1, 2, 3, 4][wd % 4],
           grade_id: [10, 9][wd % 2]
        }, without_protection: true)
  end
