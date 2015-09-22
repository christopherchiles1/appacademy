require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      controller = self.class.to_s.underscore
      template_file = "views/#{controller}/#{template_name}.html.erb"
      begin
        template_string = File.read(template_file)
      rescue
        raise "Could not find template at: #{template_path}"
      end
      erb_template = ERB.new(template_string)
      controller_context = binding
      evaluated_template = erb_template.result(controller_context)
      render_content(evaluated_template, 'text/html')
    end
  end
end
