# frozen_string_literal: true
module JwtService
  class Encoder < ApplicationService
    attr_reader :current_user, :exp

    def initialize(current_user, exp: Time.now.to_i + Constants::SESSION_LIFETIME)
      @current_user = current_user
      @exp = exp
    end

    def call
      JWT.encode(
        {
          data: {
            user_id: current_user.id,
          },
          exp: exp
        },
        ENV['JWT_SECRET']
      )
    end
  end
end