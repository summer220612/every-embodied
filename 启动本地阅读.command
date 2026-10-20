#!/bin/zsh
set -eu

repo_dir="$(cd -- "$(dirname -- "$0")" && pwd)"
site_dir="$repo_dir/dist"
base_url="http://127.0.0.1:5178/zh-cn"
chapter_id="MDEt5YW36Lqr5pm66IO95qaC6L-wL21vZHVsZTFfMl_mnLrlmajkurrns7vnu5_nu4TmiJDkuI7liIbnsbsvUkVBRE1FLm1k"

if [[ ! -f "$site_dir/zh-cn/data/catalog.json" ]]; then
  cd "$repo_dir"
  if [[ ! -d node_modules ]]; then
    npm ci --no-audit --no-fund
  fi
  npm run build:pages
fi

mkdir -p "$repo_dir/artifacts"
if ! /usr/bin/curl --noproxy '*' -fsS --max-time 2 "$base_url/data/catalog.json" >/dev/null 2>&1; then
  nohup /usr/bin/python3 -m http.server 5178 --bind 127.0.0.1 --directory "$site_dir" \
    >"$repo_dir/artifacts/local-reader.log" 2>&1 </dev/null &
  for attempt in {1..20}; do
    if /usr/bin/curl --noproxy '*' -fsS --max-time 2 "$base_url/data/catalog.json" >/dev/null 2>&1; then
      break
    fi
    sleep 0.25
  done
fi

if /usr/bin/curl --noproxy '*' -fsS --max-time 2 "$base_url/data/catalog.json" >/dev/null 2>&1; then
  print "本地电子书已启动：$base_url/"
  /usr/bin/open "$base_url/#/doc/$chapter_id"
else
  print -u2 "启动失败，请查看 $repo_dir/artifacts/local-reader.log（端口 5178 可能被占用）。"
  read -r "?按回车退出。"
  exit 1
fi
