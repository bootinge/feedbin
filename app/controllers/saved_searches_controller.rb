class SavedSearchesController < ApplicationController
  
  def new
    @saved_search = SavedSearch.new
  end
  
  def show
    @user = current_user
    saved_search = SavedSearch.where(user: @user, id: params[:id]).take!
    params[:query] = saved_search.query
    search_params = build_search(params)
    
    @entries = Entry.search(search_params, @user)
    @entries = update_with_state(@entries)
    @page_query = @entries

    @append = !params[:page].nil?

    @type = 'all'
    @data = nil

    @collection_title = saved_search.name
    @collection_favicon = 'favicon-search'

    respond_to do |format|
      format.js { render partial: 'shared/entries' }
    end
    
  end
  
end
