class ApplicationController < ActionController::API
  private
  
  def format_errors(errors)
    errors.full_messages.join(', ')
  end
end
