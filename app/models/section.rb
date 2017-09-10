class Section < ApplicationRecord
  has_many :user
  has_many :anken, foreign_key: :section_cd

  paginates_per 10
end
