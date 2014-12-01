class CreateSplittimes < ActiveRecord::Migration
  def change
    create_table :splittimes do |t|
      t.string :timesplitmode  # 時間帯境界モード名称
      t.datetime :splittime1   # 深夜２業務境界時刻
      t.datetime :splittime2   # 早朝業務境界時刻
      t.datetime :splittime3   # 午前業務境界時
      t.datetime :splittime4   # 午後業務境界時刻
      t.datetime :splittime5   # 残業業務境界時刻
      t.datetime :splittime6   # 深夜１業務境界時刻

      t.timestamps
    end
  end
end
