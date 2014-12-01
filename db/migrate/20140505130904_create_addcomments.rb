class CreateAddcomments < ActiveRecord::Migration
  def change
    create_table :addcomments do |t|
      t.string :comment

      t.timestamps
    end
  end
end
