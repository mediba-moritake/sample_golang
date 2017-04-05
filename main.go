package main

import (
	"fmt"

	"github.com/mediba-moritake/sample_golang/hello"
)

func main() {
	hello := hello.Hello{Language: "Golang"}
	fmt.Println(hello.Hello())
}
