

all:
	python	bin/make.py

clean:
	@! test -e gen || (rm -r gen/; rm -r .gen/; rm admin.models.js; rm admin.views.js; rm admin.stylesheets.css)
	@echo Cleaning Spinal Admin
