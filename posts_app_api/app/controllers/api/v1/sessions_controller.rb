# frozen_string_literal: true

module Api
  module V1
    class SessionsController < BaseController
      def create
        user = User.find_by(email: params[:email])
        raise UnauthenticatedError unless user

        render json: { token: user.token }
      end
    end
  end
end
