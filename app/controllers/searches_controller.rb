class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @word = params[:word]
    @search = params[:search]
    
    if @model == 'User'
      @records = User.looks(@search, @word)
    else
      @records = Book.looks(@search, @word)
    end
  end
end
