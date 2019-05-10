class RepositoriesController < ApplicationController

  def index
# get username
    response = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end

    @body = JSON.parse(response.body)
    session[:username] = @body["login"]
    
# get repos
    repos_response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end

    @repos = JSON.parse(repos_response.body)

  end

  def create
# create a new repo
    response = Faraday.post "https://api.github.com/user/repos",
    {name: params[:name]}.to_json,
    {'Authorization' => "token #{session[:token]}",
    'Accept' => 'application/json'}
    redirect_to '/'
  end

end
