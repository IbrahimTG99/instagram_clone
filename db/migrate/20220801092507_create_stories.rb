class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :caption
      t.references :user

      t.timestamps
    end
  end
end
