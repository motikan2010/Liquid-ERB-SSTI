require 'erb'
require 'sinatra'
require 'liquid'


configure do
  set :bind, '0.0.0.0'
end

get '/erb' do
  name = params['name']

  template = ERB.new("hi #{name}")
  template.result
end

get '/liquid' do
  name = params['name']

  Liquid::Template.file_system = Liquid::LocalFileSystem.new('/etc/')
  @template = Liquid::Template.parse("hi #{name}")
  @template.render()
end

