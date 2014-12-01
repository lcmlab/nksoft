class CreateJobgroups < ActiveRecord::Migration
  def change
    create_table :jobgroups do |t|
      t.string :jgname

      t.timestamps
    end
  end
end
