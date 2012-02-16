class MenusController < ApplicationController
# GET /menus
  # GET /menus.json
  def index
    @menus = menu.all

    respond_to do |format|
      
	  format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu = menu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    @menu = menu.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/1/edit
  def edit
    @menu = menu.find(params[:id])
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = menu.new(params[:menu])

    respond_to do |format|
      if @menu.save
		logger.debug "Debug: menu saved."
		
		#MDR: Customized routing to stay on the index page after saving a new
		#	menu.
		format.html { redirect_to menus_url }
		format.json { render json: @menus } 
		
		#format.html { redirect_to @menu, notice: 'menu was successfully created.' }
        #format.json { render json: @menu, status: :created, location: @menu }
      else
        format.html { render action: "new" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @menu = menu.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to @menu, notice: 'menu was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu = menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :ok }
    end
  end
end
