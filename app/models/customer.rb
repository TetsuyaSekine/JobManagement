class Customer < ApplicationRecord
  validates :customer, presence: true
  validates :customer, uniqueness: true
end
