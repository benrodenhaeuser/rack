require_relative 'advice'
require_relative 'monroe'

class App < Monroe

  # the env hash is how the rack passes information about the request to our app, i.e., rack receives the request from Webrick and passes on the information about the request to our app, using the env hash.
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      status = '200'
      headers = {"Content-Type" => 'text/html'}
      # response and erb methods defined by Monroe class from which App inherits
      response(status, headers) do
        erb(:index)
      end
    when '/advice'
      piece_of_advice = Advice.new.generate
      status = '200'
      headers = {"Content-Type" => 'text/html'}
      response(status, headers) do
        erb(:advice, message: piece_of_advice)
      end
    else
      status = '404'
      headers = {"Content-Type" => 'text/html', "Content-Length" => '61'}
      response(status, headers) do
        erb(:not_found)
      end
    end
  end
end
