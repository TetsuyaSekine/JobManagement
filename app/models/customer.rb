class Customer < ApplicationRecord

  has_many :anken

  validates :customer, presence: true
  validates :customer, uniqueness: true

  paginates_per 10
end
