class PlantsController < ApplicationController
  def index
    plants = Plant.all
    render json: plants
  end

  def show
    plant = Plant.find(params[:id])
    render json: plant
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Plant not found' }, status: :not_found
  end

  def create
    plant = Plant.create(plant_params)
    if plant.valid?
      render json: plant, status: :created
    else
      render json: { errors: plant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :image, :price)
  end
end
