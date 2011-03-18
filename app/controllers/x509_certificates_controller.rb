class X509CertificatesController < ApplicationController
  before_filter :load_wisp

  access_control do
    default :deny

    actions :show do
      allow :wisps_viewer
      allow :wisp_viewer, :of => :wisp
    end

    actions :revoke, :renew, :reissue do
      allow :wisps_manager
      allow :wisp_manager, :of => :wisp
    end
  end

  # GET /wisps/:wisp_id/ca/x509_certificates/1
  def show
    @ca = @wisp.ca
    @x509_certificate = @ca.x509_certificates.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def revoke
    ca = @wisp.ca
    x509_certificate = ca.x509_certificates.find(params[:id])
    ca.revoke_certificate!(x509_certificate)
    
    respond_to do |format|
      format.html { redirect_to(wisp_ca_url(@wisp)) }
    end
  end

  def renew
    ca = @wisp.ca
    x509_certificate = ca.x509_certificates.find(params[:id])
    ca.renew_certificate!(x509_certificate)

    respond_to do |format|
      format.html { redirect_to(wisp_ca_url(@wisp)) }
    end
  end

  def reissue
    ca = @wisp.ca
    x509_certificate = ca.x509_certificates.find(params[:id])
    ca.reissue_certificate!(x509_certificate)

    respond_to do |format|
      format.html { redirect_to(wisp_ca_url(@wisp)) }
    end
  end

end
