# ----- U S A G E -----
# Call this script from the root directory of the project
# _helpers/shell-scripts/build_site.sh "git commit message"
# ---------------------


git config credential.username "mikedane"
git pull origin gh-pages
git pull origin master 

echo "Deleting old publication"
rm -rf _site
mkdir _site
git worktree prune
rm -rf .git/worktrees/_site/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages _site origin/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
jekyll build

echo "Updating master branch"
git add .
git commit -m "$1"
git push origin master

echo "Updating gh-pages branch"
cd _site && git add --all && git commit -m "$1"
git push origin gh-pages
cd ..

# echo "Updating code samples"
# cd code-samples
# git add .
# git commit -m "let's learn"
# git push origin master
# cd ..