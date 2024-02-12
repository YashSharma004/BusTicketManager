class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: %i[ show edit update destroy ]

  # GET /payments or /payments.json
  # def index
  #   @payments = Payment.all
  # end
  def index
    @payments = Payment.where("paid_to_id = ? OR paid_by_id = ?", current_user.id, current_user.id)
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        @payment.send_payment_created_email(current_user)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        @payment.send_payment_created_email(current_user)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # def set_payment
    #   @payment = Payment.find(params[:id])
    # end

    # def payment_params
    #   params.require(:payment).permit(:paid_to_id, :paid_by_id, :amount, :date)
    # end
    
    def set_payment
      @payment = Payment.find(params[:id])
      unless @payment.paid_to_id == current_user.id || @payment.paid_by_id == current_user.id
        redirect_to root_path, alert: "You are not authorized to view this payment."
      end
    end

    def payment_params
      params.require(:payment).permit(:paid_to_id, :paid_by_id, :amount, :date)
    end
end
