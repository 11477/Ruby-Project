class AddUserToPrograms < ActiveRecord::Migration[7.0]
  def change
    add_reference :programs, :user,  foreign_key: true
  end
end
