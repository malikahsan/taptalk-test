class CreateDailyActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_activities do |t|
      t.text :activity, null: false
      t.datetime :activity_at
      t.references :user, index: true
      t.timestamps
    end
  end
end
