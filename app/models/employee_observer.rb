# encoding: UTF-8
class EmployeeObserver < ActiveRecord::Observer
  def after_save(ep)

#debugger # <<< app/models/employee_observer.rb def after_save

    UpdateMailer.sendmail_change(ep).deliver
  end
end
