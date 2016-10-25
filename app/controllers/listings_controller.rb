class ListingsController < ApplicationController
  def new
    @listing = Listing.new
  end

  def create #post '/listings' do
    @listing = current_user.listings.new(listing_params)
    start_date = @listing.available_from
    end_date = @listing.available_until
    num = end_date - start_date
    num = num.to_i
    num.times do
      @listing.available_dates << AvailableDate.create(date: start_date)
      start_date += 1
    end
    if @listing.save #happy path
      redirect_to @listing
      # redirect_to listing_path(@listing)
    else
      render :new

      #because rails know i m doing sth abt listings, so rails will go to app/views/listings/new.html.erb

      # #the difference between render :new and
      # redirect_to new_listing_path is:

      # 1) render :new will just load the erb straight away
      # 2) redirect_to new_listing_path, it will go to the new action in this controller and render new.html.erb after that
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def index #app/views/listings/index.html.erb
    @listings = Listing.all
  end

  def edit
    @listing = Listing.find(params[:id])
    if @listing.user == current_user
      render :edit
    else 
      redirect_to sign_in_path
    end
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)
    start_date = @listing.available_from
    end_date = @listing.available_until
    num = end_date - start_date
    num = num.to_i
    num.times do
      @listing.available_dates << AvailableDate.create(date: start_date) 
      start_date += 1
    end
    if @listing.save
      redirect_to @listing # rails knows when u do redirect_to an object, means it will go to the show page of the object (show path means get '/listings/:id')
    else
      render :edit #erb: "listings/edit.html.erb"
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path
  end

  private
  
  def listing_params
    params.require(:listing).permit(:title, :description, :address, :available_from, :available_until, :price_day, {avatars:[]})
  end

end
