require 'sinatra'
require 'json'
require 'rest_client'



get '/convert' do
	message=params['txtweb-message'].split(' ')
	if message.length ==2
		begin
			countryfrom=message[0].upcase
			countryto=message[1].upcase
			parameter="#{countryfrom}_#{countryto}"
			query="http://www.freecurrencyconverterapi.com/api/v2/convert?q=#{parameter}&compact=y"
			api_result = RestClient.get query
			dict_result=JSON.parse(api_result)
			return_val= "1 #{countryfrom} => #{dict_result[parameter]['val']} #{countryto}"
			erb :txtcurrency, :locals => { :returnval => return_val }		
		rescue NameError
			erb :errorPage
		end
	else
		erb :errorPage
	end
end


get '/' do
	erb :errorPage
end
