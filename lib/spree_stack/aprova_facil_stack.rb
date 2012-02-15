require "uri"
require "net/http"

class AprovaFacilStack

  URL = 'http://www.aprovafacil.com.br/cgi-bin/STAC/'
  URL_TEST = 'http://teste.aprovafacil.com.br/cgi-bin/STAC/'

  COMPRAR = 'APC'
  CAPTURAR = 'CAP'
  CANCELAR = 'CAN'

  def generate_token(order, amount, parcels)
    base_url = url()
    base_url += "TOKEN?NumberDocumento=#{order}&ValorDocumento=#{amount}&QuantidadeParcelas=#{parcels}"
  end

  def token_url(token)
    base_url + "?TokenID=#{token}"
  end

  def token_action(action, token)
    url(action) + "?TokenID=#{token}"
  end

private

  def url(action='')
    url = base_url
    url << '/'
    url << action
  end

  def base_url
    url = AprovaFacilStack::Config.test? ? URL_TEST.clone : URL.clone
    url << AprovaFacilStack::Config.user
    url
  end

  class MissingEnvironmentException < StandardError; end
  class MissingConfigurationException < StandardError; end
end