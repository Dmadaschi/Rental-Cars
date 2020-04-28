class CarCategoriesController < ApplicationController
  before_action :set_car_category, only: %i[show]

  def show; end

  def index
    @car_categories = CarCategory.all
  end

  def new
    @car_category = CarCategory.new
  end

  def create
    @car_category = CarCategory.new(car_category_params)
    return successfully_created if @car_category.save

    render :new
  end
  
  private

  def successfully_created
    flash[:success] = 'Categoria de carro cadastrada com sucesso'
    redirect_to @car_category
  end

  def set_car_category
    @car_category = CarCategory.find(params.require(:id))
  end

  def car_category_params
    params.require(:car_category).permit(:name, 
                                         :daily_rate, 
                                         :car_insurance, 
                                         :third_part_insurance)
  end
end
