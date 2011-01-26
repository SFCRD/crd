#!/usr/bin/env ruby -wKU

require "test/unit"

require "crd/spec"

class TestCrdSpec < Test::Unit::TestCase
  # yields to block in constructor
  def test_yields_to_block_in_constructor
    yielded = false
    Crd::Spec.new do |s|
      yielded = true
    end
    assert( yielded, 'Did not yield self to block' )
  end
  # yields self to block
  def test_yields_self_to_block
    inner = nil
    outer = Crd::Spec.new do |s|
      inner = s
    end
    assert_same( outer, inner )
  end
  # default name is set if no name is provided in constructor
  def test_default_name_is_set_if_no_name_is_provided_in_constructor
    Crd::Spec.new do |s|
      assert_equal( Crd::Spec::UNNAMED, s.name )
    end
  end
  # accepts name through constructor
  def test_accepts_name_through_constructor
    Crd::Spec.new 'Testing' do |s|
      assert_equal( 'Testing', s.name )
    end
  end
  # default version is set if no version is provided in constructor
  def test_default_version_is_set_if_no_version_is_provided_in_constructor
    Crd::Spec.new 'Testing' do |s|
      assert_equal( Crd::Spec::UNVERSIONED, s.version )
    end
  end
  # accepts version through constructor
  def test_accepts_version_through_constructor
    Crd::Spec.new 'Testing', '1.0.4' do |s|
      assert_equal( '1.0.4', s.version )
    end
  end
  # input target is nil
  def test_input_target_is_nil
    Crd::Spec.new 'Testing' do |s|
      assert_nil( s.input )
    end
  end
  # input method creates a new input target
  def test_input_method_creates_a_new_input_target
    Crd::Spec.new 'Testing' do |s|
      s.input = 'test/fixtures/target/Input.as'
      assert_instance_of( Crd::Target, s.input )
    end
  end
  # input method raises error if target does not exist
  def test_input_method_raises_error_if_target_does_not_exist
    filename = 'this/file/does/not/Exist.as'
    Crd::Spec.new 'Testing' do |s|
      assert_equal( false, File.exist?( filename ) )
      assert_raise( RuntimeError ) { s.input = filename }
    end
  end
  # output target is nil
  def test_output_target_is_nil
    Crd::Spec.new 'Testing' do |s|
      assert_nil( s.output )
    end
  end
  # output method creates a new output target
  def test_output_method_creates_a_new_output_target
    Crd::Spec.new 'Testing' do |s|
      s.output = 'some/output/File.swf'
      assert_instance_of( Crd::Target, s.output )
    end
  end
  # output method does not raise error if target does not exist
  def test_output_method_does_not_raise_error_if_target_does_not_exist
    filename = 'some/output/File.swf'
    Crd::Spec.new 'Testing' do |s|
      assert_equal( false, File.exist?( filename ) )
      assert_nothing_raised( RuntimeError ) { s.output = filename }
    end
  end
  # library path is empty array
  def test_library_path_is_empty_array
    Crd::Spec.new 'Testing' do |s|
      assert_equal( [ ], s.library_path )
    end
  end
  # can add paths to library path
  def test_can_add_paths_to_library_path
    Crd::Spec.new 'Testing' do |s|
      s.library_path << 'test/fixtures'
      assert_equal( [ 'test/fixtures' ], s.library_path )
    end
  end
  # source path is empty array
  def test_source_path_is_empty_array
    Crd::Spec.new 'Testing' do |s|
      assert_equal( [ ], s.source_path )
    end
  end
  # can add paths to source path
  def test_can_add_paths_to_source_path
    Crd::Spec.new 'Testing' do |s|
      s.source_path << 'test/fixtures'
      assert_equal( [ 'test/fixtures' ], s.source_path )
    end
  end
end