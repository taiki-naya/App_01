class ItemsController < ApplicationController
  before_action :access_restriction, except: [:index_all, :index, :show, :search]

  def index_all
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(20)
  end

  def index
    @store = Store.find(params[:store_id])
    @items = @store.items.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @store = Store.find(params[:store_id])
    @item  = Item.new
    @leagues = League.all
  end

  def edit
    @item = Item.find(params[:id])
    @leagues = League.all
  end

  def create
    @item  = Item.new(item_params)
    @store = Store.find(params[:store_id])
    @item.store_id = @store.id
    if @item.save
      LabellingOfItem.insert(params, @item)
      redirect_to store_items_path, notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      LabellingOfItem.insert(params, @item)
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

  def search
    @q = Item.ransack(search_params)
    items = []

    @q.result(distinct: true).each do |item|
      if params[:label][:kit].present?
        items << item if item.labelling_of_items.where(labelable_id: params[:label][:kit]).present?
      elsif params[:label][:team].present?
        items << item if item.labelling_of_items.where(labelable_id: params[:label][:team]).present?
      elsif params[:label][:league].present?
        items << item if item.labelling_of_items.where(labelable_id: params[:label][:league]).present?
      end
    end

    if params[:q][:name_cont].present?
      @items = @q.result(distinct: true)
    else
      @items = Item.where(id: items.map(&:id))
    end

    @items = @items.order(created_at: :desc).page(params[:page]).per(20)

  end

  private

  def item_params
    params.require(:item).permit(:name, :size, :price, :link)
  end

  def search_params
    params.require(:q).permit!
  end

  def access_restriction
    redirect_to root_path, notice: '権限がありません。' unless user_signed_in? || current_user&.admin?
  end

end
