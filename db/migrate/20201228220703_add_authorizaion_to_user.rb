class AddAuthorizaionToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_student, :boolean, default: false
    add_column :users, :is_lecturer, :boolean, default: false
  end
end
