#!/bin/sh
set -e

remote_repo="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

# Feature finish
if [[ -z "${INPUT_CURRENT_BRANCH##*$INPUT_FEATURE_BRANCH_PREFIX*}" ]] ;then
    # git push "${remote_repo}" HEAD:${INPUT_DEVELOPMENT_BRANCH} --follow-tags;
    # git remote -v 
    # git branch -a
    # git branch -D remotes/origin/${INPUT_CURRENT_BRANCH}
    # git push origin :${INPUT_CURRENT_BRANCH}
    # git push "${remote_repo}" HEAD:":${INPUT_CURRENT_BRANCH}" --force;
    curl \
        -X DELETE \
        -H "Accept: application/vnd.github.v3+json; Authorization: Bearer ${INPUT_GITHUB_TOKEN}" \
        https://api.github.com/repos/mlucascardoso/git-flow-ci-cd-action/git/refs/heads/feature/test-feature;
        # https://api.github.com/repos/${GITHUB_ACTOR}/${GITHUB_REPOSITORY}/git/refs/${INPUT_CURRENT_BRANCH};
    
    echo https://api.github.com/repos/${GITHUB_REPOSITORY}/git/refs/${INPUT_CURRENT_BRANCH}
    # /repos/{owner}/{repo}/git/refs/{ref}
    # https://api.github.com/repos/mlucascardoso/git-flow-ci-cd-action/git/refs/feature/test-feature
    
    echo "feature"
elif [[ -z "${INPUT_CURRENT_BRANCH##*$INPUT_BUGFIX_BRANCH_PREFIX*}" ]] ;then
    echo "bugfix"
elif [[ -z "${INPUT_CURRENT_BRANCH##*$INPUT_RELEASE_BRANCH_PREFIX*}" ]] ;then
    echo "release"
elif [[ -z "${INPUT_CURRENT_BRANCH##*$INPUT_HOTFIX_BRANCH_PREFIX*}" ]] ;then
    echo "hotfix"
elif [[ -z "${INPUT_CURRENT_BRANCH##*$INPUT_SUPPORT_BRANCH_PREFIX*}" ]] ;then
    echo "support"
fi

