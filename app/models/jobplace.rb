# encoding: UTF-8
class Jobplace < ActiveRecord::Base

  has_many:workreport

  attr_accessible :jobplacename
end
