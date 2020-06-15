class RentalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    set_collections
  end

  def create
    @rental = Rental.new(rental_params)
    return successfully_created if @rental.save

    set_collections
    render :new
  end

  def start
    @rental = Rental.find(params[:id])
    car_models = @rental.car_category.car_models
    @available_cars = Car.where(car_model: car_models)
    @add_ons = AddOn.all
    @car_rental = CarRental.new(rental: @rental)
  end

  def search
    @rental = Rental.find_by_code(params[:code])
    return rental_not_found if @rental.nil?

    render :show
  end

  def finish
    @rental = Rental.find(params[:id])
    @car_rental = @rental.car_rental
    @car_rental.finish!

    render :show
  end

  private

  def rental_not_found
    flash[:notice] = "Nenhuma locação encontrada com este código"
    @rentals = Rental.all
    render :index
  end

  def set_collections
    @customers = Customer.all
    @car_categories = CarCategory.all
  end

  def successfully_created
    flash[:success] = 'Locação realizada com sucesso'
    redirect_to rentals_path
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date,
                                   :customer_id, :car_category_id)
  end
end
