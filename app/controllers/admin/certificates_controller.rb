class Admin::CertificatesController < Admin::ApplicationController
  def index
    @certificates = Certificate.all.order(id: :desc)
    @certificates = Kaminari.paginate_array(@certificates).page(params[:page]).per(20)
  end
end
