#!/bin/bash
set -euo pipefail

repo=cbolt

files=( $(git diff "${CIRCLE_COMPARE_URL##*\/compare\/}" --name-only | xargs -r -n1 dirname | sort -u) )

echo "Logging into dockerhub"
docker login -u $DOCKER_USER -p $DOCKER_PASS

for f in "${files[@]}"; do
  base=${f%%\/*}
  tag=${f##*\/}
  build_dir=$f

  [ "$base" = ".skeleton" ] && continue
  [ "$base" = ".circleci" ] && continue
  [ ! -f "$build_dir/Dockerfile" ] && continue

  [ "$base" = "$tag" ] && tag=latest

  (
    set -x
    docker build -t ${repo}/${base}:${tag} ${build_dir}
    docker push ${repo}/${base}:${tag}
  )

  success="# Successfully built and pushed ${repo}/${base}:${tag} with context ${build_dir} #"
  border=$(printf '#%.0s' $(seq 1 "$(echo -n $success | wc -m)"))
  echo -e "${border}\n${success}\n${border}"
done
