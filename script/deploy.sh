#!/bin/bash
echo "about to deploy..."
git config user.name "GitHub Teacher" # set the user to Travis CI so we know this wasn't done by hu-man
git config user.email "trainingdemos+githubteacher@github.com"
git config push.default simple # we don't want to push all our branches
git branch --all #which branch are we on? for testing purposes
git checkout master
mv class-pins.topojson class-pins # preserves the old class-pins file
echo "I found new files, combining and pushing now!"
geojson-merge *.topojson class-pins > class-pins.topojson # merges any new topojson files with the existing pins file
rm class-pins # removes the preserved file
mv class-pins.topojson class-pins # preserve the newly created file
rm *.topojson # remove all student topojson files
mv class-pins class-pins.topojson # put the class pins file back
git add -A
git commit -m "[skip ci] clean up class files" # we don't want to trigger a build -- the reason we're doing this to begin with is because we're in the middle of a build
git remote set-url origin git@github.com:githubschool/open-enrollment-classes-introduction-to-github.git # Travis automatically clones via HTTPS -- this allows us to push using SSH
git push -u origin master
echo "All done."

