require 'test_helper'
require 'request'
require 'confirmation'

class RequestTest < ActiveSupport::TestCase
  # Test class methods
  test "Request class method" do
    assert 4, Request.confirmed.count
    assert 3, Request.unconfirmed.count
    assert 1, Request.accepted.count
    assert 0, Request.expired.count
  end
  
  # Test instance method
  req = Request.confirmed.first
  test "Request accept! method" do
    assert 1, Request.accepted.count
    assert_nil req.accepted_at
    req.accept!
    assert_not_nil req.accepted_at
    assert 2, Request.accepted.count
  end

  # Test empty form
  test "Empty form" do
    request = Request.new
    assert !request.save
  end

  # Test missing values
  test "Missing name" do
    request = Request.new(
      email: 'john@mail.com',
      phone: '0102030405',
      bio: 'Test missing name'
    )
    assert !request.save
  end

  test "Missing email" do
    request = Request.new(
      name: 'John',
      phone: '0102030405',
      bio: 'Test missing email'
    )
    assert !request.save
  end

  test "Missing phone" do
    request = Request.new(
      name: 'John',
      email: 'john@mail.com',
      bio: 'Test missing phone'
    )
    assert !request.save
  end

  test "Missing bio" do
    request = Request.new(
      name: 'John',
      email: 'john@mail.com',
      phone: '0102030405'
    )
    assert !request.save
  end

  # Test invalid mails
  test "Mail without @" do
    request = Request.new(
      name: 'John',
      email: 'johnmail.com',
      phone: '0102030405',
      bio: 'Test wrong email'
    )
    assert !request.save
  end

  test "Mail without . before suffix" do
    request = Request.new(
      name: 'John',
      email: 'john@mailcom',
      phone: '0102030405',
      bio: 'Test wrong email'
    )
    assert !request.save
  end

  # Test invalid phone
  test "Phone without leading + or 0" do
    request = Request.new(
      name: 'John',
      email: 'john@mail.com',
      phone: '102030405',
      bio: 'Test wrong email'
    )
    assert !request.save
  end

  test "Phone with invalid character" do
    request = Request.new(
      name: 'John',
      email: 'john@mailcom',
      phone: '00(33)102030405',
      bio: 'Test wrong email'
    )
    assert !request.save
  end
end
