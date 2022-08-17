class AddPgTrgmExtensionToDb < ActiveRecord::Migration[5.2]
  def change
    execute "CREATE EXTENSION pg_trgm;"
  end
end
