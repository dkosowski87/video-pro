module Videos
  class Upload < BaseOperation
    def call(data)
      form = UploadForm.new(data)
      return Status.failed(form.errors.full_messages) unless form.valid?

      video = create_video(form.title)
      persist_original_video_file(video, form.file)

      video.pending!
      process_video(video)

      Status.success(video)
    end

    private

    def create_video(title)
      Video.create(title: title)
    end

    def persist_original_video_file(video, file)
      VideoFile.create(video: video, file: file, version: :original)
    end

    def process_video(video)
      ProcessingJob.perform_later(video)
    end
  end
end
