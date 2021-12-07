This repository contains the experimental integration packages for HA and CA.
It is based on based on `elastic/endpoint-package` and `elastic/apm-server/apmpackage`.

This is just the very first step by letting the package registry know about our agents.
Elastic Agent itself still needs to learn about these new executables and how to install and run them.
Finally the gRPC communication between our agents and the Elastic Agents needs to be established.

## Preparation

You need the `elastic-package` tool with versioning. To build the latest version:
```
git clone https://github.com/elastic/elastic-package
cd elastic-package
make build
```

## Building

`make` generates both integration packages, agent and collector.

`make pkgs=agent` creates just the agent package.

`make pkgs=collector` creates just the collector package.

`make clean` cleans up the build artifacts.

`make run-registry` builds the integration packages, pulls and runs the containerized Elastic Package Repository (EPR) together with the integration packages.

## How to test
```
$ make
$ make run-registry
$ curl localhost:8080/search?package=profiler_agent
[
  {
    "name": "profiler_agent",
    "title": "Profiler Agent",
    "version": "0.0.1",
    "release": "ga",
    "description": "Whole system profiling agent.",
    "type": "integration",
    "download": "/epr/profiler_agent/profiler_agent-0.0.1.zip",
    "path": "/package/profiler_agent/0.0.1",
    "icons": [
      {
        "src": "/img/profiler-logo-color-64px.svg",
        "path": "/package/profiler_agent/0.0.1/img/profiler-logo-color-64px.svg",
        "size": "16x16",
        "type": "image/svg+xml"
      }
    ],
    "policy_templates": [
      {
        "name": "profiler agent",
        "title": "Profiler Agent Integration",
        "description": "Interact with profiler agent."
      }
    ],
    "conditions": {
      "kibana": {
        "version": "^8.0.0"
      }
    },
    "owner": {
      "github": "elastic/profiling"
    },
    "categories": [
      "monitoring"
    ]
  }
]
```
