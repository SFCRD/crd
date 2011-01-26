#!/usr/bin/env ruby -wKU

require 'test/unit'

require 'crd'
require 'crd/flex'
require 'crd/flex/manifest'

class TestCrdFlexManifest < Test::Unit::TestCase
  # setup
  def setup
    @spec = Crd::Spec.new 'Testing' do |s|
      s.input = 'src/Main.as'
      s.output = 'src/Output.swf'
    end
  end
  # yields to block in constructor
  def test_yields_to_block_in_constructor
    yielded = false
    Crd::Flex::Manifest.new @spec do |c|
      yielded = true
    end
    assert( yielded, 'Did not yield self to block' )
  end
  # yields self to block
  def test_yields_self_to_block
    inner = nil
    outer = Crd::Flex::Manifest.new( @spec ) do |c|
      inner = c
    end
    assert_same( outer, inner )
  end
  # output file path is accurate
  def test_output_file_path_is_accurate
    m = Crd::Flex::Manifest.new( @spec )
    assert_equal( 'src/Main-manifest.xml', m.output )
  end
  # to xml returns correct xml representation of source tree
  def test_to_xml_returns_correct_xml_representation_of_source_tree
    m = Crd::Flex::Manifest.new( @spec )
    s =<<EOS
<?xml version="1.0" encoding="UTF-8"?>
<componentPackage>
  <component class="Main"/>
  <component class="com.main.SomeClass"/>
</componentPackage>
EOS
    assert_equal( s, m.to_xml )
  end
end