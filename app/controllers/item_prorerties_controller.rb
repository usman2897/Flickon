class ItemProrertiesController < ApplicationController
  before_action :set_item_prorerty, only: [:show, :edit, :update, :destroy]

  # GET /item_prorerties
  # GET /item_prorerties.json
  def index
    @item_prorerties = ItemProrerty.all
  end

  # GET /item_prorerties/1
  # GET /item_prorerties/1.json
  def show
  end

  # GET /item_prorerties/new
  def new
    @item_prorerty = ItemProrerty.new
  end

  # GET /item_prorerties/1/edit
  def edit
  end

  # POST /item_prorerties
  # POST /item_prorerties.json
  def create
    @item_prorerty = ItemProrerty.new(item_prorerty_params)

    respond_to do |format|
      if @item_prorerty.save
        format.html { redirect_to @item_prorerty, notice: 'Item prorerty was successfully created.' }
        format.json { render :show, status: :created, location: @item_prorerty }
      else
        format.html { render :new }
        format.json { render json: @item_prorerty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_prorerties/1
  # PATCH/PUT /item_prorerties/1.json
  def update
    respond_to do |format|
      if @item_prorerty.update(item_prorerty_params)
        format.html { redirect_to @item_prorerty, notice: 'Item prorerty was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_prorerty }
      else
        format.html { render :edit }
        format.json { render json: @item_prorerty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_prorerties/1
  # DELETE /item_prorerties/1.json
  def destroy
    @item_prorerty.destroy
    respond_to do |format|
      format.html { redirect_to item_prorerties_url, notice: 'Item prorerty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_prorerty
      @item_prorerty = ItemProrerty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_prorerty_params
      params.require(:item_prorerty).permit(:item_property, :property_value)
    end
end
