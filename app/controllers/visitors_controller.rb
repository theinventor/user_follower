class VisitorsController < ApplicationController
  protect_from_forgery :except => [:options, :create]

  # GET /visitors
  # GET /visitors.json
  def index
    render json: Visitor.paginate(:page => params[:page], :per_page => 300)
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

  def clear
    visitor = Visitor.find_by_uuid params[:uuid]
    visitor.try(:destroy) if visitor
    render text: 'okie dokie'
  end

  # DELETE /visitors/1
  ## DELETE /visitors/1.json
  #def destroy
  #  @visitor = Visitor.find_by_uuid params[:id]
  #  @visitor.destroy
  #  respond_to do |format|
  #    format.html { redirect_to visitors_url }
  #    format.json { head :no_content }
  #  end
  #end

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
