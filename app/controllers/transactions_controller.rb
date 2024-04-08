class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show  ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

 

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id  # Assuming you have current_user method
    respond_to do |format|
      if @transaction.save
        points = calculate_points(@transaction.amount, transaction_params[:foreign_transaction])
    # byebug

        Point.create(user: current_user, related_transaction: @transaction, points: points)
        format.json { render :show, status: :created, location: @transaction }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
    def calculate_points(amount, foreign_transaction)
      base_points_per_dollar = 0.1 
      foreign_currency_multiplier = 2  
    
      points = amount * base_points_per_dollar 
      points = points*foreign_currency_multiplier if foreign_transaction
    
      points.round 
    end

      # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

      # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit( :amount, :currency)
    end

end
