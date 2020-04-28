class CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
  end
  
  def new
    @car_model = CarModel.new
    set_collections
  end

  def create
    @car_model = CarModel.new(car_model_params)
    return successfully_created if @car_model.save
    
    set_collections
    render :new
  end

  private

  def successfully_created
    flash[:success] = 'Modelo de carro cadastrado com sucesso'
    redirect_to car_models_path
  end

  def set_collections
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end

  def car_model_params
    params.require(:car_model).permit(:name,
                                      :year,
                                      :motorization,
                                      :fuel_type,
                                      :manufacturer_id,
                                      :car_category_id)
  end
end