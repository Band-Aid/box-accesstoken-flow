require 'sinatra'
require 'rest-client'
require 'json'

get '/authenticate' do
    #set the redirect URL to get /oauth
   redirect to("https://account.box.com/api/oauth2/authorize?response_type=code&client_id={your client ID}&redirect_uri={your redirect url + /oauth}&state={your client secret}")
end

get '/oauth' do #get token using auth code
    
    code = params[:code]
    gettoken(code)
end

def gettoken(code) #exchange access token pair with auth-code
    begin
    res = RestClient.post('https://api.box.com/oauth2/token', {grant_type: 'authorization_code', code: code, client_id: '{your client ID}', client_secret: '{your client secret}'})
    parsed = JSON.parse(res.body)    

    
    rescue Exception => e
        return e.message
    end
    return "success! your access token is + #{parsed["access_token"]} and refresh token is #{parsed["refresh_token"]}"
end
