# frozen_string_literal: true

require 'pagy/extras/bootstrap'

module ApplicationHelper
  include Pagy::Frontend

  def show?(form)
    form && action_name == 'show'
  end

  def active_action?(controller)
    'active' if controller.remove('/') == controller_name
  end

  def asset_exist?(path)
    File.exist?(Rails.application
      .root.join('app', 'javascript', 'packs', "#{path}.js"))
  end

  def flashes
    flash.to_hash.slice('alert', 'error', 'notice', 'success')
  end

  def alert_type(flash_type)
    case flash_type
    when 'alert'
      'warning'
    when 'error'
      'danger'
    when 'notice'
      'success'
    when 'success'
      'success'
    else
      'success'
    end
  end

  def status_type(status)
    case status
    when 'review'
      'primary'
    when 'waiting'
      'default'
    when 'completed'
      'success'
    else
      'default'
    end
  end

  def alert_icon(flash_type)
    case flash_type
    when 'alert' || 'error'
      'fas fa-exclamation-triangle'
    when 'notice'
      'fas fa-check'
    when 'success'
      'fas fa-check'
    else
      'fas fa-exclamation-circle'
    end
  end
end
