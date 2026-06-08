class Admin::CertificatesController < Admin::ApplicationController
  def index
    @certificates = Certificate.all.order(id: :asc)
  end
end
