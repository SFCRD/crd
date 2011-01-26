#!/usr/bin/env ruby -wKU

require 'test/unit'

require 'crd/flex'
require 'crd/spec'
require 'crd/flex/compc'

class TestCrdFlexCompc < Test::Unit::TestCase
  # setup
  def setup
    spec = Crd::Spec.new 'Testing SWC', '1.0.5' do |s|
      s.input = 'test/fixtures/target/Input.as'
      s.output = 'test/fixtures/target/Output.swf'
      s.source_path << 'libs/src'
      s.library_path << 'libs/bin'      
    end
    @cmd = Crd::Flex::Compc.new( spec )
  end
  # automatically provides command name to superclass
  def test_automatically_provides_command_name_to_superclass
    assert_equal( 'compc', @cmd.command )
  end
  # automatically sets source path argument
  def test_automatically_sets_source_path_argument
    assert_equal( [ 'test/fixtures/target', 'libs/src' ], @cmd.source_path )
  end
  # automatically sets library path argument
  def test_automatically_sets_library_path_argument
    assert_equal( [ 'libs/bin' ], @cmd.library_path )
  end
  # automatically sets include sources argument
  def test_automatically_sets_include_sources_argument
    assert_equal( 'test/fixtures/target', @cmd.include_sources )
  end
  # automatically sets namespace argument
  # def test_automatically_sets_namespace_argument
  #   TODO
  # end
  # automatically sets output argument
  def test_automatically_sets_output_argument
    assert_equal( 'build/bin/testing-swc-1.0.5.swc', @cmd.output )
  end
  # 
  # `compc \
  #    -source-path src \
  #    -library-path libs/bin \
  #    -include-sources src \
  #    -namespace http://jeremyruppel/mxml src/operations-manifest.xml \
  #    -output build/bin/operations-#{Operations::VERSION}.swc`

  # to cmd is formatted appropriately
  def test_to_cmd_is_formatted_appropriately
    cmd = @cmd.to_cmd
    assert_match( /^compc\s/, cmd )
    assert( cmd.include?( '-output=build/bin/testing-swc-1.0.5.swc'     ), 'Could not find output argument in to_cmd' )
    assert( cmd.include?( '-source-path+=test/fixtures/target,libs/src' ), 'Could not find source-path argument in to_cmd' )
    assert( cmd.include?( '-library-path+=libs/bin'                     ), 'Could not find library-path argument in to_cmd' )
    assert( cmd.include?( '-include-sources=test/fixtures/target'       ), 'Could not find include-sources argument in to_cmd' )
    # assert( cmd.include?( '-namespace=?????'                            ), 'Could not find namespace argument in to_cmd' )
  end
end