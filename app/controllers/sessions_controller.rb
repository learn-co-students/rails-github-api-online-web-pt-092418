class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  # skip_before_action :authenticate_user, only: :create

# Users are redirected back to your site by GitHub
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {'client_id': ENV['CLIENT_ID'], 'client_secret': ENV['CLIENT_SECRET'], 'code': params[:code]}
      req.headers['accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
