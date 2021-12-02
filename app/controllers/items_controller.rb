class ItemsController < ApplicationController
  def index
    @store = Store.find(params[:store_id])
    @items = @store.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @store = Store.find(params[:store_id])
    @item  = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item  = Item.new(item_params)
    @store = Store.find(params[:store_id])
    @item.store_id = @store.id
    if @item.save
      redirect_to store_items_path, notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to store_item_path, notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to store_items_path, notice: 'Item was successfully destroyed.'
  end

  private

  def item_params
    params.require(:item).permit(:name, :size, :price, :link)
  end
end
