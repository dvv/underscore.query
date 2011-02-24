all: index.js test

index.js:
	@coffee -jbcp src/*.coffee >$@

tmp/paperboy.js:
	@mkdir -p tmp
	@wget --no-check-certificate https://github.com/felixge/node-paperboy/raw/master/lib/paperboy.js -O $@

tmp/server.js: tmp/paperboy.js
	@echo "var path=require('path');var paperboy=require('./paperboy.js');require('http').createServer(function(req, res){paperboy.deliver(path.join(__dirname,'/../test'),req,res)}).listen(8080);console.log('Point your browser to http://localhost:8080');" >$@

test: index.js tmp/server.js
	@node tmp/server.js

.PHONY: all test
