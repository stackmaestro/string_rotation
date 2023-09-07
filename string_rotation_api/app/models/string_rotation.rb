# frozen_string_literal: true

class StringRotation < ApplicationRecord
  validates :original_string, length: { maximum: 1000 }, allow_blank: false

  before_create :rotate_string

  private

  def rotate_string
    from = [*'a'..'z', *'A'..'Z']
    to = [*'n'..'z', *'a'..'m', *'N'..'Z', *'A'..'M']
    cipher = from.zip(to).to_h
    self.rot_string = original_string.gsub(/[a-zA-Z]/, cipher)
  end
end
