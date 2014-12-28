require 'sinatra'
require 'json'
require 'rest_client'



get '/' do
	begin
		message=params['txtweb-message'].split(' ')
		if message.length ==2
			
			countryfrom=message[0].upcase
			countryto=message[1].upcase
			parameter="#{countryfrom}_#{countryto}"
			query="http://www.freecurrencyconverterapi.com/api/v2/convert?q=#{parameter}&compact=y"
			api_result = RestClient.get query
			dict_result=JSON.parse(api_result)
			return_val= "1 #{countryfrom} => #{dict_result[parameter]['val']} #{countryto}"
			erb :txtcurrency, :locals => { :returnval => return_val }		
		else
			erb :errorPage
		end
	rescue Exception
		erb:errorPage
	end
end
