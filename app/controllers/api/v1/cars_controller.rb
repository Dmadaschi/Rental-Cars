class Api::V1::CarsController < Api::V1::ApiController
  def index
    @cars = Car.all.available
    render json: @cars
  end

  def show
    @car = Car.find(params[:id])
    render json: @car
  rescue ActiveRecord::RecordNotFound
    head 404
  end
end
