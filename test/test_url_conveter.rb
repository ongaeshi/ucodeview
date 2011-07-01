# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2010/xx/xxxx

require 'rubygems'
require 'test/unit'
require 'ucodeview/url_converter'

module UcodeView
  class TestURLConverter < Test::Unit::TestCase
    def test_basic
      urls = URLConverter.new ['http://www.yahoo.co.jp']
      assert_equal ['http://www.yahoo.co.jp'], urls.to_a

      urls = URLConverter.new ['http://www.emacswiki.org/emacs/dired.el']
      assert_equal ['http://www.emacswiki.org/emacs/download/dired.el'], urls.to_a

      urls = URLConverter.new ['http://www.emacswiki.org/emacs/tortoise-svn.el']
      assert_equal ['http://www.emacswiki.org/emacs/download/tortoise-svn.el'], urls.to_a
    end

    def test_github
      urls = URLConverter.new ['https://github.com/ongaeshi/ucodeview/blob/master/app.rb']
      assert_equal ['https://raw.github.com/ongaeshi/ucodeview/master/app.rb'], urls.to_a

      urls = URLConverter.new ['https://github.com/bmizerany/sinatra/blob/work/lib/sinatra.rb']
      assert_equal ['https://raw.github.com/bmizerany/sinatra/work/lib/sinatra.rb'], urls.to_a
    end

    def test_gist
      urls = URLConverter.new ['https://gist.github.com/1058907']
      assert_equal ['https://raw.github.com/gist/1058907'], urls.to_a

      urls = URLConverter.new ['https://gist.github.com/1058907#b.hpp']
      assert_equal ['https://raw.github.com/gist/1058907/b.hpp'], urls.to_a
    end
  end
end
