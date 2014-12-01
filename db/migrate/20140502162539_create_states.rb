class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :stname

      t.timestamps
    end
  end
end
