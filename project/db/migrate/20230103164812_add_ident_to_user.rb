class AddIdentToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :Ident, :string
  end
end
