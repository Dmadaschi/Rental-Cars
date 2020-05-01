class CustomersController < ApplicationController
  before_action :authenticate_user!

  def show
    @customer = Customer.find(params.require(:id))
  end

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    return successfully_created if @customer.save

    render :new
  end
  
  private

  def successfully_created
    flash[:success] = 'Cliente cadastrado com sucesso'
    redirect_to @customer
  end

  def customer_params
    params.require(:customer).permit(:name, 
                                     :email, 
                                     :document)
  end
end
