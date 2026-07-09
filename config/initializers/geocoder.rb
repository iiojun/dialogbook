Geocoder.configure(
  lookup: :opencagedata,
  api_key: ENV["OPENCAGE_API_KEY"],
  timeout: 5,
  use_https: true
)
