# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :error
  before_action :authenticate_user!
end
