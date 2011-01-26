#!/usr/bin/env ruby -wKU

require 'crd/kernel'
require 'crd/target'
require 'crd/spec'

require 'crd/flex'
require 'crd/flex/mxmlc'
require 'crd/flex/asdoc'
require 'crd/flex/compc'

=begin rdoc
  Base module namespace for Crd. Contains the version.
=end
module Crd
=begin rdoc
  The version number of the Crd project.
=end
  VERSION = '0.0.1'
end

=begin rdoc
  Compiles a given spec with `mxmlc`
  Yields command if block is given for extra configuration if desired.
=end
def mxmlc( spec )
  Crd::Flex::Mxmlc.new spec do |cmd|
    yield cmd if block_given?
    cmd.run!
  end
end

=begin rdoc
  Generates documentation for a given spec with `asdoc`.
  Yields command if block is given for extra configuration if desired.
  Default output is `build/docs`.
=end
def asdoc( spec )
  Crd::Flex::Asdoc.new spec do |cmd|
    yield cmd if block_given?
    cmd.run!
  end
end

=begin rdoc
  Compiles a given spec into a SWC with `compc`.
  Yields command if block is given for extra configuration if desired.
  Default output is `build/bin/#{spec.name.slug}-#{spec.version}`
=end
def compc( spec )
  Crd::Flex::Compc.new spec do |cmd|
    yield cmd if block_given?
    cmd.run!
  end
end