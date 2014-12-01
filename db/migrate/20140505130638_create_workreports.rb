class CreateWorkreports < ActiveRecord::Migration
  def change
    create_table :workreports do |t|
      t.references :employee
      t.references :project
      t.references :jobplace
      t.references :jobitem
      t.date :workdate
      t.datetime :timefrom
      t.datetime :timeto
      t.references :addcomment
      t.references :grade

      t.timestamps
    end
    add_index :workreports, :employee_id
    add_index :workreports, :project_id
    add_index :workreports, :jobplace_id
    add_index :workreports, :jobitem_id
    add_index :workreports, :addcomment_id
    add_index :workreports, :grade_id
  end
end
