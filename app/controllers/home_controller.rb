class HomeController < ApplicationController
  def index
  

    end
    
  def zipcode 
    @zip_query = params[:zipcode]

    require 'net/http'
    require 'json'
    @url = "https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{@zip_query}&distance=25&API_KEY=8DB9DF0D-C3E7-4449-9D20-D4DB7B4AB9BF"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
    
    if @output.empty?
      @final_output = "Error"
    else
      @final_output =  @output[0]['AQI']
    end

   if @final_output == "Error" 
    @api_color = "error"
    @message = "wrong zipcode"
   elsif @final_output <= 50 
    @api_color = "green"
    @message = "Good"
   elsif @final_output > 51 && @final_output <= 100
    @api_color = "yellow"
    @message = "Moderate"
  elsif @final_output > 101 && @final_output <= 150
    @api_color = "orange"
    @message = "Unhealthy for Sensitive Groups"
  elsif @final_output > 151 && @final_output <= 200
    @api_color = "red"
    @message = "Unhealthy"
  elsif @final_output > 201 && @final_output <= 300
    @api_color = "purple"
    @message = "Very Unhealthy"
    
  elsif @final_output > 301 && @final_output <= 500
    @api_color = "maroon"
    @message = "Hazardous"
    end
end
end
