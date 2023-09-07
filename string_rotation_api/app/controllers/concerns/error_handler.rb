# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  class CustomError < StandardError
    attr_reader :status, :code, :message

    def initialize(status = nil, code = nil, message = nil)
      super()
      @status = status || :unprocessable_entity
      @code = code || 422
      @message = message || 'Something went wrong'
    end
  end

  included do
    rescue_from ActiveRecord::RecordInvalid do |e|
      Rails.logger.info e
      flat_messages = e&.record&.errors&.map { |k, v| { k => v } }&.reduce({}, :merge)
      json = error_json(:unprocessable_entity, e, errors: flat_messages || e&.message)
      render json: json, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |e|
      respond(:unprocessable_entity, e)
    end
  end

  private

  def respond(status, message)
    render json: error_json(status, message), status: status
  end

  def code_name_by_status(status)
    code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    name = Rack::Utils::HTTP_STATUS_CODES[code]
    [code, name]
  end

  def error_json(status, error, hash = {})
    code, name = code_name_by_status(status)
    {
      status: code,
      error: name,
      exception: {
        class: error.class.to_s,
        message: error.message,
      },
    }.reverse_merge(hash)
  end
end
