require 'test_helper'

class UserQuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_questions_index_url
    assert_response :success
  end

end
