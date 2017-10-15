module Videos
  class ProcessingJob < ApplicationJob
    queue_as :default

    def perform(video)
      ActiveRecord::Base.transaction do
        video.processing!

        operations(video).each do |name, operation|
          result = operation.call

          result.on_success do
            Sidekiq::Logging.logger.info("#{name.to_s.titleize}: completed!")
          end

          result.on_failed do
            video.failed!
            cleanup_after_processing_failed(video)
            expose_error
          end
        end

        video.finished!
      end
    end

    private

    def operations(video)
      {
        transcode_video: -> { Transcode.call(video) },
        extract_metadata_from_video: -> { ExtractMetadata.call(video) },
        take_video_screenshot: -> { TakeScreenshot.call(video) }
      }
    end

    def cleanup_after_processing_failed(video)
      CleanUp.call(video)
    end

    def expose_error
      Sidekiq::Logging.logger.info('Processing failed!')
      raise ActiveRecord::Rollback
    end
  end
end
