class TaggingsController < ApplicationController
  def new
    @tagging = Tagging.new
  end

  def create
    @tagging = Tagging.create(params)
  end

  def destroy

  end
end