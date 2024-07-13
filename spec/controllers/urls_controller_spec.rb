require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe 'POST #create' do
    context 'with a valid URL' do
      it 'creates and persists the URL' do
        post :create, params: { url: { long_url: 'https://www.example.com' } }
        expect(assigns(:url)).to be_persisted
        expect(response).to redirect_to(url_path(assigns(:url).short_code))
      end
    end

    context 'with an invalid URL' do
      it 'does not persist the URL and renders the new template' do
        post :create, params: { url: { long_url: 'invalid-url' } }
        expect(assigns(:url)).to be_nil
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    let(:url) { Url.create!(long_url: 'https://www.example.com', short_code: 'abc123') }

    it 'renders the show template for a valid short code' do
      get :show, params: { id: url.short_code }
      expect(response).to render_template(:show)
    end

    it 'returns 404 for a nonexistent short code' do
      get :show, params: { id: 'nonexistent' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #redirect' do
    let(:url) { Url.create!(long_url: 'https://www.example.com', short_code: 'abc123') }

    it 'redirects to the long URL for a valid short code' do
      get :redirect, params: { short_code: url.short_code }
      expect(response).to redirect_to(url.long_url)
    end

    it 'returns 404 for a nonexistent short code' do
      get :redirect, params: { short_code: 'nonexistent' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #report' do
    it 'renders the report template' do
      get :report
      expect(response).to render_template(:report)
    end
  end
end
