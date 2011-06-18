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
  # use HTML5 when generating HTML
  set :haml, :format => :html5

  ## for google analytics
  # @analytics_token = 'UA-13136329-6'
end

before do
end

helpers do
end

# Routes

get '/' do
  @title = "UcodeView - Src Code Highlight from URL."
  haml :index
end

get '/view' do
  @title = "AppUtils.h - UcodeView"
  haml :view
end

