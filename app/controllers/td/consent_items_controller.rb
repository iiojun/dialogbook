class Td::ConsentItemsController < Td::ApplicationController
  before_action :set_item, only: [ :edit, :update, :destroy ]

  def create
    p = consent_item_params
    msg = null_check(description: p[:description])
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      p[:consent_form_version] = ConsentFormVersion.find(p[:consent_form_version].to_i)
      item = ConsentItem.create!(p)
      flash[:notice] = "A new consent item was added."
    end
    redirect_to td_consent_forms_path
  end

  def edit
  end

  def update
    p = consent_item_params
    msg = null_check(description: p[:description])
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      p[:consent_form_version] = ConsentFormVersion.find(p[:consent_form_version].to_i)
      @consent_item.update!(p)
      flash[:notice] = "The consent item was updated."
    end
    redirect_to td_consent_forms_path

  end

  def destroy
    @consent_item.destroy
    flash[:notice] = "The consent item was successfully deleted."
    redirect_to td_consent_forms_path
  end

  private
  def set_item
    @consent_item = ConsentItem.find(params[:id])
  end

  def consent_item_params
    params.require(:consent_item).permit(:position, :title, :description,
                                         :consent_form_version)
  end
end
