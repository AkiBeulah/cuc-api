class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :subtitle
      t.text :body
      t.integer :level, default: "all", null: false
      t.string :department, default: "all", null: false
      t.string :college, default: "all", null: false
      t.string :hall, default: "all", null: false
      t.string :program, default: "all", null: false
      t.string :url
      t.date :expiry, default: DateTime.now + 1.week, null: false

      t.timestamps
    end
  end
end
