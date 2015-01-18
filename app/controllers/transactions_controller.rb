class TransactionsController < ApplicationController
  include ApplicationHelper

  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /transactions/1
  def show
    # PostmatesWrapper.quote
  end

  # GET /transactions/1/status
  def status
    @transaction = Transaction.find(params[:id])
    if !(current_user == @transaction.seller || current_user == @transaction.buyer)
      respond_to do |format|
        format.json { render json: { success: false, message: "Unauthorized" } }
      end
    end
    p @transaction.delivery_id
    delivery = PostmatesWrapper.retrieve(@transaction.delivery_id)
    respond_to do |format|
      format.json { render json: delivery }
    end
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  def create
    @food = Food.find(params[:transaction][:food_id])
    # TODO: Food.sell in API as well!!!
    @food.sell!
    seller = @food.seller
    buyer = current_user
    @food.buyer = buyer
    @food.save
    @transaction = Transaction.new(food: @food, seller: seller, buyer: buyer)

    package = {
      manifest: @food.name,
      pickup_name: "Seller Name",
      pickup_address: @food.seller_location,
      pickup_phone_number: "555-123-1234",
      # pickup_business_name: "",
      # pickup_notes: "Optional note that this is Invoice #123",
      dropoff_name: "Buyer Name",
      dropoff_address: params[:transaction][:buyer_location],
      dropoff_phone_number: "555-123-1234",
      # dropoff_business_name: "Optional Dropoff Business Name, Inc.",
      # dropoff_notes: "Optional note to ring the bell"
    }
    if params[:transaction][:quote_id]
      package[:quote_id] = params[:transaction][:quote_id]
    end

    @delivery = PostmatesWrapper.delivery(package)

    @transaction.delivery_id = @delivery.id

    if @transaction.save
      redirect_to @food, notice: "You've ordered this item!"
    else
      redirect_to @food, notice: "There was an error processing your purchase"
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
    redirect_to transactions_url, notice: 'Transaction was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params[:transaction].permit(:food_id, :buyer_location, :quote_id)
    end
end
