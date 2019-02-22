class ResultsController < ApplicationController
  respond_to :html
  
  def index
    @search_results = Quest.search_everywhere(params[:query])
  end
end