# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def user_root_path
    me_url
  end
end
