class StaticPagesController < ApplicationController
  before_action :sign_in_required, only: [:home]
  def home; end
end
