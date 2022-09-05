class AppPetsController < ApplicationController

    def update
       @record = AppPet.where(
            {
                app_id: params[:id],
                pet_id: params[:pet_id]
            }
       )
       @record.update({status: params[:status]})
       redirect_to "/admin/apps/#{params[:id]}"
    end
end