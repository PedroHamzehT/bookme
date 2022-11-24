# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def me
    @event_types = current_user.event_types
  end
end
