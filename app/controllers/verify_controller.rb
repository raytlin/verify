class VerifyController < ApplicationController
  def index
      require 'net/http'
      require 'uri'
      
      url = URI.parse(params[:url])
      res = Net::HTTP.get_response(url)
      #get if redirect happened
      if res['location']
          #keep requesting until no more redirects
          while res['location'] do
              newURI = URI.parse(res['location'])
              res = Net::HTTP.get_response(URI.parse(res['location']))
          end
          
      else
          newURI = URI.parse(url.scheme + "://" + url.host)
      end
      
      fixedURI = URI.parse(newURI.scheme + "://" + newURI.host + "/favicon.ico")
      
      response = Net::HTTP.get_response(fixedURI)
      
      #get if second redirect happened
      if response['location']
          response = Net::HTTP.get_response(URI.parse(response['location']))
      end
      
      send_data response.body, :type => 'image/png',:disposition => 'inline'

  end
end
