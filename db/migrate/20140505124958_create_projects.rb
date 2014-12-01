class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :prjname
      t.references :client
      t.references :splittime

      t.timestamps
    end
    add_index :projects, :client_id 
    add_index :projects, :splittime_id

  end
end
