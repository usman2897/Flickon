class SellersController < ApplicationController
  layout 'standard'
  before_action :set_seller, only: [:show, :edit, :update, :destroy]

  # GET /sellers
  # GET /sellers.json
  def index
    @sellers = Seller.all
  end

  # GET /sellers/1
  # GET /sellers/1.json
  def show
  end

  # GET /sellers/new
  def new
    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
  end

  # POST /sellers
  # POST /sellers.json
  def create
    @seller = Seller.new(seller_params)

    respond_to do |format|
      if @seller.save
        cookies.signed[:seller_id] = @seller.seller_id
        format.html { redirect_to @seller, notice: 'Seller was successfully created.' }
        format.json { render :show, status: :created, location: @seller }
      else
        format.html { render :new }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  def login
    if account_seller_signed_in? || account_user_signed_in?
      redirect_to items_url
    end
    @seller = Seller.new
  end

  def loggedin
    @seller = Seller.find_by("LOWER(seller_id) = ?",login_params[:seller_id].downcase)

    if @seller.present? && @seller.authenticate(login_params[:password])
      cookies.permanent.signed[:seller_id] = @seller.seller_id
      cookies.permanent.signed[:id] = 'seller'
      redirect_to sellers_dashboard_url
    end
  end

  def dashboard
    @orders = Array.new
    current_account_seller
    if account_seller_signed_in?
      @items = Item.where(seller_id: @current_seller.seller_id)
      @items.each do |item|
        @temp = Order.where(item_id: item.item_id)
        #@temp.each do |temp|
         # @orders.push(temp)
        #end
        @orders.concat(@temp)
      end
    end
  end

  def logout
    cookies.delete(:seller_id)
    redirect_to sellers_login_url
  end

  # PATCH/PUT /sellers/1
  # PATCH/PUT /sellers/1.json
  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to @seller, notice: 'Seller was successfully updated.' }
        format.json { render :show, status: :ok, location: @seller }
      else
        format.html { render :edit }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.json
  def destroy
    @seller.destroy
    respond_to do |format|
      format.html { redirect_to sellers_url, notice: 'Seller was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seller_params
      params.require(:seller).permit(:seller_id, :organization, :password)
    end

    def login_params
    params.require(:sellers).permit(:seller_id, :password)
  end
end
