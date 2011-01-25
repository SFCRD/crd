#!/usr/bin/env ruby -wKU

require "test/unit"

require 'crd/flex'
require 'crd/spec'
require "crd/flex/mxmlc"

class TestCrdFlexMxmlc < Test::Unit::TestCase
  # setup
  def setup
    @spec = Crd::Spec.new 'Testing' do |s|
      s.input = 'test/fixtures/target/Input.as'
      s.output = 'test/fixtures/target/Output.swf'
      s.source_paths << 'libs/src'
      s.library_paths << 'libs/bin'
    end
  end
  # automatically provides command name to superclass
  def test_automatically_provides_command_name_to_superclass
    c = Crd::Flex::Mxmlc.new( @spec )
    assert_equal( 'mxmlc', c.command )
  end
  # automatically sets output argument
  def test_automatically_sets_output_argument
    c = Crd::Flex::Mxmlc.new( @spec )
    assert_equal( @spec.output.filename, c.output )
  end
  # automatically sets source paths argument
  def test_automatically_sets_source_paths_argument
    c = Crd::Flex::Mxmlc.new( @spec )
    assert_equal( [ @spec.input.dirname, @spec.source_paths ].flatten, c.source_paths )
  end
  # automatically sets library paths arguments
  def test_automatically_sets_library_paths_arguments
    c = Crd::Flex::Mxmlc.new( @spec )
    assert_equal( @spec.library_paths, c.library_paths )
  end
  # appends input to end of to cmd
  def test_appends_input_to_end_of_to_cmd
    c = Crd::Flex::Mxmlc.new( @spec )
    cmd = c.to_cmd.split( /\s+/ )
    assert_equal( 'mxmlc', cmd.shift )
    assert_equal( 'test/fixtures/target/Input.as', cmd.pop )
    assert( cmd.include?( '-output=test/fixtures/target/Output.swf' ), 'Could not find correct output argument in to_cmd' )
    assert( cmd.include?( '-source-paths+=test/fixtures/target,libs/src' ), 'Could not find correct source_paths argument in to_cmd' )
    assert( cmd.include?( '-library-paths+=libs/bin' ), 'Could not find correct library_paths argument in to_cmd' )
  end
end