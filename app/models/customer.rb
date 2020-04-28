class Customer < ApplicationRecord
  require "cpf_cnpj"
  validates :name, :document, :email, presence: true
  validates :document, :email, uniqueness: true
  validate :valid_cpf

  def identification
    "#{name} - #{document}"
  end
  
  private

  def valid_cpf 
    return if CPF.valid?(document)

    self.errors[:document] << 'Digite um CPF valido'
  end
end
