class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :recoverable, 
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :daily_activities, dependent: :destroy

  validates :first_name, :last_name, format: { with: /\A[a-zA-Z\s]+\z/}, presence: true
  validates :middle_name, format: { with: /\A[a-zA-Z\s]+\z/, allow_blank: true}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: {case_sensitive: true}
  validates :password, format: PASSWORD_REQUIREMENTS, length: { maximum: 32 }, allow_blank: false, if: -> { new_record? }
  validates_date :birthday, :on_or_before => lambda { Date.current }, presence: true
  validates :username, presence: true, uniqueness: {case_sensitive: true}

  def fullname
    full_name(first_name: self.first_name, middle_name: self.middle_name, last_name: self.last_name)
  end

  def birthday_format
    date_format(date: self.birthday)
  end

  def created_at_format
    datetime_format(datetime: self.created_at)
  end
end
