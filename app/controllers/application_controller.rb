# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  protect_from_forgery with: :null_session
  before_action :authenticate_api_key

  private

  def authenticate_api_key
    authenticate_or_request_with_http_basic do |api_key, secret_key|
      api_key == Rails.application.secrets.bookstore_api_key && secret_key == Rails.application.secrets.bookstore_secret_key
    end
  end
end
