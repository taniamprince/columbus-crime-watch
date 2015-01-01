json.array!(@reports) do |report|
  json.extract! report, :id, :CR-Number, :date, :description, : victim, :location
  json.url report_url(report, format: :json)
end
