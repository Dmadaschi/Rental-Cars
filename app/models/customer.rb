class Customer < ApplicationRecord
  require "cpf_cnpj"
  validates :name, :document, :email, presence: true
  validates :document, :email, uniqueness: true
  validate :valid_cpf
  
  private

  def valid_cpf 
    return if CPF.valid?(document)

    self.errors[:base] << 'Digite um CPF valido'
  end
end