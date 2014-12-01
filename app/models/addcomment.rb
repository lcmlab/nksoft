# encoding: UTF-8
class Addcomment < ActiveRecord::Base

  has_many :workreports

  attr_accessible :comment

end
