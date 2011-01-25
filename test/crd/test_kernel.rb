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