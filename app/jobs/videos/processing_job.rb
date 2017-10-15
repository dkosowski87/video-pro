module Videos
  class ProcessingJob < ApplicationJob
    queue_as :default

    def perform(video)
      video.processing!

      transcode_video(video).on_success do |video|
        extract_metadata_from_video(video).on_success do |video|
          take_video_screenshot(video)
        end
      end

      video.finished!
    end

    private

    def transcode_video(video)
      Transcode.call(video)
    end

    def extract_metadata_from_video(video)
      ExtractMetadata.call(video)
    end

    def take_video_screenshot(video)
      TakeScreenshot.call(video)
    end
  end
end
