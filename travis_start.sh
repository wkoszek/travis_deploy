#!/bin/sh

travis enable
travis init
travis settings -s yes builds_only_with_travis_yml
