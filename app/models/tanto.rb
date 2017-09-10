class Tanto < ApplicationRecord

  has_many :anken

  validates :tanto_name, presence: true
  validates :tanto_name, uniqueness: true

  paginates_per 10
end
