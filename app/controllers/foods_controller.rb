class FoodsController < ApplicationController
  include ApplicationHelper
  before_action :set_food, only: [:show, :edit, :update, :destroy, :quote]
  before_action :authenticate_user!, except: [:index, :show, :quote]

  # GET /foods
  def index
    if params[:search]
      # FIXME: This needs to be for_sale scoped
      @foods = Food.search(params[:search])
      @foods_title = "Search results for \""+params[:search]+"\""
    else
      @foods = Food.for_sale.all
      @foods_title = "Foods for sale"
    end
  end

  # GET /foods/1
  def show
  end

  # GET /foods/1/quote
  def quote
    seller_location = @food.seller_location
    buyer_location = params[:buyer_location]
    @quote = PostmatesWrapper.quote(seller_location, buyer_location)
    respond_to do |format|
      format.json { render json: @quote }
    end
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods
  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to @food, notice: 'Food was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /foods/1
  def update
    if @food.update(food_params)
      redirect_to @food, notice: 'Food was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /foods/1
  def destroy
    @food.destroy
    redirect_to foods_url, notice: 'Food was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def food_params
      params[:food].permit(:name, :price, :image, :seller_id, :seller_location)
    end
end
