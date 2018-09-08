# frozen_string_literal: true

module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def sidebar_actions; end

      def card_happened_at_tag(title, time)
        html.p(class: 'card-text', title: time) do
          "#{title} #{RelativeTime.in_words(time)}"
        end
      end
    end
  end
end
