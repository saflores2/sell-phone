class RegistersController < ApplicationController
  before_action :skip_authorization

  def create
    @register = Register.new
    @register.user = current_user
    @register.product = Product.find(params[:product_id])
    @register.status = "solicitado"
    redirect_to payment_register_path(@register.id) if @register.save
  end

  # def update
  #   @register = Register.find(params[:id])
  #   @register.status = "comprado"
  #   redirect_to register_path(@register)
  # end

  # def sell_response
  # end

  def payment
  end

  def confirmation
  end

  def my_registers
    @registers = Register.where(user_id: current_user.id)#, status: "solicitado")
  end

  def accept
    @register = Register.find(params[:id])
    product_id = @register.product.id
    other_registers = Register.where(product_id: product_id)
    other_registers.each do |reg|
      reg.status = "rechazado"
      reg.save
    end
    @register.status = "aceptado"
    @register.save
    redirect_to my_registers_registers_path
  end

  def reject
    @register = Register.find(params[:id])
    @register.status = "rechazado"
    @register.save
    redirect_to my_registers_registers_path
  end
end
