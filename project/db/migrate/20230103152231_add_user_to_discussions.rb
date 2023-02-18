class AddUserToDiscussions < ActiveRecord::Migration[7.0]
  def change
    add_reference :discussions, :user,  foreign_key: true
  end
end
