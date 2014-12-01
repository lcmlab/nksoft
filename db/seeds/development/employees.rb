#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

usernames = %w(Yamada Suzuki Sato Tanaka Inoue Watanabe Sakaguchi)
fnames     = ["山田", "鈴木", "佐藤", "田中","井上", "渡辺","坂口"]
snames     = ["太郎", "次郎", "花子", "三郎","秋吉"]
locations  = ["４階西側", "屋上階", "Ａ作業所", "Ｂ作業所", "地下仕上げ"]
memos      = ["終日勤務です。", "4時に帰社します。", "明日休みます。", "直帰します。", "ただ今現地到着しました。", "午後戻ります。", "本日残業になりそうです。", "遅刻しました。"]

#debugger # << (1)

   # システム管理者
   employee = Employee.create(
   {  username: usernames[6],
      password: "password",
      password_confirmation: "password",
      name: fnames[6],
      email: "sakaguchi.akiyoshi@w3.dion.ne.jp",
      department_id: 5,
      state_id: 1,
      location: locations[1],
      memo: memos[1],
      leader: true,
      administrator: true
   }, without_protection: true)


# 所属部門長
0.upto(5) do |idx|
   employee = Employee.create(
   {  username: usernames[idx],
      password: "password",
      password_confirmation: "password",
      name: "#{fnames[idx]} #{snames[idx % 4]}",
      email: "sakaguchi.akiyoshi@w3.dion.ne.jp",
      department_id: [1, 2, 3, 4][idx % 4],
      state_id: [1, 2, 3, 4, 5][idx % 5],
      location: locations[idx % 5 ],
      memo: memos[idx],
      leader: (idx <= 4),
      administrator: (idx == 0)
   }, without_protection: true)
end

# 一般勤務者
0.upto(12) do |idx|
   Employee.create(
   {  username: "John#{idx + 1}",
      password: "password",
      password_confirmation: "password",
      name: "John Doe#{idx + 1}",
      email: "sakaguchi.akiyoshi@w3.dion.ne.jp",
      department_id: [1, 2, 3, 4][idx % 4],
      state_id: [1, 2, 3, 4, 5][idx % 5],
      location: locations[idx % 5 ],
      memo: memos[idx % 7],
      leader: false,
      administrator: false
   }, without_protection: true)
end
