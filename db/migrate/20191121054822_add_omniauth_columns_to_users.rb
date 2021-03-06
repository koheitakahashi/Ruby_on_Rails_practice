# frozen_string_literal: true

class AddOmniauthColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string

    add_index :users, [:uid, :provider], unique: true
  end
end
