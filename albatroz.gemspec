Gem::Specification.new do |s|
  s.name = 'albatroz'.freeze
  s.version = '0.0.5'
  s.date = '2016-11-05'
  s.authors = ['Patryk Ptasiński'.freeze]
  s.email = ['gemspec@ipepe.pl'.freeze]

  s.summary = 'Albatroz is a Sinatra with Filewatching(and reloading page with Websockets) tool for developing simple html websites.'.freeze
  s.homepage = 'https://github.com/ipepe/albatroz'.freeze
  s.licenses = ['Apache V2'.freeze]

  s.files = 'bin/albatroz'
  s.bindir = 'bin'
  s.executables << 'albatroz'
  s.require_paths = ['bin/albatroz']

  s.required_ruby_version = Gem::Requirement.new('>= 2.0.0'.freeze)

  s.add_dependency(%q<sinatra>.freeze,'~> 1.4', '>= 1.4.7')
  s.add_dependency(%q<sinatra-websocket>.freeze, '~> 0.3', '>= 0.3.1')
  s.add_dependency(%q<filewatcher>.freeze,'~> 0.5', '>= 0.5.3')
end