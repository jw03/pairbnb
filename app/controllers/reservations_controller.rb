class ReservationsController < ApplicationController

  before_action :require_login, only: [:new, :create]
  #i make sure i log in first before i manage to create new reservation under any public listings

  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    @listing = Listing.find(params[:listing_id])

    #check if check_in, check_out date, in betweeen dates, they r all available
    if available?(@listing, @reservation) #make sure this listing is available based on my check in and check out date
      if @reservation.save
        reserve(@listing, @reservation)
        redirect_to @listing
      else
        render :new
      end
    else
      render :new
    end
    @host = "james.wright037@gmail.com"
    if @reservation.save
      ReservationMailer.notification_email(current_user.email, @host, @reservation.listing.id, @reservation.id).deliver_later
      # ReservationMailer to send a notification email after save
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private
  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :listing_id)
  end

  
  def available?(listing, reservation) # means return true or false
    min = reservation.check_in
    max = reservation.check_out
    num = min
    
    until num == max
      available = listing.available_dates.find_by(date: num).availability
      if available == false
        return false
      end
      num += 1
    end
    return true

  end


  def reserve(listing, reservation) #run this method after @reservation is saved successfully

    min = reservation.check_in
    max = reservation.check_out
    num = min

    until num == max
      available = listing.available_dates.find_by(date: num).availability
      if available == true
        listing.available_dates.find_by(date: num).update(availability: false)
      end
      num += 1
    end
  end

 

end
