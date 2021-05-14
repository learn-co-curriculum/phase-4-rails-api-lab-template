class Student < ApplicationRecord
  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false

  def to_s
    "#{first_name} #{last_name}"
  end
end
