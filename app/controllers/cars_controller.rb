class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
    @car_models = CarModel.all
  end

  def create
    @car = Car.new(car_params)
    return successfully_created if @car.save

    @car_models = CarModel.all
    render :new
  end

  def show
    @car = Car.find(params[:id])
  end

  private

  def successfully_created
    flash[:success] = 'Carro cadastrado com sucesso'
    redirect_to @car
  end

  def car_params
    params.require(:car).permit(:car_model_id, :license_plate,
                                :mileage, :color)
  end
end
