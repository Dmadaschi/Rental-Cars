class SubsidiariesController < ApplicationController
  before_action :set_subsidiary, only: [:show]
  def index
    @subsidiaries = Subsidiary.all
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    return redirect_to @subsidiary if @subsidiary.save

    render :new
  end

  def show; end

  private

  def set_subsidiary
    @subsidiary = Subsidiary.find(params.require(:id))
  end

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
end
