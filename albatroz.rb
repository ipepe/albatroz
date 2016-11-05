#!/bin/ruby
require 'sinatra'
require 'sinatra-websocket'
require 'filewatcher'


set :server, 'thin'
set :views, '.'
SOCKETS = []
JS_RELOAD = <<-JS
new WebSocket('ws://'+window.location.host+window.location.pathname).onmessage=function(){window.location=window.location}
JS

get '*' do |path|
  if request.websocket?
    request.websocket do |ws|
      ws.onopen do
        warn("websocket opened")
        SOCKETS << ws
      end
      ws.onclose do
        warn("websocket closed")
        SOCKETS.delete(ws)
      end
    end
  elsif path == '/'
    redirect '/index.html'
  elsif !request.websocket?
    if File.exist?(File.join('.', path))
      send_file File.join('.', path)
    else
      case path.split('.').last
        when 'html'
          slim(path.split('.').first.to_sym)
        when 'js'
          coffee path.split('.').first.to_sym
      end
    end.gsub('</head>',"<script>#{JS_RELOAD}</script></head>")
  end
end

filewatcher = FileWatcher.new('**/*.*')
thread = Thread.new(filewatcher){|fw| fw.watch{|f| puts "File changed: #{f}";EM.next_tick { ::SOCKETS.each{|s| s.send('reload') } }}}

