class Tanto < ApplicationRecord
  validates :tanto_name, presence: true
  validates :tanto_name, uniqueness: true
end
