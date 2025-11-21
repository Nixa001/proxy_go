package main

import (
	"fmt"
	"log"

	"proxy_go/internal/server"
)

func main() {
	if err := server.Run(); err != nil {
		log.Fatalf("could not start the server: %v", err)
	}
	fmt.Println("Server stopped")
}
