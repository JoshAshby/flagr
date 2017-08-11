class ScrapesIndex < Chewy::Index
  define_type Scrape.includes(:webpage) do
    field :uri, type: "keyword", value: ->{ webpage.raw_uri }
    field :host, type: "keyword", value: ->{ webpage.uri.hostname }

    field :body, type: "text", term_vector: "yes"
    field :links, type: "keyword"
    field :language, type: "keyword"

    field :created, type: "date", include_in_all: false, value: ->{ created_at }
  end
end
