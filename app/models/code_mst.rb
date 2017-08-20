class CodeMst < ApplicationRecord
  validates :category_cd, presence: true
  validates :category_name, presence: true
  validates :contents_cd, presence: true
  validates :contents, presence: true
  validates :del_flg, presence: true
end
