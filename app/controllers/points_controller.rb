class PointsController < ApplicationController
  before_action :set_point, only: %i[ show  ]

  def index
    @points = Point.where(user:current_user)
    # byebug
      render json: @points 

  end

  def show
      render json: @point 
  end
  private
    def set_point
      @point = Point.find(params[:id])
    end

    
end
