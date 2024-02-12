class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  # def index
  #   @tickets = Ticket&.all&.sort&.reverse
  # end
   def index
    @tickets = Ticket.where("booked_by_id = ? OR booked_for_id = ?", current_user.id, current_user.id).sort.reverse
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @current_user = current_user
    @ticket = Ticket.new(ticket_params)
    @ticket.week_number = @ticket.week_date&.cweek
    @ticket.year = @ticket.week_date&.year
    respond_to do |format|
      if @ticket.save
        @ticket.send_ticket_created_email(current_user)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    @current_user = current_user
    respond_to do |format|
      week_date = Date.parse(ticket_params[:week_date])&.cweek
      year = Date.parse(ticket_params[:week_date])&.year
      if @ticket.update(ticket_params.merge(week_number: week_date, year: year))
        @ticket.send_ticket_created_email(current_user)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
#     def set_ticket
#       @ticket = Ticket.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     # def ticket_params
#     #   params.require(:ticket).permit(:user_id, :booked_count, :extra_charges, :week_date, :booked_by_id, :booked_for_id)
#     # end
# def ticket_params
#   params.require(:ticket).permit(:user_id, :booked_count, :extra_charges, :price_per_ticket, :week_date, :booked_by_id, :booked_for_id)
# end
def set_ticket
      @ticket = Ticket.find(params[:id])
      unless @ticket.booked_by_id == current_user.id || @ticket.booked_for_id == current_user.id
        redirect_to root_path, alert: "You are not authorized to view this ticket."
      end
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:user_id, :booked_count, :extra_charges, :price_per_ticket, :week_date, :booked_by_id, :booked_for_id)
    end

end
