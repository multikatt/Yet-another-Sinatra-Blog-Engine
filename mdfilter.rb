module Haml
  module Filters
    module Markdown
      include Base
      lazy_require 'rdiscount', 'peg_markdown', 'maruku', 'bluecloth', 'redcarpet', 'kramdown'

      # @see Base#render
      def render(text)
        if @required == 'redcarpet'
          ::Redcarpet::Markdown.new(::Redcarpet::Render::HTML.new).render(text)
        else
          engine = case @required
                   when 'rdiscount'
                     ::RDiscount
                   when 'peg_markdown'
                     ::PEGMarkdown
                   when 'maruku'
                     ::Maruku
                   when 'bluecloth'
                     ::BlueCloth
                   when 'kramdown'
                     ::Kramdown::Document
                   end
          engine.new(text).to_html
        end
      end
    end
          # Parses the filtered text with [Redcarpet](https://github.com/tanoku/redcarpet)
    module Redcarpet
      include Base
      lazy_require 'redcarpet'

      # @see Base#render
      def render(text)
        ::Redcarpet::Markdown.new(::Redcarpet::Render::HTML.new).render(text)
      end
    end
  end
end
