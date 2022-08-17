class AddStatusToFollows < ActiveRecord::Migration[5.2]
  def change
    add_column :follows, :status, :integer, default: 0
  end
end
