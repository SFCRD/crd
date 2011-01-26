#!/usr/bin/env ruby -wKU

module Crd
  module Flex
    class Mxmlc < Command
      def initialize( spec )
        @spec = spec
        super 'mxmlc',
        {
          :output       => spec.output.filename,
          :source_path  => [ spec.input.dirname, spec.source_path ].flatten,
          :library_path => spec.library_path
        }
      end
      def to_cmd
        super << " #{@spec.input.filename}"
      end
    end
  end
end