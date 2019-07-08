# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :set_referrer

  # Handle authorization exception according to request format
  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'application/json' }
      format.html do
        redirect_to send(@referrer), flash: { error: 'Forbidden' }
      end
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end

  # Dashboard page
  def index; end

  private

  # Set previous referrer URL to the redirect_to method
  def set_referrer
    @referrer = "#{request.referer.presence || 'root'}_path"
  end
end
