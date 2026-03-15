FROM --platform=$BUILDPLATFORM golang:1.23 AS builder
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
ARG TARGETOS=linux TARGETARCH=amd64
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -ldflags="-s -w" -o argo-dispatch ./mcp-servers/argo-dispatch

FROM gcr.io/distroless/static:nonroot
COPY --from=builder /src/argo-dispatch /argo-dispatch
ENTRYPOINT ["/argo-dispatch"]
