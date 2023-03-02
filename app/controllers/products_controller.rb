class ProductsController < ApplicationController
  before_action :set_product, only: %i[show, update, destroy, edit]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # @products = Product.all
    if params[:query].present?
      @products = policy_scope(Product.global_search(params[:query]))
    else
      @products = policy_scope(Product)
    end
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product
    if @product.save
      redirect_to product_path(@product.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    authorize @product
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    @product = Product.find(params[:id])
    authorize @product
    @product.update(product_params)
    redirect_to product_path(@product.id)
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product
    @product.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to products_path, status: :see_other
  end

  def my_products
    @products = Product.where(user_id: current_user.id)
    authorize @products
  end

  private

  def product_params
    params.require(:product).permit(:name, :year, :brand, :operator, :model, :description, :status, :price, :available,
                                    photos: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
