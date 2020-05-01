class ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def edit; end

  def show; end

  def index
    @manufacturers = Manufacturer.all
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)  
    return successfully_created if @manufacturer.save

    render :new
  end

  def update   
    return successfully_updated if @manufacturer
                                    .update(manufacturer_params)
    
    render :edit
  end

  def destroy
    @manufacturer.destroy!
    redirect_to manufacturers_path
  end

  private

  def successfully_created
    flash[:success] = 'Fabricante cadastrado com sucesso'
    redirect_to @manufacturer
  end

  def successfully_updated
    flash[:success] = 'Fabricante atualizado com sucesso'
    redirect_to @manufacturer
  end

  def set_manufacturer
    @manufacturer = Manufacturer.find(params.require(:id))
  end

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end
