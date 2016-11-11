#!/bin/bash

#This script is usually run in travis servers. It clones the target project,
#resets to the desired commit, and starts calculating mutation table
#In order to run this script on travis server, it should be in a temporary repository.
#The script asynchronuous_run.sh is responsible for creating that temp repo and
#feeding the below constants (when it creates the temp repo) as well by doing find and replace.
#See make_travis_run function of the file asynchronuous_run.sh

scripts_repo_url="https://github.com/MoezGholami/prio_scripts"
target_repo_url="https://github.com/apache/commons-collections"
target_commit_hash="c87eeaa4"
experiment_name="lastPaperCommitTables"

main()
{
	set -e

	git clone $target_repo_url
	cd $(basename $target_repo_url)
	git reset --hard $target_commit_hash
	git clone $scripts_repo_url
	./$(basename $scripts_repo_url)/get_mutants_for_this.sh $experiment_name
	cd ..

	set +e
}

main
