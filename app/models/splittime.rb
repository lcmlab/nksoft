class Splittime < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :projects

  attr_accessible :timesplitmode, :splittime1
  attr_accessible :splittime2, :splittime3
  attr_accessible :splittime4, :splittime5, :splittime6

    validates :timesplitmode, :presence => true
    validates :splittime1, :presence => true
    validates :splittime2, :presence => true
    validates :splittime3, :presence => true
    validates :splittime4, :presence => true
    validates :splittime5, :presence => true
    validates :splittime6, :presence => true

end
