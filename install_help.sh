#!/bin/bash

#As long as we source this file, $0 should be the script calling this
#rather than 'install_help.sh' itself
self_file="$0"
echo "$log_path" 
log_path=${log_path:-"$LFS/lfs_install.log"}

#these are left empty for scripts sourcing this one to overwrite
extra_pre_success() { :; }
extra_post_success() { :; }
extra_pre_failure() { :; }
extra_post_failure() { :; }
extra_pre_run() { :; }
extra_post_run() { :; }
extra_pre_term() { :; }
extra_post_term() { :; }

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

termination_cleanup() {
  cat <(extra_pre_term) | tee -a "$log_path"
  echo "Terminating $app" | tee -a "$log_path"
  cat <(extra_post_term) | tee -a "$log_path"
}

trap 'termination_cleanup' SIGINT SIGQUIT SIGTERM
trap '[ $? = 0 ] && success_cleanup' EXIT
trap 'failure_cleanup' ERR

install_app_nest() {
	app="$1"
	sources_dir="$2"
  tar_name=${3:-"$app"}
  echo "Script: $self_file" | tee -a "$log_path"
  echo "running $app" | tee -a "$log_path"
  cat <(extra_pre_run) | tee -a "$log_path"
	cd "$sources_dir"
	rm -rf "$app"
	tar -xf "$tar_name".tar.xz 2>/dev/null || tar -xf "$tar_name".tar.gz  2>/dev/null ||
    tar -xf "$tar_name".tar.bz2
	cd "$app" &&
	time {	
		install_app; 
	}
  xs=$? #store exit status so that extra_post_run below doesn't fuck it up
  cat <(extra_post_run) | tee -a "$log_path"
  echo "Exit status is $xs" | tee -a "$log_path"
  return "$xs";
}
