class Customer < ApplicationRecord
  require "cpf_cnpj"

  validates :name, :document, :email, :phone,
            :driver_license, :birth_date, presence: true
  validates :document, :email, :driver_license, uniqueness: true
  validate :valid_cpf
  has_many :rentals

  def identification
    "#{name} - #{document}"
  end

  private

  def valid_cpf
    return if CPF.valid?(document)

    self.errors[:document] << 'Digite um CPF valido'
  end
end
