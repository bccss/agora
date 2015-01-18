class TransactionsController < ApplicationController
  include ApplicationHelper 

  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  def show
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
    food = Food.find(params[:transaction][:food_id])
    p food.inspect
    seller = food.seller
    buyer = current_user
    @transaction = Transaction.new(food: food, seller: seller, buyer: buyer)

    package = {
      manifest: "a box of kittens",
      pickup_name: "The Warehouse",
      pickup_address: food.seller_location,
      pickup_phone_number: "555-555-5555",
      pickup_business_name: "Optional Pickup Business Name, Inc.",
      pickup_notes: "Optional note that this is Invoice #123",
      dropoff_name: "Alice",
      dropoff_address: params[:transaction][:buyer_location],
      dropoff_phone_number: "415-555-1234",
      dropoff_business_name: "Optional Dropoff Business Name, Inc.",
      dropoff_notes: "Optional note to ring the bell"
      #quote_id: "dqt_K9LFfpSZCdAJsk" # optional
      }
    p package

    @delivery = PostmatesWrapper.delivery(package)
    p @delivery

    if @transaction.save
      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
      render :new
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
      params[:transaction].permit(:food_id, :buyer_location)
    end
end
