require_relative "newbahiahd/version"
require "f1sales_custom/source"
require "f1sales_custom/parser"
require "f1sales_helpers"

module Newbahiahd
  class Error < StandardError; end
  class F1SalesCustom::Email::Source
    def self.all
      [
        {
          email_id: 'website',
          name: 'Website'
        }
      ]
    end
  end
  class F1SalesCustom::Email::Parser
    def parse
      parsed_email = @email.body.colons_to_hash(/(Nome|Email|Telefone|Mensagem).*?:/, false)

      {
        source: {
          name: F1SalesCustom::Email::Source.all[0][:name]
        },
        customer: {
          name: parsed_email['nome'],
          phone: parsed_email['telefone'],
          email: parsed_email['email']
        },
        message: parsed_email['mensagem']
      }
    end
  end
end
