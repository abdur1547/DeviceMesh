class ApplicationService
  class << self
    def call(*args, &)
      service = new(*args, &)
      service.call
      service
    end
  end

  attr_reader :result

  def call; end

  def success?
    errors.empty?
  end

  def errors
    @errors ||= []
  end
end
