.PHONY: proxy tidy fmt lint

tidy:
	@go mod tidy -e -v

fmt:
	@find . -name '*.go' -not -path "./vendor/*" -not -name "*.pb.go" | xargs gofumpt -w -s -extra
	@find . -name '*.go' -not -path "./vendor/*" -not -name "*.pb.go" | xargs -n 1 -I {} -t goimports-reviser -file-path {} -local "github.com" project-name "github.com/33cn/go-kit/" -rm-unused
	@find . -name '*.sh' -not -path "./vendor/*" | xargs shfmt -w -s -i 2 -ci -bn -sr

lint:
	@golangci-lint run ./...

pre-commit: tidy fmt lint
