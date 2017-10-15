class BaseOperation
  def self.call(*args)
    new.call(*args)
  end

  class Status
    def self.success(value = nil) new(status: :success, value: value) end
    def self.failed(error) new(status: :failed, error: error) end

    attr_reader :value, :error

    def initialize(status:, value: nil, error: nil)
      @status = status
      @value = value
      @error = error
    end

    def success?
      @status == :success
    end

    def failed?
      @status == :error
    end

    def on_success
      yield(value) if @status == :success
    end

    def on_failed
      yield(error) if @status == :failed
    end
  end
end
