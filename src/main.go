package main

import (
	"fmt"
	"github.com/mediba-moritake/sample_golang/src/hello"
)

func main() {
	hello := hello.Hello{Language: "Golang"}
	fmt.Println(hello.Hello())
}
