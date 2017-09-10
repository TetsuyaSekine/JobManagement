class CodeMst < ApplicationRecord

  has_many :anken, foreign_key: :contents_cd

  validates :category_cd, presence: true
  validates :category_name, presence: true
  validates :contents_cd, presence: true
  validates :contents, presence: true
  validates :del_flg, presence: true

  paginates_per 10
end
