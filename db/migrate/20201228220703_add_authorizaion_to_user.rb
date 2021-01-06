class AddAuthorizaionToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_student, :boolean, default: true
    add_column :users, :is_lecturer, :boolean, default: false

    add_column :users, :level, :integer
    add_column :users, :department, :string
    add_column :users, :college, :string
    add_column :users, :hall, :string
    add_column :users, :school, :string
    add_column :users, :program, :string
    add_column :users, :option, :string
  end
end
