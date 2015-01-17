class API::FoodsController < ApplicationController
  # GET /foods
  def index
    @foods = Food.for_sale.all
    render json: @foods
  end

  # GET /foods/1
  def show
    @food = Food.find(params[:id])
    render json: @food
  end
end
