class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def postmates_quote
    # Create a new Postmates client
    @client = Postmates.new

    # Set basic config variables
    @client.configure do |config|
      config.api_key = 'b6e0a0b3-2753-4d71-9dc5-ad21840b5ba9'
      config.customer_id = 'cus_KAbBFryghx1Yrk'
    end

    from  = "20 McAllister St, San Francisco, CA"
    to    = "101 Market St, San Francisco, CA"
    quote = @client.quote(pickup_address: from, dropoff_address: to)

    p quote.fee
    p quote.currency
    p format = '%m/%d/%Y %I:%M:%S%p'
    p quote.expires_at.strftime(format)
    p quote.expired?
  end

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
