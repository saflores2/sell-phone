class RegistersController < ApplicationController
  def create
    @register = Register.new
    @register.user = current_user
    @register.product = Register.find(params[:product])
    @register.save
    # redirect_to payment_register_path(@register.id) if
  end

  def update
    @register = Register.find(params[:id])
    @register.status = ""
    redirect_to register_path(@register)
  end

  def sell_response
  end

  def payment
  end

  def confirmation
  end

  def my_registers
    @registers = Register.all
  end
end
