require 'csv'

module Api
  module V1
    class AnnouncementsController < ApplicationController
      before_action :set_announcement, only: [:show, :update, :destroy]

      # GET /announcements
      # GET /announcements.json
      def index
        render json: Announcement.all, status: :ok
      end

      # GET /announcements/1
      # GET /announcements/1.json
      def show
      end

      # POST /announcements
      # POST /announcements.json
      def create
        @announcement = Announcement.new(announcement_params)

        if @announcement.save
          render json: @announcement, status: :created
        else
          render json: @announcement.errors, status: :unprocessable_entity
        end
      end

      def bulk_create
        counter = []

        params[:csv].each do |csv|
          CSV.foreach(csv, headers: true) do |row|
            if row[0]
              @ann = Announcement.new(
                  title: row[0],
                  subtitle: row[1],
                  body: row[2],
                  level: row[3] ||= 0,
                  url: row[4],
                  department: row[5] ||= "all",
                  college: row[6] ||= "all",
                  hall: row[7] ||= "all",
                  program: row[8] ||= "all",
                  expiry: row[9] ||= DateTime.now + 1.week
              )

              unless @ann.save!
                counter.push(@ann.errors)
              end
            end
          end
        end

        if counter.empty?
          render json: Announcement.all, status: :created
        else
          render json: {message: "There were some errors...", errors: counter}, status: :ok
        end
      end

      # PATCH/PUT /announcements/1
      # PATCH/PUT /announcements/1.json
      def update
        if @announcement.update(announcement_params)
          render :show, status: :ok, location: @announcement
        else
          render json: @announcement.errors, status: :unprocessable_entity
        end
      end

      # DELETE /announcements/1
      # DELETE /announcements/1.json
      def destroy
        @announcement.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_announcement
        @announcement = Announcement.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def announcement_params
        params.require(:announcement).permit(:title, :subtitle, :body, :level, :department, :college, :hall, :program)
      end

      def announcement_csv_params
        params.require(:announcement).permit(:csv)
      end
    end

  end
end