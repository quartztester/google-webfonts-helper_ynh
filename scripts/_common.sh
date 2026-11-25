#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

build_gwfh() {
	# yarn v1 is not shipped with Node 24 and upstream pins its deps in yarn.lock;
	# grunt 0.4 needs grunt-cli to run. Keep both outside node_modules so
	# `yarn install` does not prune them
	ynh_exec_as_app npm install --prefix "$install_dir/.build" --no-save --no-audit --no-fund --loglevel=error yarn@1.22.22 grunt-cli@1.2.0

	ynh_exec_as_app bash -c "cd '$install_dir' && .build/node_modules/.bin/yarn install --pure-lockfile --non-interactive"
	ynh_exec_as_app bash -c "cd '$install_dir' && ./node_modules/.bin/bower install --config.interactive=false --allow-root"
	ynh_exec_as_app bash -c "cd '$install_dir' && .build/node_modules/.bin/grunt build"

	# Demo mode serves this fixture relative to dist/ (config.ROOT)
	mkdir -p "$install_dir/dist/test"
	cp "$install_dir/test/googlefonts.json" "$install_dir/dist/test/"

	# Upstream hardcodes '/', point the app at its install path instead
	ynh_replace --match='<base href="/">' --replace="<base href=\"$path/\">" --file="$install_dir/dist/public/index.html"

	chown -R "$app:www-data" "$install_dir"
}
