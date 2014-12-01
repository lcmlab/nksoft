# encoding: UTF-8
class Department < ActiveRecord::Base

  has_many :employees
  has_many :workreports, :through => :employees

  attr_accessible :dpname


  validates :dpname, :presence => true
end
