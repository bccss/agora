class API::FoodsController < ApplicationController

  # GET /foods/1
  def show
    @food = Food.find(params[:id])
    render json: @food
  end
end
