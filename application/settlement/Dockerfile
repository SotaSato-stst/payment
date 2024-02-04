# ビルドステージ
FROM golang:1.21-alpine AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download
COPY . ./
RUN CGO_ENABLED=0 go build -ldflags '-s -w' -trimpath -a main.go

# 最終イメージを作成するステージ
FROM gcr.io/distroless/static-debian11:nonroot
COPY --chmod=755 --from=builder /app/main ./

USER nonroot

EXPOSE 50051

ENTRYPOINT [ "./main" ]
