class CreateJobplaces < ActiveRecord::Migration
  def change
    create_table :jobplaces do |t|
      t.string :jobplacename

      t.timestamps
    end
  end
end
