# encoding: UTF-8
class Workreport < ActiveRecord::Base
  belongs_to :employee
  belongs_to :project
  belongs_to :jobplace
  belongs_to :jobitem
  belongs_to :addcomment
  belongs_to :grade
  #belongs_to :department, :through => :employee

  attr_accessible :comment, :timefrom, :timeto, :workdate, :project_id, :jobplace_id, :jobplace_id, :jobitem_id, :addcomment_id, :employee_id, :grade_id

  validates :workdate, :presence => true
  validates :timefrom, :presence => true
  validates :timeto, :presence => true 
  validates_with TimeDefValidator, :val1 => :timefrom, :val2 => :timeto
end
