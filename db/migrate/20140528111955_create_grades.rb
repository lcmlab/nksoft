class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :gradename    # 職能作業名称
      t.integer :unitpayment # 給与時間単価（円）
      t.integer :unitdemand  # 請求時間単価（円）
      t.float   :holidayschg # 休日割増率

      t.timestamps
    end
  end
end
