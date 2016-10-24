require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address_without_spaces

    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    @lat = latitude
    @lng = longitude

    url = "https://api.darksky.net/forecast/d41d1e42efd73892fc4f0d478126952c/" + @lat.to_s + "," + @lng.to_s
    parsed_data = JSON.parse(open(url).read)


    summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]
    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes
    summary_of_next_several_hours = parsed_data["hourly"]["summary"]
    @summary_of_next_several_hours = summary_of_next_several_hours
    summary_of_next_several_days = parsed_data["daily"]["summary"]
    @summary_of_next_several_days = summary_of_next_several_days

    current_temperature = parsed_data["currently"]["temperature"]
    current_summary = parsed_data["currently"]["summary"]
    @current_temperature = current_temperature 
    @current_summary = current_summary
    summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]
    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes
    summary_of_next_several_hours = parsed_data["hourly"]["summary"]
    @summary_of_next_several_hours = summary_of_next_several_hours
    summary_of_next_several_days = parsed_data["daily"]["summary"]
    @summary_of_next_several_days = summary_of_next_several_days

    render("meteorologist/street_to_weather.html.erb")
  end
end
