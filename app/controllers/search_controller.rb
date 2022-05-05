class SearchController < ApplicationController
  before_action :authorized

  @@action_video = []
  # GET
  def show
    render json: @@action_video
  end

  # POST
  def create
    text = params[:text]
    mensagem(text)
    render json: text
  end

  def mensagem(text)
    @@action_video.push(text)
  end
end