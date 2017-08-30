class Anken < ApplicationRecord

  has_many :comment, -> {order("ymd DESC")} 
  belongs_to :customer
  belongs_to :tanto
  belongs_to :code_mst, foreign_key: :anken_status_cd

  validates :customer_id, presence: true
  validates :anken_name, presence: true
  validates :anken_summary, presence: true
  validates :anken_status_cd, presence: true
  validates :anken_ball_cd, presence: true
  validates :tanto_id, presence: true

  scope :get_by_name, ->(anken_name) {where("anken_name like ?", "#{anken_name}%") if anken_name.present? }
  scope :get_by_summary, ->(anken_summary) {where("anken_summary like ?", "#{anken_summary}%") if anken_summary.present? }
  scope :get_by_customer_id, ->(customer_id) {where("customer_id = ?", "#{customer_id}") if customer_id.present? }
  scope :get_by_tanto_id, ->(tanto_id) {where("tanto_id = ?", "#{tanto_id}") if tanto_id.present? }
  scope :get_by_anken_status_cd, ->(anken_status_cd) {where(anken_status_cd: anken_status_cd ) if anken_status_cd.present? } 
end
