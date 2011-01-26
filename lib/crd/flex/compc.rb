#!/usr/bin/env ruby -wKU

module Crd
  module Flex
    class Compc < Command
      def initialize( spec )
        super 'compc',
        {
          :output          => "build/bin/#{spec.name.slug}-#{spec.version}.swc", 
          :source_path     => [ spec.input.dirname, spec.source_path ].flatten,
          :library_path    => spec.library_path,
          :include_sources => spec.input.dirname
        }
      end
    end
  end
end