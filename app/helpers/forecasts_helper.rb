module ForecastsHelper
    def loop_values(values)
        result = ""
       values.each {|key,value| result +=  "#{key} : #{value}<br/>"}
       result
    end    
end
