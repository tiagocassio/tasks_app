# frozen_string_literal: true

module Sluggable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :slug, use: :slugged
    before_create :generate_slug
  end

  private

  def generate_slug
    self.slug = SecureRandom.uuid.delete('-') if slug.blank?
  end
end
