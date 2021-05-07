class Request < ApplicationRecord
  has_many :confirmations

  validates :bio, length: { maximum: 400 }
  validates :name, :email, :phone, :bio, presence: true
  validates :email, format: { with: /[\w|.]+@\w+\.\w{2,5}/, message: "Not a valid email" }
  validates :phone, format: { with: /\A(\+|0)\d+\z/, message: "Optional leading + and digits only please" }

  def accept!
    update(accepted_at: Time.now)
  end

  def self.unconfirmed
    Request.where(confirmed: false, accepted_at: nil, expired_at: nil)
  end

  def self.confirmed
    Request.where(confirmed: true, accepted_at: nil, expired_at: nil)
  end

  def self.accepted
    Request.where.not(accepted_at: nil)
  end

  def self.expired
    Request.where.not(expired_at: nil)
  end
end
