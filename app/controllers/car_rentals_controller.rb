class CarRentalsController < ApplicationController
  def create
    @car_rental = CarRental.new(car_rentals_params)
    @rental = Rental.find(params[:rental_id])
    @car_rental.rental = @rental
    @car_rental.user = current_user
    @car_rental.daily_rate = @rental.car_category.daily_rate
    @rental.ongoing!
    @car_rental.car.rented!
    @car_rental.start_date = Time.zone.now
    @car_rental.save!

    redirect_to @rental
  end

  private

  def car_rentals_params
    params.require(:car_rental).permit(:car_id, add_on_ids: [])
  end
end