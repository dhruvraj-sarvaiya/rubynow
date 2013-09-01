class StaticPagesController < ApplicationController
  def home
    @jobpost = Jobpost.all
    # raise @jobpost.inspect
  end

  def whyrubynow
  end

  def rubyguides
  end

  def expertadvice
  end

  def privacypolicy
  end

  def termsofuse
  end

  def contactus
  end

  def findarailsdeveloper
  end
end
