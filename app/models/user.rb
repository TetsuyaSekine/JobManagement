class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_accessor :login

  belongs_to :section

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]
#:confirmable,

  validates :username, uniqueness: {case_sensitive: :false},
            length: {minimum: 4, maximum: 20}
  validates :section_id, presence: true

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)",
        {:value => login }]).first
    else
      where(conditions).first
    end
  end
end
