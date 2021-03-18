# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    UnauthenticatedError = Class.new(StandardError)

    rescue_from UnauthenticatedError, with: :handle_not_authenticated

    private

    def authenticate_user
      return unless auth_header

      @current_user = User.find_by(token: auth_token)
    end

    def authenticate_user!
      authenticate_user

      raise(UnauthenticatedError) unless @current_user
    end

    def auth_header
      @auth_header ||= request.headers['Authorization']
    end

    def auth_token
      @auth_token ||= auth_header.split(' ').last
    end

    def handle_not_authenticated
      render json: { message: 'You need to be authenticated for this' },
             status: :unauthorized
    end
  end
end
