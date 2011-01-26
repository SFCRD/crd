#!/usr/bin/env ruby -wKU

require 'crd/target'

module Crd
  class Spec
    UNNAMED = 'Un-named spec'
    
    attr_reader :name, :input, :output, :source_path, :library_path
    def initialize( name=nil )
      @name         = name || UNNAMED
      @input        = nil
      @output       = nil
      @source_path  = [ ]
      @library_path = [ ]
      yield self if block_given?
    end
    def input=( filename )
      @input = Target.new( filename )
      raise "No input file found at '#{@input.filename}'" unless @input.exists?
    end
    def output=( filename )
      @output = Target.new( filename )
    end
  end
end