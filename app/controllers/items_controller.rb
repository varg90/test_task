class ItemsController < ApplicationController
  helper_method :item

  def new
    @item = Item.new date: Time.now
  end

  def index
    @items = Item.order(updated_at: :desc).all
  end

  def create
    @item = Item.new item_params
    if item.save
      flash.notice = "Item #{item.number} has been created!"
      redirect_to item_path(item.id)
    else
      flash.alert = 'There was a problem creating an Item'
      render :new
    end
  end

  def update
    if item.update item_params
      flash.notice = "Item #{item.title} has been updated!"
      redirect_to items_path
    else
      flash.alert = 'There was a problem updating the Item'
      render :edit
    end
  end

  def destroy
    item_title = item.title
    if item.destroy
      flash.notice = "Item #{item_title} has been deleted!"
      redirect_to items_path
    else
      flash.alert = 'There was a problem deleting the Item'
      render :edit
    end
  end

  private

  def item
    @item ||= Item.find params[:id]
  end

  def item_params
    params.require(:item).
      permit :title, :price
  end
end
