require 'webrick'

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
# ここにアクセスしたらtest.html.rebの中を処理させる
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
#  この行を変更
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

# この行を変更
server.mount('/goya_q.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_q.rb')

server.start
