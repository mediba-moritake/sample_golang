.PHONY: build glide deps test

NAME := hello
GOOS := linux
GOARCH := amd64
GLIDE_VERSION := 0.12.3
GLIDE_DOWNLOAD_URL := https://github.com/Masterminds/glide/releases/download/v$(GLIDE_VERSION)/glide-v$(GLIDE_VERSION)-linux-amd64.tar.gz

build: $(NAME).$(GOOS).$(GOARCH).gz

$(NAME).$(GOOS).$(GOARCH):
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(NAME) src/main.go
	mv $(NAME) $@

$(NAME).$(GOOS).$(GOARCH).gz: $(NAME).$(GOOS).$(GOARCH)
	gzip -f $<

glide:
	curl -fsSL "$(GLIDE_DOWNLOAD_URL)" -o glide.tar.gz
	tar -xzf glide.tar.gz
	mv linux-amd64/glide /home/travis/bin

deps:
	glide install

test:
	go test -v ./src/...

clean:
	-rm -rf $(NAME).$(GOOS).$(GOARCH)
	-rm -rf $(NAME).$(GOOS).$(GOARCH).gz
