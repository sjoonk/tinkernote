class PagesController < ApplicationController
  before_filter :login_required
  before_filter :find_recent #, :only => [:show]

  PER_PAGE = 10

  # def home
  #   if APP_CONFIG[:start_mode] == 'page'
  #     @page = Page.titled(APP_CONFIG[:home_title]).first
  #     unless @page
  #       @page = Page.new(:title => APP_CONFIG[:home_title])
  #       render :action => 'new'
  #     else
  #       @related_pages = @page.related_pages
  #       render :action => 'show'
  #     end
  #   else 
  #     redirect_to pages_path
  #   end
  # end
  
  def index
    if @title = params[:title]
      @pages = Page.titled(@title)
      if @pages.empty?
        @page = Page.new(:title => @title)
        render :action => 'new'
      elsif @pages.size == 1
        @page = @pages.first
        @related_pages = @page.related_pages
        render :action => 'show'  
      end
      @pages = @pages.paginate :page => params[:page], :per_page => PER_PAGE
      @pages_count = Page.count
    else
      @pages = Page.recent.paginate :page => params[:page], :per_page => PER_PAGE
      @pages_count = Page.recent.count
    end
  end

  def show
    @page = Page.find(params[:id])
    @related_pages = @page.related_pages
  end

  def new
    @page = Page.new
  end

  # def edit
  #   show
  #   render :action => 'show'
  # end

  def create
    @page = Page.new(params[:page])
    @page.user = current_user
    if @page.save
      flash[:notice] = '새 페이지가 성공적으로 생성되었습니다.'
      redirect_to @page
    else
      render :action => 'new'
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.user = current_user
    if @page.update_attributes(params[:page])
      #flash[:notice] = '페이지가 잘 저장되었습니다.'
      redirect_to pages_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to pages_url
  end
  
  private
  
  def find_recent
    @recent_pages = Page.recent(10)
  end
end
