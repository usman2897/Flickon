class ItemsController < ApplicationController
  layout 'standard'
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    current_account_seller
    @categories = Category.all
    @item = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    current_account_seller
    @item = Item.find(params[:id])
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
    current_account_seller
    @item = Item.new(item_params)
    @item.seller_id = @current_seller.seller_id
    @similar = Item.where(item_name: @item.item_name, category_id: @item.category_id, sub_category_id: @item.sub_category_id, price: @item.price, seller_id: @item.seller_id, brand: @item.brand ).first
    if @similar != nil
      @similar.update_attribute(:quantity, @item.quantity + @similar.quantity)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
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

  def cat
    @category = Category.find(params[:category])
    @sub_categories = SubCategory.where('category_id = ?', @category.category_id)
    #@items = Item.where('category_id = ?', params[:category]).order(:hits)
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
      params.require(:item).permit(:item_name, :brand, :category_id, :sub_category_id, :quantity, :price, :description, :image)
    end

    def check_seller
      account_seller_signed_in? && @current_seller.seller_id == item.seller_id
    end
end
