# frozen_string_literal: true

require_relative 'test_helper'
require 'test/unit'

class DummyTest < Test::Unit::TestCase
  def true_test
    assert_true(false)
  end
end
