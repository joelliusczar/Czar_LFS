#!/bin/bash

extra_pre_success() { :; }
extra_post_success() { :; }
extra_pre_failure() { :; }
extra_post_failure() { :; }
extra_pre_run() { :; }
extra_post_run() { :; }

success_cleanup() {
  echo "Winner is $app"
  extra_pre_success
  cd "$sources_dir" &&
  rm -rf "$app"
  extra_post_success
}

failure_cleanup() {
  extra_pre_failure
  echo "Loser is $app"
  extra_post_failure
}
trap 'success_cleanup' EXIT
trap '' ERR

install_app_nest() {
	app="$1"
	sources_dir="$2"
	echo "running $app"
    extra_pre_run;
	cd "$sources_dir"
	rm -rf "$app"
	tar -xf "$app".tar.xz 2>/dev/null || tar -xf "$app".tar.gz 
	cd "$app" &&
	time {	
		install_app; 
	}
    extra_post_run;
}
