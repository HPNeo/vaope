class PlacesController < ApplicationController
  respond_to :html, :json

  def index
    conditions = {}
    if params[:latlng]
      if params[:cat]
        conditions[:category_id] = params[:cat].split(',')
      end
      respond_with do |format|
        format.json { render :json => Place.near(params[:latlng]).where(conditions) }
      end
    end
  end

  def show
    @place = Place.find(params[:id])
  end

  def new
    @place = Place.new
    @categories = {}
    Category.are_parents.map{|category|
      @categories[category.name] = category.children.map{|children| [children.name, children.id]}
    }
  end

  def edit
  end
  
  def get_by_area_and_category
    area = Area.find_by_name(params[:area])
    category = Category.find_by_name(params[:category])

    places = Place.where(:area_id => area.id, :category_id => category.id)
  end

end
