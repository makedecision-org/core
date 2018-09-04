module Web
  module Views
    module BreadcrumbGenerator
      def self.included(view)
        view.class_eval do
          def breadcrumb_generator(*breadcrumbs)
            html.ol(class: 'breadcrumb') do
              breadcrumbs[0..-2].each do |item, link|
                li(class: 'breadcrumb-item') { a(href: link) { text(item) } }
              end

              last_item = breadcrumbs[-1]

              li(class: 'breadcrumb-item active', 'aria-current' => "page") { text(last_item.first) }
            end
          end
        end
      end
    end
  end
end
