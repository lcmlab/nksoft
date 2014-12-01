class UpdateMailer < ActionMailer::Base
  #default from: "webmaster@wings.msn.to"
  default from: "sakaguchi.akiyoshi@w3.dion.ne.jp"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.update_mailer.sendmail_change.subject
  #
  def sendmail_change(employee)
    @employee = employee
    @leader = Employee.where(:department_id => employee.department_id, :leader => true).first 
    mail(:to => @leader.email, :subject => 'Status Update')
#debugger # <<< app/mailers/update_mailer.rb def sendmail_change
  #  @greeting = "Hi"

  #  mail to: "to@example.org"
  end
end
