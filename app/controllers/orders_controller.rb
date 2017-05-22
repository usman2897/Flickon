class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find_by(order_id: params[:id])
  end

  # GET /orders/new
  def new
    if account_user_signed_in? != true
      redirect_to users_login_url
    end
    @order = Order.new
    @item = Item.find(params[:item])
    @order.item_id = @item.item_id
    @order.total_price = @item.price
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    current_account_user
    #@order.item_id = @item.item_id
    #@order.ordered_quantity = 1 #order_params[:ordered_quantity]
    @order.user_id = @current_user.user_id
    @order.total_price = @order.total_price * @order.ordered_quantity
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_myorders_url, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_myorders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def myorders
    current_account_user
    @orders = Order.where(:user_id => @current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      
      @orders = Order.where(:user_id => @current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit( :item_id, :ordered_quantity, :total_price)
    end
end
