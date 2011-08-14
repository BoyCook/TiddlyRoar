require 'logger'

class TiddlersController < ApplicationController
  #before_filter :login_required , :only => [:new, :create, :edit, :update, :destroy]
  # GET /tiddlers
  # GET /tiddlers.xml
  def index
    @tiddlers = Tiddler.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiddlers }
      format.json { render :json => @tiddlers }
    end
  end

  # GET /tiddlers/1
  # GET /tiddlers/1.xml
  def show
    if !params[:title].nil?
      @tiddler = Tiddler.find_by_title(params[:title])
    end

    # If it's a number
    if params[:id] =~ /^[0-9]*$/
      @tiddler = Tiddler.find(params[:id])
    else
      @tiddler = Tiddler.find_by_title(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiddler }
      format.json { render :json => @tiddler }
    end
  end

  # GET /tiddlers/new
  # GET /tiddlers/new.xml
  def new
    @tiddler = Tiddler.new(params[:tiddler])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiddler }
      format.json { render :json => @tiddler }
    end
  end

  # GET /tiddlers/1/edit
  def edit
    gettiddler
  end

  # POST /tiddlers
  # POST /tiddlers.xml
  def create
    @tiddler = Tiddler.new(params[:tiddler])
    checkparams

    respond_to do |format|
      if @tiddler.save
        flash[:notice] = 'Tiddler was successfully created.'
        format.html { redirect_to(@tiddler) }
        format.xml  { render :xml => @tiddler, :status => :created, :location => @tiddler }
        format.json { render :json => @tiddler, :status => :created, :location => @tiddler }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiddler.errors, :status => :unprocessable_entity }
        format.json { render :json => @tiddler.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiddlers/1
  # PUT /tiddlers/1.xml
  def update
    @tiddler = Tiddler.find_by_title(params[:title])

    respond_to do |format|
      #@tiddler.update_attributes(params[:text])
      #@tiddler.update_attributes(params[:tags])

      if @tiddler.update_attributes(params[:tiddler])
        flash[:notice] = 'Tiddler was successfully updated.'
        format.html { redirect_to(@tiddler) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiddler.errors, :status => :unprocessable_entity }
        format.json { render :json => @tiddler.errors, :status => :unprocessable_entity }
      end
    end
  end

  #TODO there must be a better way to do this
  def checkparams
    if @tiddler.nil? or @tiddler.title.nil?
      @tiddler.title = params[:title]
      @tiddler.text = params[:text]
      @tiddler.tags = params[:tags]
      fields = params[:fields]
      workspace = fields["server.workspace"]
      bag = workspace.slice(workspace.index('/') + 1, workspace.length)
      puts "CRAIG Field bag: " + bag
      @tiddler.bag = bag
      @tiddler.modifier = params[:modifier]
    end
  end

  def gettiddler
    if !params[:title].nil?
      @tiddler = Tiddler.find_by_title(params[:title])
    end

    if params[:id] =~ /^[0-9]*$/
      @tiddler = Tiddler.find(params[:id])
    else
      @tiddler = Tiddler.find_by_title(params[:id])
    end
  end

  # DELETE /tiddlers/1
  # DELETE /tiddlers/1.xml
  def destroy
    gettiddler
    @tiddler.destroy

    respond_to do |format|
      format.html { redirect_to(tiddlers_url) }
      format.xml  { head :ok }
    end
  end
end