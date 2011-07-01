# -*- coding: utf-8 -*-
#
# @file 
# @brief  URL変換
# @author ongaeshi
# @date   2011/07/02

require 'rubygems'

module UcodeView
  class URLConverter
    def initialize(urls)
      @urls = urls
    end

    def to_a
      @urls.map{|url|conv url}
    end

    private

    def conv(url)
      r = url
      r = r.gsub(%r|http://www.emacswiki.org/emacs/(.*)|,
                   'http://www.emacswiki.org/emacs/download/\1')
      r = r.gsub(%r|https://github.com/(.*)/blob/(.*)|,
                 'https://raw.github.com/\1/\2')
      r
    end
  end
end
