class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def catch_all
    render text: ''
  end

  def remember_param(symbol, default:, never_cache: [])
    skip_remembering = params["dont_remember"] == "1"
    should_remember = params[symbol] &&
      !skip_remembering &&
      !never_cache.include?(params[symbol])
    if should_remember
      session[symbol] = params[symbol]
    end
    params[symbol] || session[symbol] || default
  end

  # Error handling
  rescue_from Exception do |err|
    render status: 500,
           json: {
             error: err.to_s
           }
  end
end
