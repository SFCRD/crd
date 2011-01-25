#!/usr/bin/env ruby -wKU

module Crd
  module Flex
    class Mxmlc < Command
      def initialize( spec )
        super 'mxmlc',
        {
          :output        => spec.output.filename, 
          :source_paths  => [ spec.input.dirname, spec.source_paths ].flatten,
          :library_paths => spec.library_paths
        }
        @spec = spec
      end
      def to_cmd
        super << " #{@spec.input.filename}"
      end
    end
  end
end