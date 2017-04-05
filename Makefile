.PHONY: build glide deps fmt imports lint vet test clean

NAME := sample
GOOS := linux
GOARCH := amd64
GLIDE_VERSION := 0.12.3
GLIDE_DOWNLOAD_URL := https://github.com/Masterminds/glide/releases/download/v$(GLIDE_VERSION)/glide-v$(GLIDE_VERSION)-linux-amd64.tar.gz

build: $(NAME).$(GOOS).$(GOARCH).gz

$(NAME).$(GOOS).$(GOARCH):
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(NAME) .
	mv $(NAME) $@

$(NAME).$(GOOS).$(GOARCH).gz: $(NAME).$(GOOS).$(GOARCH)
	gzip -f $<

glide:
	curl -fsSL "$(GLIDE_DOWNLOAD_URL)" -o glide.tar.gz
	tar -xzf glide.tar.gz
	mkdir -p /home/travis/bin
	mv linux-amd64/glide /home/travis/bin
	export PATH="$HOME/bin:$PATH"
	rm -rf glide.tar.gz
	rm -rf linux-amd64

deps:
	glide install
	go get -u golang.org/x/tools/cmd/goimports
	go get -u github.com/golang/lint/golint

fmt:
	find . -type f -name '*.go' -not -path "./vendor/*" | xargs -n 1 gofmt -d -e | tee gofmt.txt
	test ! -s gofmt.txt
	rm -rf gofmt.txt

imports:
	find . -type f -name '*.go' -not -path "./vendor/*" | xargs -n 1 goimports -d -e | tee goimports.txt
	test ! -s goimports.txt
	rm -rf goimports.txt

lint:
	glide novendor | xargs -n 1 golint | tee golint.txt
	test ! -s golint.txt
	rm -rf golint.txt

vet:
	glide novendor | xargs -n 1 go vet

test:
	glide novendor | xargs -n 1 go test -v

clean:
	rm -rf $(NAME).$(GOOS).$(GOARCH)
	rm -rf $(NAME).$(GOOS).$(GOARCH).gz
