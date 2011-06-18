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

  def to_html
    r = ""
    @urls.each do |url|
      r += to_html_url(url)
    end
    r
  end

  def to_html_url(url)
    filename = url.split('/')[-1]
    src = open(url){|f|f.read}
    <<EOF
<h2>#{filename}</h2>
<div>
#{to_html_code(src, file_type(filename))}
</div>
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
  @title = "AppUtils.h - UcodeView"
  cv = URLCodeViewer.new(['http://repo.or.cz/w/TortoiseGit.git/blob_plain/b56d7d297b615937e4a663a533349ede77e9cd9b:/src/TortoiseProc/AppUtils.h'])
  @codes = cv.to_html
  haml :view
end

