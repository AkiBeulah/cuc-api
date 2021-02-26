class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :subtitle
      t.text :body
      t.integer :level,null: false, default: 0
      t.string :department,null: false, default: "*"
      t.string :college,null: false, default: "*"
      t.string :hall,null: false, default: "*"
      t.string :program,null: false, default: "*"
      t.string :url
      t.string :users
      t.date :expiry,null: false, default: DateTime.now + 1.week

      t.timestamps
    end
  end
end
