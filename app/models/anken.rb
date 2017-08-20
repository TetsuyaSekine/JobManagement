class Anken < ApplicationRecord
  validates :customer_id, presence: true
  validates :anken_name, presence: true
  validates :anken_summary, presence: true
  validates :anken_status_cd, presence: true
  validates :anken_ball_cd, presence: true
  validates :tanto_id, presence: true
end
