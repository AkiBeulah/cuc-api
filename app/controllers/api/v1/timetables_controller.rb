require 'csv'
require 'pathname'

module Api
  module V1
    class TimetablesController < ApplicationController
      before_action :set_timetable, only: [:show, :update, :destroy]
      before_action :authenticate_user, only: [:filter]

      # GET /timetables
      # GET /timetables.json
      def index
        @timetables = Timetable.all
      end

      # GET /timetables/1
      # GET /timetables/1.json
      def filter

      end

      # POST /timetables
      # POST /timetables.json
      def create
        counter = []

        params[:csv].each do |csv|
          timetable_name = csv.original_filename
          timetable_headers = CSV.read(csv, :headers => true).headers
          CSV.foreach(csv, headers: true) do |row|
            for i in 2..13 do
              if row[i]
                @timetable = Timetable.new(
                    course_code: row[i].downcase!,
                    building: row[0],
                    venue: row[1],
                    time: timetable_headers[i],
                    day: timetable_name[0, timetable_name.index("_")],
                    session: timetable_name[timetable_name.index("_") + 1, 8]
                )

                unless @timetable.save!
                  counter.push(@timetable.errors)
                end
              end
            end
          end
        end

        if counter.empty?
          render json: Timetable.all, status: :ok
        else
          render json: {message: "There were some errors...", errors: counter}, status: :ok
        end
      end


      # PATCH/PUT /timetables/1
      # PATCH/PUT /timetables/1.json
      def update
        if @timetable.update(timetable_params)
          render :show, status: :ok, location: @timetable
        else
          render json: @timetable.errors, status: :unprocessable_entity
        end
      end

      # DELETE /timetables/1
      # DELETE /timetables/1.json
      def destroy
        @timetable.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_timetable
        @timetable = Timetable.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def timetable_params
        params.require(:timetable).permit(:csv, :name)
      end
    end
  end
end