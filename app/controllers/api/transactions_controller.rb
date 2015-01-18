class API::TransactionsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user_from_token!#, except: [:index, :show]

  # GET /foods/1
  def show
  end

  def create
    # README: Instead of params[:transaction] like standard controller,
    # This API controller removes the nested hash
    food = Food.find(params[:food_id])
    food.sell!
    seller = food.seller
    buyer = current_user
    food.buyer = buyer
    food.save
    @transaction = Transaction.new(food: food, seller: seller, buyer: buyer)

    package = {
      manifest: food.name,
      pickup_name: "Seller Name",
      pickup_address: food.seller_location,
      pickup_phone_number: "555-123-1234",
      # pickup_business_name: "",
      # pickup_notes: "Optional note that this is Invoice #123",
      dropoff_name: "Buyer Name",
      dropoff_address: params[:buyer_location],
      dropoff_phone_number: "555-123-1234",
      # dropoff_business_name: "Optional Dropoff Business Name, Inc.",
      # dropoff_notes: "Optional note to ring the bell"
    }
    if params[:quote_id]
      package[:quote_id] = params[:quote_id]
    end

    @delivery = PostmatesWrapper.delivery(package)

    if @transaction.save
      render json: { success: true, message: "Transaction was successfully created.", transaction_id: @transaction.id, url: transaction_path(@transaction), delivery_id: @delivery.id }
    else
      render json: { success: false, message: "Error" }
    end
  end
end
