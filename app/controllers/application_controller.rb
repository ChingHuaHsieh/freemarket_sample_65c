class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?

  def index
    render html: "hello world"
  end

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["hello world"] && password == ENV["6565"]
    end
  end
end
