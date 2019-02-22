class ResultsController < ApplicationController
  #respond_to :html

  def index
    @search_results = PgSearch.multisearch(params[:query])
  end
end