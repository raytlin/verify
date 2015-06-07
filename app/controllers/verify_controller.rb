class VerifyController < ApplicationController
  def index
      require 'net/http'
      require 'uri'
      @url = params[:url]
      url = URI.parse(@url)
      res = Net::HTTP.get_response(url)

      if res['location']
          newURI = URI.parse(res['location'])
      else
          newURI = URI.parse(url.scheme + "://" + url.host)
      end
      
      fixedURI = URI.parse(newURI.scheme + "://" + newURI.host + "/favicon.ico")
      stringURL = newURI.scheme + "://" + newURI.host + "/favicon.ico"
      response = Net::HTTP.get_response(fixedURI)
      
      send_data response.body, :type => 'image/png',:disposition => 'inline'

  end
end
