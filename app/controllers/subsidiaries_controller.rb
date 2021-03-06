class SubsidiariesController < ApplicationController
  before_action :set_subsidiary, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def show; end

  def edit; end

  def index
    @subsidiaries = Subsidiary.all
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    return successfully_created if @subsidiary.save

    render :new
  end

  def update
    return successfully_updated if @subsidiary
                                    .update(subsidiary_params)

    render :edit
  end

  def destroy
    @subsidiary.delete
    redirect_to subsidiaries_path
  end

  private

  def successfully_created
    flash[:success] = 'Filial cadastrada com sucesso'
    redirect_to @subsidiary
  end

  def successfully_updated
    flash[:success] = 'Filial atualizada com sucesso'
    redirect_to @subsidiary
  end

  def set_subsidiary
    @subsidiary = Subsidiary.find(params.require(:id))
  end

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
end
