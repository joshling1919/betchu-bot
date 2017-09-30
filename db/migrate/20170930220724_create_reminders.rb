class CreateReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :reminders do |t|
      t.string :user 
      t.integer :user_groupme_id 
      t.text :reminder 
      t.datetime :reminder_datetime
      t.timestamps
    end
  end
end
