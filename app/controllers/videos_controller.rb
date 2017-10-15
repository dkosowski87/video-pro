class VideosController < ApplicationController
  def new
    render :new, locals: { errors: [] }
  end

  def index
    render :index, locals: { videos: VideoDecorator.decorate_collection(videos) }
  end

  def create
    result = Videos::Upload.call(video_params)
    result.on_success { redirect_to videos_path }
    result.on_failed { |errors| render :new, locals: { errors: errors } }
  end

  def show
    render :show, locals: { video: video }
  end

  private

  def videos
    @videos ||= Video.with_processed_file_data
  end

  def video
    @video ||= Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :file)
  end
end
