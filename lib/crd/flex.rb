#!/usr/bin/env ruby -wKU

module Crd
  module Flex
    class Command
      attr_reader :command
      def initialize( command, options={} )
        @command = command
        @arguments = Hash.new { |h, k| h[ k ] = [ ] }
        options.each do |key, value|
          @arguments[ key ] = value
        end
        yield self if block_given?
      end
      def to_cmd
        "#{command}".tap do |c|
          @arguments.each_pair do |name, value|
            if value.is_a? Array
              if value.any?
                c << " -#{name.to_s.gsub( /_+/, '-' )}"
                c << "+=#{value.join( ',' )}"
              end
            else
              c << " -#{name.to_s.gsub( /_+/, '-' )}"
              c << "=#{value}"
            end
          end
        end
      end
      def run!
        `#{to_cmd}`.chomp
      end
      def found?
        File.exist? `which #{command}`.chomp
      end
      def has?( argument )
        @arguments.has_key? argument
      end
      def method_missing( meth, *args, &blk )
        if meth.assign?
          @arguments[ meth.base ] = args.pop
        else
          @arguments[ meth.base ]
        end
      end
    end
  end
end