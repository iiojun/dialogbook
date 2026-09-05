class MarkdownPreviewsController < ApplicationController
  def show
    render html: helpers.markdown(
      params[:body],
      p_class: params[:p_class]
    )
  end
end

