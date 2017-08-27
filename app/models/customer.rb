class Customer < ApplicationRecord

  has_many :anken

  validates :customer, presence: true
  validates :customer, uniqueness: true
end
