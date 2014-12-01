class CreateJobitems < ActiveRecord::Migration
  def change
    create_table :jobitems do |t|
      t.string :jobname
      t.references :jobgroup

      t.timestamps
    end
    add_index :jobitems, :jobgroup_id
  end
end
