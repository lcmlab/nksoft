# encoding: UTF-8
class Project < ActiveRecord::Base
  belongs_to :client
  has_many :workreports
  belongs_to :splittime

  attr_accessible :prjname, :client_id, :splittime_id
end
