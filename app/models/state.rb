# encoding: UTF-8
class State < ActiveRecord::Base

  has_many :employees

  attr_accessible :stname


  validates :stname, :presence => true
end
