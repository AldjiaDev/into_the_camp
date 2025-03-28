class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validates :total_price, numericality: { greater_than: 0 }

  private

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "doit être après la date de début")
    end
  end
end
