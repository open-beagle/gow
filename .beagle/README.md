# gow

<https://github.com/games-on-whales/gow>

```bash
git remote add upstream git@github.com:games-on-whales/gow.git

git fetch upstream

# 2024.11.25
git merge upstream/master
```

## images

```bash
docker pull ubuntu:22.04 && \
docker tag ubuntu:22.04 registry.cn-qingdao.aliyuncs.com/wod/ubuntu:v22.04-amd64 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/ubuntu:v22.04-amd64
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=${S3_ENDPOINT_ALIYUN} \
  -e PLUGIN_ACCESS_KEY=${S3_ACCESS_KEY_ALIYUN} \
  -e PLUGIN_SECRET_KEY=${S3_SECRET_KEY_ALIYUN} \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="gow" \
  -e PLUGIN_MOUNT="./.git" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=${S3_ENDPOINT_ALIYUN} \
  -e PLUGIN_ACCESS_KEY=${S3_ACCESS_KEY_ALIYUN} \
  -e PLUGIN_SECRET_KEY=${S3_SECRET_KEY_ALIYUN} \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="gow" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
