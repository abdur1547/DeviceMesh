# frozen_string_literal: true

module JwtService
  class Decoder < ApplicationService
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def call
      JWT.decode(token, ENV['JWT_SECRET']).first['data']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      nil
    end
  end
end