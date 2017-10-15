CarrierWave.configure do |config|
  config.storage = :file
  if Rails.env.test?
    config.enable_processing = false
    config.root = "#{Rails.root}/spec/support/uploads"
  end
end
