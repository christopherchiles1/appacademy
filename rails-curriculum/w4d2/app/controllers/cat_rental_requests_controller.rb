class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all.sort
    # render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      @cats = Cat.all.sort
      render :new
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat = @cat_rental_request.cat
    @attributes = @cat_rental_request.attributes
    render :show
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat = @cat_rental_request.cat
    @cat_rental_request.approve!
    redirect_to cat_url(@cat)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat = @cat_rental_request.cat
    @cat_rental_request.deny!
    redirect_to cat_url(@cat)
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
