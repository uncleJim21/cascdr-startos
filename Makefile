ASSETS := $(shell yq e '.assets.[].src' manifest.yaml)
ASSET_PATHS := $(addprefix assets/,$(ASSETS))
PKG_VERSION := $(shell yq e ".version" manifest.yaml)
PKG_ID := $(shell yq e ".id" manifest.yaml)
HEALTH_CHECK := $(shell find ./check-rest.sh)
TS_FILES := $(shell find . -name \*.ts )

.DELETE_ON_ERROR:

all: verify

clean:
	rm -rf docker-images
	rm -f  $(PKG_ID).s9pk
	rm -f image.tar
	rm -f scripts/*.js

verify: $(PKG_ID).s9pk
	start-sdk verify s9pk $(PKG_ID).s9pk

install: $(PKG_ID).s9pk
	start-cli package install $(PKG_ID).s9pk

# for rebuilding just the arm image. will include docker-images/x86_64.tar into the s9pk if it exists
arm: docker-images/aarch64.tar scripts/embassy.js
	start-sdk pack

# for rebuilding just the x86 image. will include docker-images/aarch64.tar into the s9pk if it exists
x86: docker-images/x86_64.tar scripts/embassy.js
	start-sdk pack

$(PKG_ID).s9pk: manifest.yaml instructions.md scripts/embassy.js LICENSE docker-images/aarch64.tar docker-images/x86_64.tar
	start-sdk pack

docker-images/aarch64.tar: Dockerfile docker_entrypoint.sh $(TS_FILES) $(HEALTH_CHECK)
	mkdir -p docker-images
	DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --tag start9/$(PKG_ID)/main:$(PKG_VERSION) --build-arg ARCH=aarch64 --build-arg PLATFORM=arm64 --platform=linux/arm64 -o type=docker,dest=docker-images/aarch64.tar .

docker-images/x86_64.tar: Dockerfile docker_entrypoint.sh $(TS_FILES) $(HEALTH_CHECK)
	mkdir -p docker-images
	DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --tag start9/$(PKG_ID)/main:$(PKG_VERSION) --build-arg ARCH=x86_64 --build-arg PLATFORM=amd64 --platform=linux/amd64 -o type=docker,dest=docker-images/x86_64.tar .

scripts/embassy.js: $(TS_FILES)
	deno bundle scripts/embassy.ts scripts/embassy.js
