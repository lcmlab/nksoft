class Grade < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :workreports

  attr_accessible :gradename, :unitpayment, :unitdemand, :holidayschg

    validates :gradename, :presence => true
    validates :unitpayment, :presence => true
    validates :unitdemand, :presence => true
    validates :holidayschg, :presence => true

end
