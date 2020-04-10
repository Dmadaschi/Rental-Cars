class Subsidiary < ApplicationRecord
  require "cpf_cnpj"
  validates :name, :cnpj, :address, presence: true
  validates :name, :cnpj, :address, uniqueness: true
  validate :valid_cnpj
  
  private

  def valid_cnpj 
    return if CNPJ.valid?(cnpj)

    self.errors[:base] << 'Digite um CNPJ valido'
  end
end
