# 
# Inject HTML comments to rendered views/partials
# 
# from this:
# http://stackoverflow.com/questions/17857382
#     ruby-on-rails-debug-purposes-add-file-name-partial-view-to-html-output
# 
# to this:
#   https://gist.github.com/phoet/1386152
# 

if Rails.env.development?
  module My
    module PartialRenderer
      def render(context, options, block)
        # msg = "rendering '#{options[:partial]}' with locals '#{(options[:locals] || {}).keys}'"
        msg = "'#{options[:partial]}'"

        "<!-- start #{msg}-->\n#{super(context, options, block)}\n<!-- end #{msg}-->\n".html_safe
      end
    end
  end

  ActionView::PartialRenderer.prepend(My::PartialRenderer)
end