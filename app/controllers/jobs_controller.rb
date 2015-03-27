class JobsController < ApplicationController
  before_action :all_jobs, only: [:index, :create, :update, :destroy]
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js


  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        flash[:success] = "Job was successfully created!"
        format.html { redirect_to jobs_url}
        format.json { render :show, status: :created, location: @job }
      else
        flash[:error] = "Could not create Job!"
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        flash[:success] = "Job was successfully updated!"
        format.html { redirect_to @job }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.js  {}
      # format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  private
    def all_jobs
      @jobs = Job.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
      Rails.logger.debug("Job for update is: #{@job.title}")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description)
    end
end
