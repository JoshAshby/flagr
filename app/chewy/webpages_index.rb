class WebpagesIndex < Chewy::Index
  define_type Webpage do
    field :uri, type: "keyword", value: ->{ uri }
    field :host, type: "keyword", value: ->{ parsed_uri.hostname }

    field :scrape_id, type: "integer", value: ->{ latest_scrape&.id }

    field :title, type: "text", term_vector: "yes", value: ->{ latest_scrape&.title }
    field :body, type: "text", term_vector: "yes", value: ->{ latest_scrape&.cleaned }
    field :links, type: "keyword", value: ->{ latest_scrape&.links }
    field :language, type: "keyword", value: ->{ latest_scrape&.language }

    field :created_at, type: "date", include_in_all: false
  end

  define_type Bookmark do
    root parent: 'webpage', parent_id: ->{ webpage_id } do
      field :user_id, type: "integer"

      field :tags, type: "keyword", boost: 2

      field :last_seen_at, type: "date"
      field :created_at, type: "date", include_in_all: false
    end
  end
end
