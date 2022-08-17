class AddStatusToFollows < ActiveRecord::Migration[5.2]
  def change
    # status boolean column added to follows table
    add_column :follows, :status, :boolean, default: false
  end
end
