class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :username, null: false  # ユーザ番号
      t.string :password
      t.string :name
      t.string :email
      t.references :department
      t.references :state
      t.string :location
      t.string :memo
      t.boolean :leader
      t.boolean :administrator, null: false, default: false  # 管理者フラグ

      t.timestamps
    end
    add_index :employees, :department_id
    add_index :employees, :state_id
  end
end
