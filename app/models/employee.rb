# encoding: UTF-8
class Employee < ActiveRecord::Base
   include EmailAddressChecker

  belongs_to :department
  belongs_to :state
  has_many :workreports, dependent: :destroy



  validates :username, :presence => true,
    format: { with: /\A[A-Za-z]\w*\z/, allow_blank: true,
              message: :invalid_user_name },
    length: { minimum: 2, maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 20 }
  validate :check_email
  validates :password, presence: { on: :create },
    confirmation: { allow_blank: true }
  validates :state_id, :presence => true
  validates :location, :presence => true, :length => { :maximum => 20}
  validates :memo, :length => { :maximum => 100}

  attr_accessor :password, :password_confirmation 
  
  ACCESSIBLE_ATTRS = [:username, :password, :name, :email, :department_id,
               :state_id, :location, :memo, :leader, :administrator,
               :password_confirmation ]
  attr_accessible *ACCESSIBLE_ATTRS

  attr_accessor :regist_check

  attr_accessible *(ACCESSIBLE_ATTRS + [:username, :administrator]),
    as: :admin

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end



  private
  def check_email
    if email.present?
      errors.add(:email, :invalid) unless well_formed_as_email_address(email)
    end
  end

  class << self
      def authenticate(username, password)

#debugger # << app/models/employee.rb def authenticate(1)

      employee = find_by_username(username)
      if employee && employee.hashed_password.present? &&
         BCrypt::Password.new(employee.hashed_password) == password
        employee
      else
        nil
      end
    end
  end


end
