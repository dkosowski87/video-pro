module Videos
  class CleanUp < BaseOperation
    def call(video)
      clean_up_processed_files(video)
      clean_up_screenshot(video)
      Status.success
    end

    private

    def clean_up_processed_files(video)
      remove_file(video&.processed_file&.file&.current_path)
    end

    def clean_up_screenshot(video)
      remove_file(video&.main_screenshot&.file&.current_path)
    end

    def remove_file(filepath)
      FileUtils.rm_rf(filepath) if filepath
    end
  end
end
