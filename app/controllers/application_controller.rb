class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :account_signed_in?, :current_account

  protected

  def authenticate_account
    cookies.delete(:seller_id) && redirect_to(root_url) if current_account.blank?
  end

  def current_account
    @current_account ||= Seller.find_by(id: cookies.signed[:seller_id])
  end

  def account_signed_in?
    current_account.present?
  end  
end
