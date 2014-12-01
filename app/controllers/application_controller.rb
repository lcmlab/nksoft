class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :basic_auth
  before_filter :authorize


  class Forbidden < StandardError; end
  class NotFound < StandardError; end


  private

  def authorize
    if session[:employee_id]
      @current_employee = Employee.find_by_id(session[:employee_id])

      session[:user_id] = @current_employee.id
      session[:department_id] = @current_employee.department_id

      session.delete(:employee_id) unless @current_employee
      session.delete(:user_id) unless @current_employee
    end
  end

  def login_required
    raise Forbidden unless @current_employee
  end


  if Rails.env.production?
    rescue_from Exception, with: :rescue_500
    rescue_from ActionController::RoutingError, with: :rescue_404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_404
  end

  rescue_from Forbidden, with: :rescue_403
  rescue_from NotFound, with: :rescue_404

  def rescue_403(exception)
    render "errors/forbidden", status: 403, layout: "error"
  end

  def rescue_404(exception)
    render "errors/not_found", status: 404, layout: "error"
  end

  def rescue_500(exception)
    render "errors/internal_server_error", status: 500, layout: "error"
  end






# 以下のbasic_authメソッドはNKSOFTオリジナルで使用されているものです。
  def basic_auth
    authenticate_or_request_with_http_basic('Nksoft') do |id, pass|
      e = Employee.where(:username => id,
        :password => Digest::SHA1.hexdigest(pass)).first
      if e
        session[:user_id] = e.id
        session[:department_id] = e.department_id
        return true
      end
    end
  end




end
