class PlacesController < ApplicationController

  # Add a filter to authenticate user before any of these actions in the array
  before_action :authenticate_user!, :only => [:create, :new, :edit, :update, :destroy]

  def index
    @places = Place.order(:name).page(params[:page]).per(9)
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.create(place_params)
    
    if @place.valid? 
      redirect_to place_path(@place)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new
  end

  def edit
    @place = Place.find(params[:id])

    # Check to see if user logged in is user that created the place
    if @place.user != current_user 
      return render :text => 'Sorry, you are not allowed to edit places that you did not create.', :status => 'forbidden'
    end
  end

  def update
    @place = Place.find(params[:id])

    # Check to see if user logged in is user that created the place
    if @place.user != current_user
      return render :text => 'Sorry, you are not allowed to edit places that you did not create.', :status => 'forbidden'
    end

    @place.update_attributes(place_params)
    redirect_to root_path
  end

  def destroy
    @place = Place.find(params[:id])

    # Check to see if user logged in is user that created the place
    if @place.user != current_user 
      return render :text => 'Sorry, you are not allowed to edit places that you did not create.', :status => 'forbidden'
    end

    @place.destroy
    redirect_to root_path
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :description)
  end

end
