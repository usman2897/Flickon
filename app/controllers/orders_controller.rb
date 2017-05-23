class OrdersController < ApplicationController
  layout 'standard'
  before_action :set_order, only: [:show, :edit, :update, :destroy]
 
  # GET /orders
  # GET /orders.json
  @item1 = Item.new
  def index
    current_account_user
    if account_user_signed_in?
      @orders = Order.where( "user_id = ?", @current_user.user_id)
    else
      redirect_to users_login_url
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    current_account_user
    @order = Order.find_by(order_id: params[:id])
    if account_user_signed_in? &&  @current_user.user_id != @order.user_id
      redirect_to orders_url
    end
  end

  # GET /orders/new?item=1
  def new
    if account_user_signed_in? != true
      redirect_to users_login_url
    end
    @order = Order.new
    $item = Item.find(params[:item])
    @order.item_id = @item_id
  end

  # GET /orders/1/edit
  def edit
    @orders = Order.find_by(:order_id, params[:id])
    #@orders.each do |order|
     # @order = order
    #end
  end

 
  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    current_account_user
    @order = Order.new
    @order.item_id = $item.item_id
    @order.user_id = @current_user.user_id
    @order.ordered_quantity = order_params[:ordered_quantity]
    @order.total_price = $item.price * @order.ordered_quantity
    @order.ordered_time = Time.now + to_ist
    respond_to do |format| 
      if @order.save
        if($item.quantity <= 0)
          $item.destroy
        end
        $item.update_attribute(:quantity, $item.quantity-@order.ordered_quantity)
        format.html { redirect_to orders_url, notice: 'Order was successfully created.' }
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
