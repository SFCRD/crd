#!/usr/bin/env ruby -wKU

require 'builder'

module Crd
  module Flex
    class Manifest
      def initialize( spec )
        @spec = spec
        yield self if block_given?
      end
      def output
        "#{@spec.input.dirname}/#{@spec.input.basename}-manifest.xml"
      end
      def to_xml
        xml = Builder::XmlMarkup.new( :indent => 2 )
        xml.instruct!
        xml.componentPackage {
          Dir.chdir( @spec.input.dirname ){
            Dir[ '**/*.as' ].sort.each do |uri|
              xml.component( :class => uri.gsub( '/', '.' ).sub( /\.as$/, '' ) )
            end
          }
        }
      end
      def run!
        
      end
    end
  end
end

__END__
Dir.chdir( 'src' ){
    File.open( 'operations-manifest.xml', 'w+' ) do |f|
      doc = Nokogiri::XML::Builder.new do |xml|
        xml.componentPackage {
          Dir.glob( '**/*.as' ).each do |uri|
            xml.component( :class => uri.gsub( '/', '.' ).sub( /\.as$/, '' ) )
          end
        }
      end
      f << doc.to_xml
    end
  }