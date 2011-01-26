#!/usr/bin/env ruby -wKU

module Crd
  module Flex
    class Asdoc < Command
      def initialize( spec )
        @spec = spec
        super 'asdoc',
        {
          :output       => 'build/docs',
          :source_path  => [ spec.input.dirname, spec.source_path ].flatten,
          :library_path => spec.library_path,
          :doc_sources  => spec.input.dirname,
          :main_title   => "\"#{spec.name} API Documentation\"",
          :window_title => "\"#{spec.name} API Documentation\""
        }
      end
    end
  end
end