MOCHA=./node_modules/.bin/mocha
REPORTER=spec
GREP=""
COFFEE=./node_modules/.bin/coffee

build:
	@$(COFFEE) -c -o lib src

test:
	@NODE_ENV=test $(MOCHA) \
		--compilers coffee:coffee-script \
		--reporter $(REPORTER) \
		--grep $(GREP)

.PHONY: test