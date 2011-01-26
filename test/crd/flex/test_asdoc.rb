#!/usr/bin/env ruby -wKU

require 'test/unit'

require 'crd/flex'
require 'crd/spec'
require 'crd/flex/asdoc'

class TestCrdFlexAsdoc < Test::Unit::TestCase
  # setup
  def setup
    spec = Crd::Spec.new 'Testing' do |s|
      s.input = 'test/fixtures/target/Input.as'
      s.output = 'test/fixtures/target/Output.swf'
      s.source_path << 'libs/src'
      s.library_path << 'libs/bin'      
    end
    @cmd = Crd::Flex::Asdoc.new( spec )
  end
  # automatically provides command name to superclass
  def test_automatically_provides_command_name_to_superclass
    assert_equal( 'asdoc', @cmd.command )
  end  
  # automatically sets output argument
  def test_automatically_sets_output_argument
    assert_equal( 'build/docs', @cmd.output )
  end
  # automatically sets source path argument
  def test_automatically_sets_source_path_argument
    assert_equal( [ 'test/fixtures/target', 'libs/src' ], @cmd.source_path )
  end
  # automatically sets library path argument
  def test_automatically_sets_library_path_argument
    assert_equal( [ 'libs/bin' ], @cmd.library_path )
  end
  # automatically sets doc sources argument
  def test_automatically_sets_doc_sources_argument
    assert_equal( 'test/fixtures/target', @cmd.doc_sources )
  end
  # automatically sets main title argument
  def test_automatically_sets_main_title_argument
    assert_equal( '"Testing API Documentation"', @cmd.main_title )
  end
  # automatically sets window title argument
  def test_automatically_sets_window_title_argument
    assert_equal( '"Testing API Documentation"', @cmd.window_title )
  end
  # to cmd is formatted appropriately
  def test_to_cmd_is_formatted_appropriately
    cmd = @cmd.to_cmd
    assert_match( /^asdoc\s/, cmd )
    assert( cmd.include?( '-output=build/docs'                          ), 'Could not find output argument in to_cmd' )
    assert( cmd.include?( '-source-path+=test/fixtures/target,libs/src' ), 'Could not find source-path argument in to_cmd' )
    assert( cmd.include?( '-library-path+=libs/bin'                     ), 'Could not find library-path argument in to_cmd' )
    assert( cmd.include?( '-doc-sources=test/fixtures/target'           ), 'Could not find doc-sources argument in to_cmd' )
    assert( cmd.include?( '-main-title="Testing API Documentation"'     ), 'Could not find main-title argument in to_cmd' )
    assert( cmd.include?( '-window-title="Testing API Documentation"'   ), 'Could not find window-title argument in to_cmd' )
  end
end