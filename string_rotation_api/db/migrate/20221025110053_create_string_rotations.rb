# frozen_string_literal: true

class CreateStringRotations < ActiveRecord::Migration[6.1]
  def change
    create_table :string_rotations do |t|
      t.string :original_string, null: false
      t.string :rot_string, null: false
      t.timestamps
    end
  end
end
