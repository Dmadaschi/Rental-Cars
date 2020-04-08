class ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: [
    :show, :edit, :update, :destroy
  ]
  def index
    @manufacturers = Manufacturer.all
  end

  def show    
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      redirect_to @manufacturer
    else
      render :new
    end
  end

  def edit   
  end

  def update
    if @manufacturer.update(manufacturer_params)
      redirect_to @manufacturer
    else
      render :edit
    end
  end

  def destroy
    @manufacturer.destroy!
    redirect_to manufacturers_path
  end

  private

  def set_manufacturer
    @manufacturer = Manufacturer.find(params.require(:id))
  end

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end
