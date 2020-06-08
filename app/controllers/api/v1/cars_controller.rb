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

  def status
    @car = Car.find(params[:id])
    return blank_parameter if params[:status].blank?

    return invalid_parameter unless Car.statuses.include?(params[:status])

    @car.status = params[:status]
    @car.save!
    render json: @car, status: :ok
  end

  private

  def invalid_parameter
    render json: { error: 'O status informado não é valido' },
           status: :unprocessable_entity
  end

  def blank_parameter
    render json: @car, status: :unprocessable_entity
  end

  def car_params
    params.require(:car).permit(:license_plate, :mileage, :color, :car_model_id)
  end
end
