require 'sinatra'
require 'rest-client'
require 'json'

get '/oauth' do
    code = params[:code]
    gettoken(code)
end

get '/authenticate' do
    #set the redirect URL to get /oauth
   redirect to("https://account.box.com/api/oauth2/authorize?response_type=code&client_id=uxxx&redirect_uri={your redirect url + /oauth}&state=xxx")
end

def gettoken(code)
    
    res = RestClient.post('https://api.box.com/oauth2/token', {grant_type: 'authorization_code', code: code, client_id: 'xxx', client_secret: 'xxx'})
    parsed = JSON.parse(res.body)    

    begin
    rescue Exception => e
        return e.message
    end
    return "success! your access token is + #{parsed["access_token"]} and refresh token is #{parsed["refresh_token"]}"
end
