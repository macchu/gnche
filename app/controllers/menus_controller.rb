class MenusController < ApplicationController
 
  @ajax_response = "no action"
  
  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu = Menu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
	@recipes = Recipe.all
	
	#Save the empty menu early, so its id can be passed to the new menu_items in the view.
	@menu = Menu.new
	#@menu.title = "New Menu 1"
	#@menu.created_at = DateTime.now
	#@menu.save 
	logger.debug "Menu.id = #{@menu.id}" #Shows that id isn't created yet.
	
	@menu_item = MenuItem.new
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.find(params[:id])
  end

  # MDR: Creates the new Menu.
  # POST /menus
  # POST /menus.json
  def create
	logger.debug "Menu nil? = #{params[:menu].nil?}"
	logger.debug "Menu_Item nil? = #{params[:menu_item].nil?}"
	
	if params[:menu_item].nil?
		save_menu params[:menu]
	
	elsif params[:menu].nil?
		save_menu_item params[:menu_item]
	else
		logger.debug "unexpected create action."  
	end
  end
  
  def save_menu params_for_menu
	logger.debug "updating menu: #{params_for_menu}"
	
	@id = params_for_menu[:id]
	@title = params_for_menu[:title]
	
	if @id.nil? or @id.empty?
		@menu = Menu.new(params_for_menu)
		create_menu @menu
		
	else
		@menu = Menu.find(@id)
		update_menu @menu, @title
	end
  end
  
  #MDR: Creates a new menu and processes the response.
  def create_menu menu
	logger.debug "create_menu"
	
	respond_to do |format|
	if menu.save
		@ajax_response = "update menu id"
		@menu_id = menu.id
		
		format.html { redirect_to(menus_url,
                    :notice => 'Post was successfully created.') }
		format.js
	  
	else
		logger.debug "create_menu failed."
	    format.html { redirect_to(menus_url) }
	end
    end
  end
  
  #MDR: Updates an existing menu, probably because it was givena  new title, and 
  #creates the response.
  def update_menu(menu, title)
	 respond_to do |format|
      if menu.update_attribute(:title, title)
		@ajax_response = "do nothing"
		
		format.html { redirect_to(menus_url,
                    :notice => 'Post was successfully created.') }
		format.js
	  
	  else
		logger.debug "create_menu failed."
	    format.html { redirect_to(menus_url) }
	  end
     end
  end
  
  #MDR: Only creating menu_items at this time.
  def save_menu_item params_for_menu_item	
	logger.debug "Saving a menu_item"
	
	@menu
	@menu_item
	
	@menu_id = params_for_menu_item[:menu_id]
	
	if @menu_id.nil? or @menu_id.empty?
		logger.debug "Create a new menu first."
		@menu = Menu.new()
		@menu.title = "New Menu"  #TODO: need global variable for default menu titles.
		@menu.save
		@menu_id = @menu.id
		
		
		logger.debug "MenuID = #{@menu.id}"
		
		logger.debug "Now saving the menu_item."
		@menu_item = MenuItem.new()
		@menu_item.menu_id = @menu.id
		@menu_item.recipe_id = params_for_menu_item[:recipe_id]
		
		@ajax_response = "update menu id"
		
	else
		logger.debug "Already have the menu, just saving the menu_item."
		@menu = Menu.find(@menu_id)
		@menu_item = MenuItem.new(params_for_menu_item)
		
		@ajax_response = "no response"
		
	end
	
	respond_to do |format|
		if @menu_item.save
			logger.debug "Debug: recipe saved."
			format.js
		
		else
			logger.debug "create_menu failed."
			format.html { redirect_to(menus_url) }
		end
    end
	
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @menu = Menu.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
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
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :ok }
    end
  end
end
