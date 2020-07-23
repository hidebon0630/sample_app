require 'rails_helper'

RSpec.describe 'Staticpages', type: :request do
  describe "GET /" do
    it "response 200" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
