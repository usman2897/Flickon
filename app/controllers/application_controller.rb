class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :account_seller_signed_in?, :current_account_seller, :account_user_signed_in?, :current_account_user
  protected

  def authenticate_account_seller
    cookies.delete(:seller_id) && redirect_to(root_url) if current_account_seller.blank?
  end

  def current_account_seller
    @current_seller ||= Seller.find_by(seller_id: cookies.signed[:seller_id])
  end

  def account_seller_signed_in?
    current_account_seller.present?
  end

  def authenticate_account_user
    cookies.delete(:user_id) && redirect_to(root_url) if current_account.blank?
  end

  def current_account_user
    @current_user ||= User.find_by(user_id: cookies.signed[:user_id])
  end

  def account_user_signed_in?
    current_account_user.present?
  end
  
end
