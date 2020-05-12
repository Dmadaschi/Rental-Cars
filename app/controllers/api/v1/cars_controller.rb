class Api::V1::CarsController < Api::V1::ApiController
  def index
    @cars = Car.all.available
    render json: @cars, status: :ok
  end
end
