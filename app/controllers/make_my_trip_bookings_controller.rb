class MakeMyTripBookingsController < ApplicationController
  def new
  	# @cities = ["Ujjain", "Indore", "Dewas"]
  	@cities = CS.cities(:MP, :IN)
  end

  def search
    boarding_location = params[:boarding_location]
    drop_location = params[:drop_location]
    date = params[:date]

    search_url = "https://www.makemytrip.com/bus/search/#{boarding_location}/#{drop_location}/#{date}"

    redirect_to search_url
  end

  def search_suggestion
  	term = params[:term].downcase
  	a= ["Indore", "Ujjain", "Dewas"]
  	result = a.select { |element| element.downcase.include?("#{term.downcase}") }
  	render json: result
  end
end
