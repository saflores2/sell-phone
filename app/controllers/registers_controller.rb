class RegistersController < ApplicationController
  before_action :skip_authorization
  def create
    @register = Register.new
    @register.user = current_user
    @register.product = Product.find(params[:product_id])
    @register.status = "solicitado"
    redirect_to payment_register_path(@register.id) if @register.save
  end

  def update
    @register = Register.find(params[:id])
    @register.status = "comprado"
    redirect_to register_path(@register)
  end

  def sell_response
  end

  def payment
    @register = Register.find(params[:id])
    @register.product.available = false
  end

  def confirmation
  end

  def my_registers
    @registers = Register.where(@register.user = user_id)
  end
end
