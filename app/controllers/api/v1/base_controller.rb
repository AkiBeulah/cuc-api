module Api
	module V1
		class BaseController < ApplicationController

			def query
				render PgSearch.multisearch(:query)
			end

			private

				def query_params
					params.require(:query)
				end
		end
	end
end