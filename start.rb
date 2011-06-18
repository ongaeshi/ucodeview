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
  def initialize(urls)
    @urls = urls
  end

  def title
    @urls.map{|url|filename url}.join(", ")
  end

  def to_html
    r = ""
    @urls.each do |url|
      r += to_html_url(url)
    end
    r
  end

  private
  
  def filename(url)
    url.split('/')[-1]
  end

  def to_html_url(url)
    filename = filename(url)
    src = open(url){|f|f.read}
    <<EOF
<h2>#{filename}</h2>
#{to_html_code(src, file_type(filename))}
EOF
  end

  def to_html_code(code, kind)
    CodeRay.scan(code, kind).
      html(
           :wrap => nil,
           :line_numbers => :table,
           :css => :class
           )
  end
  
  def file_type(filename)
    case File.extname(filename)
    when ".el"
      :scheme
    else
      CodeRay::FileType.fetch filename, :plaintext
    end
  end
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
  cv = URLCodeViewer.new(params['q'].split)
  @title = "#{cv.title} - UcodeView"
  @code_titles = cv.title
  @codes = cv.to_html
  haml :view
end

