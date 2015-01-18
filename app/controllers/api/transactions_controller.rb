class API::TransactionsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user_from_token!#, except: [:index, :show]

end
