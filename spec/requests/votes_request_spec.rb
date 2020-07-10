require 'rails_helper'

RSpec.describe "Votes", type: :request do

  describe "GET /update" do
    it "returns http success" do
      get "/votes/update"
      expect(response).to have_http_status(:success)
    end
  end

end
