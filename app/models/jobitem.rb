# encoding: UTF-8
class Jobitem < ActiveRecord::Base
  belongs_to :jobgroup
  has_many :workreports

  attr_accessible :jobname, :jobgroup_id

  validates :jobname, :presence => true
  validates :jobgroup_id, :presence => true


end
