class Api::V1::LinksController < Api::V1::BaseController
  before_action :set_link, except: :create

  def create
    @link = Link.new(link_params)
    if @link.save
      render json: @link, only: [:url, :shortcode], status: :created
    else
      render json: @link.errors, status: 422
    end
  end

  def redirect
    if @link.present?
      @link.clicks.create
      redirect_to @link.url
    else
      head 404
    end
  end

  def stats
    if @link.present?
      start_time = params[:start_time].try(:to_datetime)
      end_time = params[:end_time].try(:to_datetime) || DateTime.now
      render json: {clicks: @link.stats(start_time, end_time)}, status: :ok
    else
      head 404
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def set_link
    @link = Link.find_by_shortcode(params[:shortcode])
  end
end
