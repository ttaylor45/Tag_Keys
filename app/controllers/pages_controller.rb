class PagesController < ApplicationController
  def show
    @page_content = PageContent.find_by!(page_key: params[:page_key])
  end
end