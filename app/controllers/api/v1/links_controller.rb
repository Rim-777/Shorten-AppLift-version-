class Api::V1::LinksController < Api::V1::BaseController
  before_action :set_link, only: :redirect

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
      @link.add_click
      redirect_to @link.url
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
