#!/usr/bin/env ruby -wKU

module Crd
  class Target
    attr_reader :filename
    def initialize( filename )
      @filename = filename
    end
    def dirname
      File.dirname filename
    end
    def exists?
      File.exist? filename
    end
  end
end