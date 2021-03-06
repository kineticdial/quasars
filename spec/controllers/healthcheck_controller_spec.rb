require 'rails_helper'

RSpec.describe HealthcheckController, type: :controller do
  describe 'GET index' do
    context 'when system is healthy' do
      it 'reports as healthy' do
        get :index

        expect(response.code).to eq('200')
      end
    end

    context 'when system is unhealthy' do
      before do
        allow(ActiveRecord::Base)
          .to receive(:connection)
                .and_raise('unhealthy!')
      end

      it 'reports as unhealthy' do
        get :index

        expect(response.code).to eq('500')
      end
    end
  end
end
