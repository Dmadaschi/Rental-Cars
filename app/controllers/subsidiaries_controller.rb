class SubsidiariesController < ApplicationController
  before_action :set_subsidiary, only: %i[show edit update destroy]
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

  def edit; end

  def update
    return redirect_to @subsidiary if @subsidiary
                                      .update(subsidiary_params)
    render :edit
  end

  def destroy
    @subsidiary.delete
    redirect_to subsidiaries_path
  end

  private

  def set_subsidiary
    @subsidiary = Subsidiary.find(params.require(:id))
  end

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
end
