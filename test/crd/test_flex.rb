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
      assert_equal( [ ], s.library_path )
    end
  end
  # can easily build arrays when accessing by default
  def test_can_easily_build_arrays_when_accessing_by_default
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.library_path << 'lib/bin'
      s.library_path << 'lib/swc'
      assert_equal( [ 'lib/bin', 'lib/swc' ], s.library_path )
    end
  end
  # assembles one string argument into cmd
  def test_assembles_one_string_argument_into_cmd
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.output = 'Main.swf'
      cmd = s.to_cmd.split( /\s+/ )
      assert_equal( 'mxmlc', cmd.shift )
      assert( cmd.include?( '-output=Main.swf' ), 'Could not find argument in to_cmd' )
    end
  end
  # converts argument names with underscores to hyphens
  def test_converts_argument_names_with_underscores_to_hyphens
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.static_link_runtime_shared_libraries = true
      cmd = s.to_cmd.split( /\s+/ )
      assert_equal( 'mxmlc', cmd.shift )
      assert( cmd.include?( '-static-link-runtime-shared-libraries=true' ), 'Could not find argument in to_cmd' )
    end
  end
  # assembles two string arguments into cmd
  def test_assembles_two_string_arguments_into_cmd
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.output = 'Main.swf'
      s.static_link_runtime_shared_libraries = true
      cmd = s.to_cmd.split( /\s+/ )
      assert_equal( 'mxmlc', cmd.shift )
      assert( cmd.include?( '-output=Main.swf' ), 'Could not find argument in to_cmd' )
      assert( cmd.include?( '-static-link-runtime-shared-libraries=true' ), 'Could not find argument in to_cmd' )
    end
  end
  # assembles one array argument into cmd
  def test_assembles_one_array_argument_into_cmd
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.source_path << 'src'
      s.source_path << 'lib/src'
      cmd = s.to_cmd.split( /\s+/ )
      assert_equal( 'mxmlc', cmd.shift )
      assert( cmd.include?( '-source-path+=src,lib/src' ), 'Could not find argument in to_cmd' )
    end
  end
  # assembles two array arguments into cmd
  def test_assembles_two_array_arguments_into_cmd
    Crd::Flex::Command.new 'mxmlc' do |s|
      s.source_path << 'src'
      s.source_path << 'lib/src'
      s.library_path << 'lib/bin'
      cmd = s.to_cmd.split( /\s+/ )
      assert_equal( 'mxmlc', cmd.shift )
      assert( cmd.include?( '-source-path+=src,lib/src' ), 'Could not find argument in to_cmd' )
      assert( cmd.include?( '-library-path+=lib/bin' ), 'Could not find argument in to_cmd' )
    end
  end
  # run runs the command and returns the output
  def test_run_runs_the_command_and_returns_the_output
    Crd::Flex::Command.new 'echo' do |s|
      s.output = 'Main.swf'
      assert_equal( '-output=Main.swf', s.run! )
    end
  end
  # found returns true for commands found in path
  def test_found_returns_true_for_commands_found_in_path
    Crd::Flex::Command.new 'mxmlc' do |s|
      assert_equal( true, s.found? )
    end
  end
  # found returns false for commands not found in path
  def test_found_returns_false_for_commands_not_found_in_path
    Crd::Flex::Command.new 'madeupcommandname' do |s|
      assert_equal( false, s.found? )
    end
  end
  # can pass hash to constructor and have arguments be created before passing to block
  def test_can_pass_hash_to_constructor_and_have_arguments_be_created_before_passing_to_block
    opts = { :output => 'Main.swf', :library_path => [ 'libs/bin', 'libs/swc' ] }
    Crd::Flex::Command.new 'mxmlc', opts do |s|
      assert_equal( 'Main.swf', s.output )
      assert_equal( [ 'libs/bin', 'libs/swc' ], s.library_path )
    end
  end
  # does not print argument for empty array
  def test_does_not_print_argument_for_empty_array
    Crd::Flex::Command.new 'echo' do |s|
      s.library_path = [ ]
      assert_equal( [ ], s.library_path )
      assert_no_match( /-library-path/, s.to_cmd )
    end
  end
end