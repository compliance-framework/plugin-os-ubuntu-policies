test:
	@echo "Testing policies..."
	@OPA test policies

build: clean
	@echo "Bundling policies..."
	@mkdir -p dist/
	@opa build -b policies -o dist/bundle.tar.gz

clean:
	@echo "Cleaning up..."
	@rm -f dist/bundle.tar.gz