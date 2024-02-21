require "test_helper"

class MakeMyTripBookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get make_my_trip_bookings_new_url
    assert_response :success
  end

  test "should get search" do
    get make_my_trip_bookings_search_url
    assert_response :success
  end
end
