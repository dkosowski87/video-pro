module Videos
  class UploadForm < BaseForm
    attribute :title, String
    attribute :file, ActionDispatch::Http::UploadedFile

    validates :title, :file, presence: true
  end
end
