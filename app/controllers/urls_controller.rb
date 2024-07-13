class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    url_service = UrlShortenerService.new(url_params[:long_url])
    @url = url_service.call
    if @url.nil?
      Rails.logger.error "Failed to create URL. Errors: #{url_service.errors.join(', ')}"
      render :new
    elsif @url.persisted?
      Rails.logger.info "URL persisted: #{@url.inspect}"
      redirect_to url_path(@url.short_code), notice: "Short URL: #{shortened_url_path(@url.short_code)}"
    else
      Rails.logger.error "URL not persisted: #{@url.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def show
    @url = Url.find_by(short_code: params[:id])
    if @url.nil?
      Rails.logger.error "URL not found for short_code: #{params[:id]}"
      render html: '<h1>404 Not Found</h1>', status: :not_found
    end
  end

  def redirect
    @url = Url.find_by(short_code: params[:short_code])
    if @url
      click = Click.new(url: @url, remote_ip: request.remote_ip)
      click.save!
      redirect_to @url.long_url, allow_other_host: true
    else
      Rails.logger.error "URL not found for short_code: #{params[:short_code]}"
      render html: '<h1>404 Not Found</h1>', status: :not_found
    end
  end

  def report
    @urls = Url.includes(:clicks)
  end

  private

  def url_params
    params.require(:url).permit(:long_url)
  end
end
