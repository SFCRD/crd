#!/usr/bin/env ruby -wKU

require "test/unit"

require "crd/kernel"

class TestSymbol < Test::Unit::TestCase
  # assign is false for a normal symbol
  def test_assign_is_false_for_a_normal_symbol
    assert_equal( false, :one.assign? )
  end
  # assign is true for a symbol with assignment on the end
  def test_assign_is_true_for_a_symbol_with_assignment_on_the_end
    assert_equal( true, :one=.assign? )
  end
  # base leaves un assigned symbols alone
  def test_base_leaves_un_assigned_symbols_alone
    assert_equal( :test, :test.base )
  end
  # base chops off the assignment if present
  def test_base_chops_off_the_assignment_if_present
    assert_equal( :test, :test=.base )
  end
end

class TestString < Test::Unit::TestCase
  # slug returns a downcased version of single word
  def test_slug_returns_a_downcased_version_of_single_word
    assert_equal( 'hello', 'Hello'.slug )
  end
  # slug returns a downcased version of multiple words connected with hyphens
  def test_slug_returns_a_downcased_version_of_multiple_words_connected_with_hyphens
    assert_equal( 'hello-world-yo', 'Hello WOrld YO'.slug )
  end
  # slug removes any characters that are not word characters or hyphens
  def test_slug_removes_any_characters_that_are_not_word_characters_or_hyphens
    assert_equal( 'hello-world-yo', '**Hello, WORld @#$ Yo!'.slug )
  end
end