# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.references :user, foreign_key: true
      t.references :commentable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
