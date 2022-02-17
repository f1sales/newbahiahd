require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when came from the website' do
    let(:email) do
      email = OpenStruct.new
      email.to = [email: 'website@newbahiahd.f1sales.net']
      email.subject = 'Proposta Website'
      email.body = "De: Xandão Alencar <xandao.riro@gmail.com> <xandao.riro@gmail.com>\nAssunto: Proposta Website\n\nCorpo da mensagem:\nNome: Xandão Alencar\nEmail: xandao.riro@gmail.com\nTelefone: 71988288080\nMensagem: Mensagem HOME - Enviar Proposta"

      email
    end

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains lead website a source name' do
      expect(parsed_email[:source][:name]).to eq('Website')
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Xandão Alencar')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('71988288080')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('xandao.riro@gmail.com')
    end

    it 'contains message' do
      expect(parsed_email[:message]).to eq('Mensagem HOME - Enviar Proposta')
    end
  end
end
