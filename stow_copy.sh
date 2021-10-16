#!/bin/fish

for f in */ ; 
	cp -r $f/. ..
end
