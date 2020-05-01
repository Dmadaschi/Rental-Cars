class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def new
    @rental = Rental.new
    @customers = Customer.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(rental_params)
    return successfully_created if @rental.save
    
    @customers = Customer.all
    @car_categories = CarCategory.all

    render :new
  end

  def search
    @rentals = Rental.where(code: params[:q])
    render :index
  end

  private

  def successfully_created
    flash[:success] = 'Locação realizada com sucesso'
    redirect_to rentals_path
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date,
                                   :customer_id, :car_category_id)
  end
end
  