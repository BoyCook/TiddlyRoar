# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem

  # render new.rhtml
  def new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiddlers }
      format.json { render :json => @tiddlers }
    end
  end

  def create
    logout_keeping_session!

    # Dodgy hack for now
    if !params[:user].nil?
      user = User.authenticate(params[:user], params[:password])
    else
      user = User.authenticate(params[:login], params[:password])
    end

    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      #redirect_back_or_default('/')
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => user }
        format.json { render :json => user }
      end
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end

#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @tiddlers }
#      format.json { render :json => @tiddlers }
#    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
