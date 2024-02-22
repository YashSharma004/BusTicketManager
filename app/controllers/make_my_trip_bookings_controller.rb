class MakeMyTripBookingsController < ApplicationController
  def new
  	# @cities = ["Ujjain", "Indore", "Dewas"]
  	@cities = CS.cities(:MP, :IN)
  end

  def search
    boarding_location = params[:boarding_location]
    drop_location = params[:drop_location]
    date = params[:date]

    if boarding_location.present? && drop_location.present? && date.present?
      search_url = "https://www.makemytrip.com/bus/search/#{boarding_location}/#{drop_location}/#{date}"
      redirect_to search_url, notice: "Book ticket here"
    else
      redirect_to make_my_trip_bookings_new_path, notice: "Please add correct search paramaters"
    end
  end

  def search_suggestion
  	term = params[:term].downcase
  	a= ["Indore", "Ujjain", "Dewas"]
  	result = a.select { |element| element.downcase.include?("#{term.downcase}") }
  	render json: result
  end
end
