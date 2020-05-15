class Api::V1::CarsController < Api::V1::ApiController
  def index
    @cars = Car.all.available
    render json: @cars
  end

  def show
    @car = Car.find(params[:id])
    render json: @car
  end

  def create
    @car = Car.create!(car_params)
    render json: @car, status: :created
  end

  private

  def car_params
    params.require(:car).permit(:license_plate, :mileage, :color, :car_model_id)
  end
end
