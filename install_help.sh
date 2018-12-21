#!/bin/bash

#As long as we source this file, $0 should be the script calling this
#rather than 'install_help.sh' itself
self_file="$0" 
log_path=${1:-"$LFS/lfs_install.log"}

#these are left empty for scripts sourcing this one to overwrite
extra_pre_success() { :; }
extra_post_success() { :; }
extra_pre_failure() { :; }
extra_post_failure() { :; }
extra_pre_run() { :; }
extra_post_run() { :; }

success_cleanup() {
  echo "Winner is $app" | tee -a "$log_path"
  cat <(extra_pre_success) | tee -a "$log_path"
  cd "$sources_dir" &&
  rm -rf "$app"
  cat <(extra_post_success) | tee -a "$log_path"
}

failure_cleanup() {
  cat <(extra_pre_failure) | tee -a "$log_path"
  echo "Loser is $app" | tee -a "$log_path"
  cat <(extra_post_failure) | tee -a "$log_path"
}
trap 'success_cleanup' EXIT
trap 'failure_cleanup' ERR

install_app_nest() {
	app="$1"
	sources_dir="$2"
  echo '' > "$log_path"
  echo "Script: $self_file" | tee -a "$log_path"
	echo "running $app" | tee -a "$log_path"
  cat <(extra_pre_run) | tee -a "$log_path"
	cd "$sources_dir"
	rm -rf "$app"
	tar -xf "$app".tar.xz 2>/dev/null || tar -xf "$app".tar.gz 
	cd "$app" &&
	time {	
		install_app; 
	}
  xs=$? #store exit status so that extra_post_run below doesn't fuck it up
  cat <(extra_post_run) | tee -a "$log_path"
  return "$xs";
}
