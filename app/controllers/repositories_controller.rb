class RepositoriesController < ApplicationController

  def index
    user_resp = Faraday.get ("https://api.github.com/user") do |req|
        req.headers['Authorization'] = "token #{session[:token]}"
        req.headers['accept'] = 'application/json'
    end
    @body = JSON.parse(user_resp.body)

    repos_response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end
    @repos_body = JSON.parse(repos_response.body)
#binding.pry
  end #end of index



end #end of controller
