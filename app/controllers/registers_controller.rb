class RegistersController < ApplicationController
  def create
    @register = Register.new

    @register.save
  end

  def update
    @register = Regsiter.find(params[:id])
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
