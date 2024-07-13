class ReportsController < ApplicationController
  def index
    @clicks = Click.includes(:url).all
  end
end
