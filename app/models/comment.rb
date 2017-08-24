class Comment < ApplicationRecord

  belongs_to :anken

  validates :ymd, presence: true
  validates :anken_comment, presence: true

end
