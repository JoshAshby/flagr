class WebpagesIndex < Chewy::Index
  define_type Webpages do
    field :uri, type: "keyword", value: ->{ raw_uri }
    field :host, type: "keyword", value: ->{ uri.hostname }

    field :body, type: "text", term_vector: "yes"

    field :created, type: "date", include_in_all: false, value: ->{ created_at }
  end
end
