class VisitorsController < ApplicationController
  before_action :set_visitor, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:options, :create]

  # GET /visitors
  # GET /visitors.json
  def index
    @visitors = Visitor.all
  end

  # GET /visitors/1
  # GET /visitors/1.json
  def show
  end

  def welcome
    render text: 'welcome, nothing to see here..'
  end

  # GET /visitors/new
  def new
    @visitor = Visitor.find_by_uuid request.ip

    if @visitor
      puts "YAY - ALREADY HAVE A VISITOR"
      render action: 'show', status: :created, location: @visitor and return
    else
      @visitor = Visitor.generate_new(request.ip)

      respond_to do |format|
        if @visitor.save
          cookies[:user_follower] = @visitor.uuid
          format.html { redirect_to @visitor, notice: 'Visitor was successfully created.' }
          format.json { render action: 'show', status: :created, location: @visitor }
        else
          format.html { render action: 'new' }
          format.json { render json: @visitor.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # GET /visitors/1/edit
  def edit
  end

  # POST /visitors
  # POST /visitors.json
  #def create
  #  @visitor = Visitor.generate_new
  #
  #  respond_to do |format|
  #    if @visitor.save
  #      format.html { redirect_to @visitor, notice: 'Visitor was successfully created.' }
  #      format.json { render action: 'show', status: :created, location: @visitor }
  #    else
  #      format.html { render action: 'new' }
  #      format.json { render json: @visitor.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /visitors/1
  # PATCH/PUT /visitors/1.json
  def update
    respond_to do |format|
      if @visitor.update(visitor_params)
        format.html { redirect_to @visitor, notice: 'Visitor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitors/1
  # DELETE /visitors/1.json
  def destroy
    @visitor.destroy
    respond_to do |format|
      format.html { redirect_to visitors_url }
      format.json { head :no_content }
    end
  end

  def options
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = "Origin, X-Requested-With, Content-Type, Accept"
    render text: 'Success'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_visitor
    @visitor = Visitor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def visitor_params
    #params.require(:visitor).permit(:uuid)
    #no params needed!
  end
end
