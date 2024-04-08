class RewardsController < ApplicationController
  before_action :set_reward, only: %i[ show edit update destroy ]

  # GET /rewards or /rewards.json
  def index
    @user_points = current_user.points.sum(:points)
    @rewards = Reward.select("rewards.*, #{@user_points} >= points_required AS eligible")
    render json:@rewards
  end

  # GET /rewards/1 or /rewards/1.json
  def show
  end

  # GET /rewards/new
  def new
    @reward = Reward.new
  end

  # GET /rewards/1/edit
  def edit
  end

  # POST /rewards or /rewards.json
  def create
    @reward = Reward.new(reward_params)

      if @reward.save
        render json: @reward
      else
         render json: @reward.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /rewards/1 or /rewards/1.json
  def update
    respond_to do |format|
      if @reward.update(reward_params)
        render json: @reward
      else
         render json: @reward.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /rewards/1 or /rewards/1.json
  def destroy
  
    begin
      @reward.destroy!  
      render json: { message: "Reward successfully destroyed!" }, status: :no_content 
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: "Reward not found!" }, status: :not_found 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reward
      @reward = Reward.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reward_params
      params.require(:reward).permit(:name, :description, :points_required)
    end
end
