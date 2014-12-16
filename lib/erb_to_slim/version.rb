#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

module ErbToSlim
  VERSION = [0, 0, 8]

  class << VERSION
    def to_s
      join(?.)
    end
  end
end
