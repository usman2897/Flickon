class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    @category = Category.find(@item.category_id)
    @sub_category = SubCategory.find(@item.sub_category_id)
    @item_properties = ItemProperty.where(item_id: @item.item_id)
  end

 


  # GET /items/new
  def new
    @item = Item.new
    @categories = Category.all
    @sub_categories = SubCategory.all
    @item_property = ItemProperty.new
  end

  # GET /items/1/edit
  def edit

    @item_property = ItemProperty.new
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item_property = ItemProperty.new(item_property_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
        @item_property.item_id = @item.item_id
        @item_property.save
          
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
      if @item_property.update(item_property_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
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
    def item_property_params
      params.require(:item_property).permit(:item_property, :property_value)
    end
end
