#!/usr/bin/env ruby -wKU

require "test/unit"

require "crd/target"

class TestCrdTarget < Test::Unit::TestCase
  # test constants
  GOOD = 'test/fixtures/target/Input.as'
  BAD = 'test/fixtures/target/Missing.as'
  # no filename in constructor gives default value to filename
  def test_no_filename_in_constructor_gives_default_value_to_filename
    t = Crd::Target.new
    assert_equal( Crd::Target::NOT_SET, t.filename )
  end
  # accepts filename in constructor
  def test_accepts_filename_in_constructor
    t = Crd::Target.new GOOD
    assert_equal( GOOD, t.filename )
  end
  # provides file dirname
  def test_provides_file_dirname
    t = Crd::Target.new GOOD
    assert_equal( File.dirname( GOOD ), t.dirname )
  end
  # existing files exist
  def test_existing_files_exist
    t = Crd::Target.new GOOD
    assert_equal( true, t.exists? )
  end
  # nonexistant files do not exist
  def test_nonexistant_files_do_not_exist
    t = Crd::Target.new BAD
    assert_equal( false, t.exists? )
  end
end