class API::FoodsController < ApplicationController
  # GET /foods
  # Consider auth tokens for API access
  before_action :authenticate_user_from_token!, except: [:index, :show]

  def index
    @foods = Food.for_sale.all
    render json: @foods
  end

  # POST /foods
  def create
    @food = Food.new(food_params)

    p food_params
    p @food

    if @food.save
      puts " SUCCESSS "
      render json: { success: true, message: "Food was successfully created.", id: @food.id, url: food_path(@food) }
    else
      puts "FAILEEEDDD"
      render json: { success: false, message: "Error" }
    end
  end

  # PATCH/PUT /foods/1
  def update
    if @food.update(food_params)
      render json: { success: true, message: "Food was successfully updated.", id: @food.id, url: food_path(@food) }
    else
      render json: { success: false, message: "Error" }
    end
  end

  # GET /foods/1
  def show
    @food = Food.find(params[:id])
    render json: @food
  end

  # DELETE /foods/1
  # FIXME make this only depend
  def destroy
    @food = Food.find(params[:id])
    if @food.seller == current_user
      @food.destroy
      render json: { success: true, notice: 'Food was successfully destroyed.' }
    else
      render json: { success: false, notice: 'User is not the seller of this food' }
    end
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

  def generate_temporary_file_name
    loop do
      token = SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
      filename = "/lib/temp/#{token}.jpg"
      break filename unless File.exist?(filename)
    end
  end

end
