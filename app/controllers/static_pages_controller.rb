class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def top; end

  def term_of_use; end

  def privacy_policy; end

  def guide; end
end
