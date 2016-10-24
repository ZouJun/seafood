class Agent::BookingsController < Agent::BaseController

  def index
    @bookings = current_agent.orders
  end
end