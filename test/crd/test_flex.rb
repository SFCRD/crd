#!/usr/bin/env ruby -wKU

require "test/unit"

require "crd/flex"

class TestCrdFlex < Test::Unit::TestCase
  # yields to block in constructor
  def test_yields_to_block_in_constructor
    yielded = false
    Crd::Flex::Command.new 'mxmlc' do |c|
      yielded = true
    end
    assert( yielded, 'Did not yield self to block' )
  end
  # yields self to block
  def test_yields_self_to_block
    inner = nil
    outer = Crd::Flex::Command.new 'mxmlc' do |c|
      inner = c
    end
    assert_same( outer, inner )
  end
  # provides access to command name passed in constructor
  def test_provides_access_to_command_name_passed_in_constructor
    Crd::Flex::Command.new 'mxmlc' do |c|
      assert_equal( 'mxmlc', c.command )
    end
  end
  # assembles only command name in to cmd method
  def test_assembles_only_command_name_in_to_cmd_method
    Crd::Flex::Command.new 'mxmlc' do |c|
      assert_equal( 'mxmlc', c.to_cmd )
    end
  end
  # has can tell whether or not an argument has been set
  def test_has_can_tell_whether_or_not_an_argument_has_been_set
    Crd::Flex::Command.new 'mxmlc' do |s|
      assert_equal( false, s.has?( :output ) )
    end
  end
  # assignment creates a string argument
  def test_assignment_creates_a_string_argument
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.output = 'Main.swf'
      assert_equal( true, s.has?( :output ) )
    end
  end
  # can retrieve argument set through assignment
  def test_can_retrieve_argument_set_through_assignment
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.output = 'Main.swf'
      assert_equal( 'Main.swf', s.output )
    end
  end
  # argument can be overwritten through assignment
  def test_argument_can_be_overwritten_through_assignment
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.output = 'Main.swf'
      assert_equal( 'Main.swf', s.output )
      s.output = 'App.swf'
      assert_equal( 'App.swf', s.output )
    end
  end
  # retrieving new argument before assignment gives empty array
  def test_retrieving_new_argument_before_assignment_gives_empty_array
    Crd::Flex::Command.new 'mxmlc' do |s|
      assert_equal( [ ], s.library_paths )
    end
  end
  # can easily build arrays when accessing by default
  def test_can_easily_build_arrays_when_accessing_by_default
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.library_paths << 'lib/bin'
      s.library_paths << 'lib/swc'
      assert_equal( [ 'lib/bin', 'lib/swc' ], s.library_paths )
    end
  end
  # assembles one string argument into cmd
  def test_assembles_one_string_argument_into_cmd
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.output = 'Main.swf'
      assert_equal( 'mxmlc -output=Main.swf', s.to_cmd )
    end
  end
  # converts argument names with underscores to hyphens
  def test_converts_argument_names_with_underscores_to_hyphens
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.static_link_runtime_shared_libraries = true
      assert_equal( 'mxmlc -static-link-runtime-shared-libraries=true', s.to_cmd )
    end
  end
  # assembles two string arguments into cmd
  def test_assembles_two_string_arguments_into_cmd
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.output = 'Main.swf'
      s.static_link_runtime_shared_libraries = true
      assert_equal( 'mxmlc -output=Main.swf -static-link-runtime-shared-libraries=true', s.to_cmd )
    end
  end
  # assembles one array argument into cmd
  def test_assembles_one_array_argument_into_cmd
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.source_paths << 'src'
      s.source_paths << 'lib/src'
      assert_equal( 'mxmlc -source-paths+=src,lib/src', s.to_cmd )
    end
  end
  # assembles two array arguments into cmd
  def test_assembles_two_array_arguments_into_cmd
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.source_paths << 'src'
      s.source_paths << 'lib/src'
      s.library_paths << 'lib/bin'
      assert_equal( 'mxmlc -source-paths+=src,lib/src -library-paths+=lib/bin', s.to_cmd )
    end
  end
end