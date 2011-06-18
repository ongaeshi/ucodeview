# -*- coding: utf-8 -*-
#
# @file 
# @brief Sinatra Root
# @author ongaeshi
# @date   2011/06/19

require 'rubygems'
require 'sinatra'
require 'haml'
require 'coderay'
require 'coderay/helpers/file_type'
require 'open-uri'

class URLCodeViewer
end

# Sinatra !!

configure do
end

before do
end

helpers do
end

# Routes

get '/' do
  haml :index
end

get '/view' do
  haml :view
end

