# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/06/25

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'

$LOAD_PATH.unshift 'lib'
require 'haml/filters/blockcode'
require 'ucodeview/url_code_viewer'
require 'ucodeview/url_converter'

set :haml, :format => :html5

helpers do
  alias h escape_html
end

get '/' do
  haml :index
end

get '/*.css' do |path|
  scss path.to_sym
end

get '/view' do
  urls = UcodeView::URLConverter.new(params['q'].split)
  cv = UcodeView::URLCodeViewer.new(urls.to_a)
  @page_title = "#{cv.title}"
  @code_titles = cv.title
  @codes = cv.to_html
  haml :view
end

get '/*.html' do |path|
  pass unless File.exist?(File.join(options.views, "#{path}.haml"))
  haml path.to_sym
end

get '/*' do |path|
  pass unless File.exist?(File.join(options.views, "#{path}.haml"))
  haml path.to_sym
end

