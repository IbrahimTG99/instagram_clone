class AddPrivateBooleanToUsers < ActiveRecord::Migration[5.2]
  def change
    # add private boolean to users
    add_column :users, :private, :boolean, default: true
  end
end
