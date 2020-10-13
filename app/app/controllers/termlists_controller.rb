class TermlistsController < ApplicationController
  def index
    if not params.key? :termlist_name
      flash[:danger] = t('no termlist name given')
      redirect_to root_path
    else
      termlist_name = params[:termlist_name]
    end
    
    @title = params[:nice_name]
    
    table_string = termlist_name.gsub("_"," ").titleize.gsub(" ","").singularize
    
    @objects = table_string.constantize.all
  end

  def show
    @term = Termlist.find params[:id]
  end
  
  def choose
    @termlists = get_termlist_names_from ActiveRecord::Base.connection.tables
  end
  
  private
  
  def get_termlist_names_from tables_array
    tables_array.select {|element| element.start_with? "termlist_"}
  end
end
