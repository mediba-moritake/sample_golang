package hello

// Hello 構造体
type Hello struct {
	Language string
}

// Hello メソッド
func (f *Hello) Hello() string {
	return "Hello, " + f.Language

}
