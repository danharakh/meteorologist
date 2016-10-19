require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.

    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
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

    if parsed_data["results"].length == 0
      @latitude = 0
      @longitude = 0
    else
      @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
      @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    end

    render("geocoding/street_to_coords.html.erb")
  end
end
