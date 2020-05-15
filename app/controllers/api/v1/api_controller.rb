class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameters_missing

  private

  def record_not_found(exeption)
    model_name = exeption.model.constantize.model_name.human
    render json: "Carro não encontrado", status: :not_found
  end

  def parameters_missing
    render json: I18n.t('errors.messages.missing_parameters'),
           status: :unprocessable_entity
  end
end
