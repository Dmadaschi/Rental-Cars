class RentalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rentals = Rental.all
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

  def search
    @rentals = [Rental.find_by_code(params[:code])]
    render :index
  end

  private

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
  