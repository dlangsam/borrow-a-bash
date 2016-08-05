Geocoder.configure(:timeout => 7, 
	:api_key => ENV.fetch('GOOGLE_API_KEY'),
	:use_https => true

	)
