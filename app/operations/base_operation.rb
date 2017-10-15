class BaseOperation
  def self.call(*args)
    new.call(*args)
  end

  class Status
    def self.success(value = nil)
      new(status: :success, value: value)
    end

    def self.failed(errors = [])
      new(status: :failed, errors: errors)
    end

    attr_reader :value, :errors

    def initialize(status:, value: nil, errors: [])
      @status = status
      @value = value
      @errors = Array(errors)
    end

    def success?
      @status == :success
    end

    def failed?
      @status == :failed
    end

    def on_success
      yield(value) if @status == :success
    end

    def on_failed
      yield(errors) if @status == :failed
    end
  end
end
