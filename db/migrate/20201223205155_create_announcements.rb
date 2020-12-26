class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :subtitle
      t.text :body
      t.integer :level,null: false, default: 0
      t.string :department,null: false, default: "all"
      t.string :college,null: false, default: "all"
      t.string :hall,null: false, default: "all"
      t.string :program,null: false, default: "all"
      t.string :url
      t.date :expiry,null: false, default: DateTime.now + 1.week

      t.timestamps
    end
  end
end
