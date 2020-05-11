module Api
  module V1
    class CarsController < ActionController::API
      def index
        @cars = Car.all
        render json: @cars, status: :ok
      end
    end
  end
end
