.PHONY: build glide deps test

NAME := hello
GOOS := linux
GOARCH := amd64

build: $(NAME).$(GOOS).$(GOARCH).gz

$(NAME).$(GOOS).$(GOARCH):
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(NAME) src/main.go
	mv $(NAME) $@

$(NAME).$(GOOS).$(GOARCH).gz: $(NAME).$(GOOS).$(GOARCH)
	gzip -f $<

glide:
	curl https://glide.sh/get | sh

deps:
	glide install

test:
	go test -v ./src/...

clean:
	-rm -rf $(NAME).$(GOOS).$(GOARCH)
	-rm -rf $(NAME).$(GOOS).$(GOARCH).gz
