# encoding: UTF-8
class Jobgroup < ActiveRecord::Base

  has_many :jobitems

  attr_accessible :jgname
end
