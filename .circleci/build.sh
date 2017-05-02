#!/bin/bash
set -euo pipefail

files=( $(git diff "${CIRCLE_COMPARE_URL##*\/compare\/}" --name-only | xargs -r -n1 dirname | sort -u) )

for f in "${files[@]}"; do
  base=${f%%\/*}
  tag=${f##*\/}
  build_dir=$f

  [ "$base" = "_skeleton_" ] && continue
  [ "$base" = ".circleci" ] && continue
  [ ! -f "$build_dir/Dockerfile" ] && continue

  [ "$base" = "$tag" ] && tag=latest

  (
    set -x
    docker build -t ${base}:${tag} ${build_dir}
    docker push ${base}:${tag}
  )

  success="# Successfully built and pushed ${base}:${tag} with context ${build_dir} #"
  border=$(printf '#%.0s' $(seq 1 "$(echo -n $success | wc -m)"))
  echo -e "${border}\n${success}\n${border}"
done
