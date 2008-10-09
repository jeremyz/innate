require 'innate'
require 'innate/setup'
require 'uv'
require 'git'

Uv.copy_files('xhtml', File.join(File.dirname(__FILE__), 'public'))

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'vendor/org/lib')
require 'org'

Innate.middleware :innate do |m|
  m.use Rack::CommonLogger   # usually fast, depending on the output
  m.use Rack::ShowExceptions # fast
  m.use Rack::ShowStatus     # fast
  m.use Rack::Reloader       # reasonably fast depending on settings
  m.use Rack::Lint           # slow, use only while developing
  # m.use Rack::Profile      # slow, use only for debugging or tuning
  m.use Innate::Current      # necessary

  m.cascade Rack::File.new('public'), Innate::DynaMap
end

Innate.setup do
  # gem :owlscribble
  # gem :uv
  # gem :git

  require 'env', 'model/page', 'node/init'

  start :adapter => :mongrel
end
