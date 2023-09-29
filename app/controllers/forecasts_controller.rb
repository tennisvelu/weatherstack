class ForecastsController < ApplicationController
    def index
      
    end
      
    def detail_page
      @address = params[:address]
  
      # Check the cache for existing data
      cached_forecast = CachedForecast.find_by(zip_code: @address)
      if cached_forecast && cached_forecast.expires_at > Time.now
        @forecast = JSON.parse(cached_forecast.data)
        @cached = true
      else
        # Fetch data from Geocoder
        
        coordinates = Geocoder.coordinates(@address)
        if coordinates.nil?
          @error_message = "Address not found."
          return
        end
        # Fetch weather data from OpenWeatherMap API
        #response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?lat=#{coordinates[0]}&lon=#{coordinates[1]}&appid=#{OpenWeatherMapAPI_KEY}&units=metric")
        #response = HTTParty.get("https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m")
        response = HTTParty.get("http://api.weatherstack.com/current?access_key=#{ENV['API_KEY']}&query=#{@address}")
        if response.code == 200
          @forecast = JSON.parse(response.body)
          # Cache the forecast data for 30 minutes
          CachedForecast.create(zip_code: @address, data: response.body, expires_at: 30.minutes.from_now)
        else
          @error_message = "Error fetching weather data."
        end
      end
    end
  end
  