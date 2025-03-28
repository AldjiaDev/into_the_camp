class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:new, :create]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = current_user.reservations
  end

  def show
  end

  def new
    @reservation = @product.reservations.build
  end

  def create
    @reservation = @product.reservations.build(reservation_params)
  @reservation.user = current_user

  # Calculer le total_price basé sur les dates de réservation et le price_per_day du produit
    if @reservation.start_date.present? && @reservation.end_date.present?
      duration = (@reservation.end_date - @reservation.start_date).to_i
      @reservation.total_price = duration * @product.price_per_day
    end

    if @reservation.save
      redirect_to @reservation, notice: "Réservation réussie !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      @reservation.update(status: "confirmed") if @reservation.status == "pending"
      redirect_to @reservation, notice: "Réservation mise à jour !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path, notice: "Réservation supprimée."
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :status)
  end

  # Méthode pour calculer le prix total de la réservation
  def calculate_total_price(start_date, end_date, product)
    # La durée de la réservation (en jours)
    duration = (end_date.to_date - start_date.to_date).to_i
    duration * product.price_per_day
  end
end
