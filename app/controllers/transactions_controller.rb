class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def postmates_quote
    from  = "20 McAllister St, San Francisco, CA"
    to    = "101 Market St, San Francisco, CA"
    @quote = $client.quote(pickup_address: from, dropoff_address: to)
  end

  # def postmates_delivery
  #  package = { 
  #           manifest: "a box of kittens",
  #           pickup_name: "The Warehouse",
  #           pickup_address: "20 McAllister St, San Francisco, CA",
  #           pickup_phone_number: "555-555-5555",
  #           pickup_business_name: "Optional Pickup Business Name, Inc.",
  #           pickup_notes: "Optional note that this is Invoice #123",
  #           dropoff_name: "Alice",
  #           dropoff_address: "101 Market St, San Francisco, CA",
  #           dropoff_phone_number: "415-555-1234",
  #           dropoff_business_name: "Optional Dropoff Business Name, Inc.",
  #           dropoff_notes: "Optional note to ring the bell"
  #           #quote_id: "dqt_K9LFfpSZCdAJsk" # optional
  #         }
  #   delivery = @client.create(package)
  # end

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
    @transaction = Transaction.new(transaction_params)

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
      params[:transaction]
    end
end
