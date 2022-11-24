# frozen_string_literal: true

class EventType < ApplicationRecord
  belongs_to :user

  before_create :define_slug

  private

  def define_slug
    self.slug = name.parameterize
  end
end
