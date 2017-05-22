class ItemsController < ApplicationController
  layout 'standard'
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    current_account_seller
    @items = Item.where("quantity > ?", 0)
  end

  # GET /items/1
  # GET /items/1.json
  def show
    current_account_seller
    @item = Item.find(params[:id])
    if(@item.quantity == 0)
      @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
    end
    @item.update_attribute(:hits, @item.hits + 1)
    @category = Category.find(@item.category_id)
    @sub_category = SubCategory.find(@item.sub_category_id)
  end

  # GET /items/new
  def new
    if account_seller_signed_in? != true
      redirect_to sellers_login_url
    end
    @item = Item.new
    @categories = Category.all
    @sub_categories = SubCategory.all
  end

  # GET /items/1/edit
  def edit
    if account_user_signed_in?
      redirect_to items_url
    end 
  end

  # POST /items
  # POST /items.json
  def create
    if account_user_signed_in?
      redirect_to items_url
    end
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    if account_user_signed_in?
      redirect_to items_url
    end
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:item_name, :category_id, :sub_category_id, :quantity, :price, :description, :seller_id, :image)
    end

    def check_seller
      account_seller_signed_in? && @current_account_seller.seller_id == item.seller_id
    end
end
