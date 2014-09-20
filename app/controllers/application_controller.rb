class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_start_date
    session[:start_date]
  end

  def current_amount
    session[:amount]
  end

  def current_compare_start_date
    session[:compare_start_date]
  end

  def current_compare_amount
    session[:compare_amount]
  end

end
