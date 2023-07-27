class ApplicationService
  def call
    raise NotImplementedError
  end

  def self.call(*args, **options, &block)
    new(*args, **options, &block).call
  end

  private

  def success(data = {})
    {success?: true, data: data, errors: {}}
  end

  def failure(errors = "")
    {success?: false, data: {}, errors: errors}
  end
end