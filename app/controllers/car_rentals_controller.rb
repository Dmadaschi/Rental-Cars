class CarRentalsController < ApplicationController
  def create
    @rental = Rental.find(params[:rental_id])
    @car_rental = @rental.build_car_rental(car_rentals_params
                    .merge(user: current_user))

    @car_rental.start!

    redirect_to @rental
  end

  private

  def car_rentals_params
    params.require(:car_rental).permit(:car_id, add_on_ids: [])
  end
end
