require 'rails_helper'

RSpec.describe PortfoliosController, type: :controller do
    
  let(:user) { create(:user) }
  let(:stock) { create(:stock) }
  let(:portfolio) { Portfolio.create!(user: user, stock: stock) }   
 
    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "initializes @portfolio" do
        get :new
        expect(assigns(:portfolio)).not_to be_nil
      end
    end
   
end
