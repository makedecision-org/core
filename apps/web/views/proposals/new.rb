module Web::Views::Proposals
  class New
    include Web::View

    def form
      form_for :proposal, '#', { method: :post } do
        div(class: 'form-group') do
          label :title
          text_field :title, class: 'form-control', placeholder: 'Title'
        end

        div(class: 'form-group') do
          label :body
          text_area :body, class: 'form-control', placeholder: 'Description'
        end

        submit 'Suggest', class: 'btn btn-primary'
      end
    end
  end
end
