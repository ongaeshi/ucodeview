# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2010/xx/xxxx

require 'rubygems'
require 'coderay'
require 'coderay/helpers/file_type'
require 'open-uri'

module UcodeView
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

    def link(url)
      "<a href=\"#{url}\">src</a>"
    end

    def to_html_url(url)
      filename = filename(url)
      src = open(url){|f|f.read}
      <<EOF
<h2>#{filename} - #{link(url)}</h2>
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
end
