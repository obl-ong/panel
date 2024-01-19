json.array! @domains, partial: "domain", as: :d, locals: {records: params[:records]}
