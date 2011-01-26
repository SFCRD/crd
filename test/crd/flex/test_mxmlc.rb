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
      s.source_path << 'libs/src'
      s.library_path << 'libs/bin'
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
  # automatically sets source path argument
  def test_automatically_sets_source_path_argument
    c = Crd::Flex::Mxmlc.new( @spec )
    assert_equal( [ @spec.input.dirname, @spec.source_path ].flatten, c.source_path )
  end
  # automatically sets library path arguments
  def test_automatically_sets_library_path_arguments
    c = Crd::Flex::Mxmlc.new( @spec )
    assert_equal( @spec.library_path, c.library_path )
  end
  # appends input to end of to cmd
  def test_appends_input_to_end_of_to_cmd
    c = Crd::Flex::Mxmlc.new( @spec )
    cmd = c.to_cmd.split( /\s+/ )
    assert_equal( 'mxmlc', cmd.shift )
    assert_equal( 'test/fixtures/target/Input.as', cmd.pop )
    assert( cmd.include?( '-output=test/fixtures/target/Output.swf' ), 'Could not find correct output argument in to_cmd' )
    assert( cmd.include?( '-source-path+=test/fixtures/target,libs/src' ), 'Could not find correct source_path argument in to_cmd' )
    assert( cmd.include?( '-library-path+=libs/bin' ), 'Could not find correct library_path argument in to_cmd' )
  end
  # does not set library path if empty in spec
  def test_does_not_set_library_path_if_empty_in_spec
    empty = Crd::Spec.new 'Empty' do |s|
      s.input = @spec.input.filename
      s.output = @spec.output.filename
    end
    c = Crd::Flex::Mxmlc.new( empty )
    assert_equal( [ ], c.library_path )
    assert_no_match( /-library-path/, c.to_cmd )
  end
end