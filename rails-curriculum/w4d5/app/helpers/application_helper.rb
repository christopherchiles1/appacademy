module ApplicationHelper
  def auth
    "<input
      type='hidden'
      name='authenticity_token'
      value='<%=form_authenticity_token%>'>".html_safe
  end

  # def auth
  #   html_stuff = <<-HTML
  #   <input
  #     type='hidden'
  #     name='authenticity_token'
  #     value='<%=form_authenticity_token%>'>
  #   HTML
  #
  #   html_stuff.html_safe
  # end
end
