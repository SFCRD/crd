#!/usr/bin/env ruby -wKU

module Crd
  class Target
    NOT_SET = 'Target not set'
    attr_reader :filename
    def initialize( filename=nil )
      @filename = filename || NOT_SET
    end
    def dirname
      File.dirname filename
    end
    def exists?
      File.exist? filename
    end
  end
end