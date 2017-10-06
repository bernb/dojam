class TermlistsController < ApplicationController
  def index
    if not params.key? :termlist_name
      termlist_name = "museum" # ToDo: Do something smarter in that case
    else
      termlist_name = params[:museum]
    end
    
    @title = termlist_name
    
    case termlist_name
    when "museum"
      @objects = Museum.all  
    end
  end
  
  def choose
  
  end
end
