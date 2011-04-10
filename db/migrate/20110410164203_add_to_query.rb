class AddToQuery < ActiveRecord::Migration
  def self.up
    add_column :queries, :query_string, :string
    add_column :queries, :ip_address, :string
    add_column :queries, :user_agent, :string

  end

  def self.down
  end
end
