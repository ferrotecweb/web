class SessionsController < ApplicationController
  include ApplicationHelper
  layout nil
  def create
    self.current_agent = Agents.authenticate(params[:name], params[:password])
    logger.info("----------name:#{@current_agent.name if @current_agent}----------")
    if agent_logged_in?
      redirect_to ('/content/productquote')
    else
      render :action => :new
    end
  end

  def destroy
    logger.info("------------ i shall delete session---------")
    current_agent = nil
    session[:agents] = nil
    redirect_to ('/content/productquote')
  end

  private
  def current_agents=(new_agents)
    session[:agents] = new_agents ? nil : new_agents.id
  end
end
