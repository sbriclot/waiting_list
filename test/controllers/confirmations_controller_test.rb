require 'test_helper'
require 'confirmation'

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  # test "On time valid key" do
  #   get confirmation_path, params: {key: 'cb778beefbc6128fc3ee6cf9ae5aac8b'}
  #   assert_redirected_to validated_path
  # end
  # test "Overdelay valid key" do
  #   get confirmation_path, params: {key: 'd44b7d6d8dd70b99a128058fb6bd702d'}
  #   assert_redirected_to too_late_path
  # end
  test "Invalid key" do
    get confirmation_path, params: {key: 'abc'}
    assert_redirected_to invalid_key_path
  end
end
