class Subsidiary < ApplicationRecord
  require "cpf_cnpj"
  validates :name, :cnpj, :address, presence: true
  validates :name, :cnpj, uniqueness: true
  validate :valid_cnpj

  private

  def valid_cnpj 
    return if CNPJ.valid?(cnpj)

    errors[:cnpj] << 'Digite um CNPJ valido'
  end
end
