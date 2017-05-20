class ItemPropertiesController < ApplicationController
  before_action :set_item_property, only: [:show, :edit, :update, :destroy]

  # GET /item_properties
  # GET /item_properties.json
  def index
    @item_properties = ItemProperty.all
  end

  # GET /item_properties/1
  # GET /item_properties/1.json
  def show
  end

  # GET /item_properties/new
  def new
    @item_property = ItemProperty.new
  end

  # GET /item_properties/1/edit
  def edit
  end

  # POST /item_properties
  # POST /item_properties.json
  def create
    @item_property = ItemProperty.new(item_property_params)

    respond_to do |format|
      if @item_property.save
        format.html { redirect_to @item_property, notice: 'Item property was successfully created.' }
        format.json { render :show, status: :created, location: @item_property }
      else
        format.html { render :new }
        format.json { render json: @item_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_properties/1
  # PATCH/PUT /item_properties/1.json
  def update
    respond_to do |format|
      if @item_property.update(item_property_params)
        format.html { redirect_to @item_property, notice: 'Item property was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_property }
      else
        format.html { render :edit }
        format.json { render json: @item_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_properties/1
  # DELETE /item_properties/1.json
  def destroy
    @item_property.destroy
    respond_to do |format|
      format.html { redirect_to item_properties_url, notice: 'Item property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_property
      @item_property = ItemProperty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_property_params
      params.require(:item_property).permit(:item_property, :property_value)
    end
end
