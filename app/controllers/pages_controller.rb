class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :resource, only: [:home]
  before_action :resource_name, only: [:home]
  before_action :devise_mapping, only: [:home]

  def home
    @disable_nav = true if current_user == nil
    @publications = policy_scope(Publication)
    @publication = Publication.new
    # raise
  end

  def users
    def show
    @publications = policy_scope(Publication)
    end
  end


  def resource_name
    @resource_name = :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def components
  end
end
