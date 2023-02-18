class CreateDiscussions < ActiveRecord::Migration[7.0]
  def change
    create_table :discussions do |t|
      t.references :program, null: false, foreign_key: true
      t.string :content
      t.string :text

      t.timestamps
    end
  end
end
