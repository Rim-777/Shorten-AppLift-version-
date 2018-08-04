class Api::V1::LinksController < Api::V1::BaseController

  def create
    @link = Link.new(link_params)
    if @link.save
      render json: @link, only: [:url,:shortcode], status: :created
    else
      render json: @link.errors, status: 422
    end
  end

  private
  def link_params
    params.require(:link).permit(:url)
  end
end
