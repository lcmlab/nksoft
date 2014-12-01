class Client < ActiveRecord::Base

  has_many :projects, dependent: :destroy

  attr_accessible :clientname
end
