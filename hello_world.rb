require_relative 'advice'

class HelloWorld
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      ['200', {"Content-Type" => 'text/html'}, ["<h2>Hello World!</h2>"]]
    when '/advice'
      piece_of_advice = Advice.new.generate
      ['200', {"Content-Type" => 'text/html'}, ["<em>#{piece_of_advice}</em>"]]
    else
      [
        '404',
        {"Content-Type" => 'text/html', "Content-Length" => '22'},
        ["<h1>404 Not Found</h1>"]
      ]
    end
  end
end
