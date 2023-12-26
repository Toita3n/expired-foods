class InquiriesController < ApplicationController
  skip_before_action :require_login, only: %i[new create mentions]
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.inquiry_mail(@inquiry).deliver
      redirect_to inquiry_mentions_path(@inquiry)
    else
      render :new
    end
  end

  def mentions; end

  def inquiry_params
    params.require(:inquiry).permit(:email, :text)
  end
end
