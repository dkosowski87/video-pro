module Videos
  class UploadForm < BaseForm
    attribute :title, String
    attribute :video_files, Hash

    validates :title, :video_files, presence: true

    def file
      video_files['file']
    end
  end
end
