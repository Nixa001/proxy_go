# Proxy Go

A lightweight, configurable reverse proxy server written in Go that routes HTTP requests to multiple backend services based on endpoint paths.

## Features

- 🚀 Simple reverse proxy implementation using Go's `httputil.ReverseProxy`
- ⚙️ YAML-based configuration for easy management
- 🔀 Route requests to multiple backend services based on path
- 💚 Built-in health check endpoint
- 📝 Request logging with timestamps
- 🐳 Docker-ready setup for testing with multiple backend services

## Prerequisites

- Go 1.25.4 or higher
- Docker (optional, for running demo services)

## Project Structure

```
proxy_go/
├── cmd/
│   └── main.go              # Application entry point
├── internal/
│   ├── configs/
│   │   └── config.go        # Configuration loader using Viper
│   └── server/
│       ├── server.go        # HTTP server setup
│       ├── proxy_handler.go # Reverse proxy handler logic
│       └── healthcheck.go   # Health check endpoint
├── settings/
│   └── config.yaml          # Server and routing configuration
├── go.mod                   # Go module dependencies
├── Makefile                 # Build and run commands
└── README.md
```

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd proxy_go
```

2. Install dependencies:
```bash
go mod download
```

## Configuration

Edit the `settings/config.yaml` file to configure your proxy server:

```yaml
server:
  host: "localhost"
  listen_port: "8080"

resources:
  - name: Server1
    endpoint: /server1
    destination_url: "http://localhost:8081"
  - name: Server2
    endpoint: /server2
    destination_url: "http://localhost:8082"
  - name: Server3
    endpoint: /server3
    destination_url: "http://localhost:8083"
```

### Configuration Options

- **server.host**: The host address to bind the proxy server to
- **server.listen_port**: The port on which the proxy server listens
- **resources**: Array of routing rules
  - **name**: Descriptive name for the resource
  - **endpoint**: URL path prefix to match
  - **destination_url**: Target backend service URL

## Usage

### Running the Proxy Server

Using Make:
```bash
make run-proxy-server
```

Or directly with Go:
```bash
go run cmd/main.go
```

The server will start on `http://localhost:8080` (or as configured).

### Running Demo Backend Services (Optional)

To test the proxy with Docker containers:

```bash
make run-containers
```

This will start three demo services on ports 8081, 8082, and 8083.

To stop the demo services:
```bash
make stop
```

### Health Check

Check if the proxy server is running:
```bash
curl http://localhost:8080/ping
```

Expected response: `pong`

### Making Requests Through the Proxy

Once configured, requests to the proxy endpoints will be forwarded to the respective backend services:

```bash
# Request to /server1 will be proxied to http://localhost:8081
curl http://localhost:8080/server1

# Request to /server2 will be proxied to http://localhost:8082
curl http://localhost:8080/server2

# Request to /server3 will be proxied to http://localhost:8083
curl http://localhost:8080/server3
```

## How It Works

1. The proxy server reads configuration from `settings/config.yaml`
2. For each resource, it creates a reverse proxy pointing to the destination URL
3. When a request matches an endpoint, the proxy:
   - Logs the incoming request
   - Updates request headers (X-Forwarded-Host, Host)
   - Modifies the URL scheme and host
   - Strips the endpoint prefix from the path
   - Forwards the request to the backend service
   - Returns the backend response to the client

## Dependencies

- [Viper](https://github.com/spf13/viper) - Configuration management

## Development

### Available Make Commands 

- `make run-proxy-server` - Start the proxy server
- `make run-containers` - Start demo Docker containers
- `make stop` - Stop all demo containers
### Or run your app server for test