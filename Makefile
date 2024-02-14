start:
	docker run --rm -v ${PWD}/markdown:/slides webpronl/reveal-md:latest ./ --watch --css ./style.css --listing-template ./listing.html --config reveal.json
