#!/bin/sh

# The app exits if GOOGLE_FONTS_API_KEY is empty; fall back to upstream's
# built-in fixture font list so the app still starts without a key
if [ -z "$GOOGLE_FONTS_API_KEY" ]; then
	GOOGLE_FONTS_API_KEY=***
	export GOOGLE_FONTS_API_KEY
	export GOOGLE_FONTS_USE_TEST_JSON=true
fi

exec "__NODEJS_DIR__/node" "__INSTALL_DIR__/dist/server/app.js"
