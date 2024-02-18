require "test_helper"

class TicketBookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ticket_bookings_new_url
    assert_response :success
  end

  test "should get create" do
    get ticket_bookings_create_url
    assert_response :success
  end
end
