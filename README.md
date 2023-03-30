This repository contains the experimental integration package for continous profiling.
It is based on `elastic/endpoint-package` and `elastic/apm-server/apmpackage`.

## Requirements

You need to have `elastic-package` installed. You can do this by:
```
go install github.com/elastic/elastic-package@latest
```

## Building

`make` generates the integration package.

`make clean` cleans up the build artifacts.

`make run-registry` builds the integration packages, pulls and runs the containerized Elastic Package Repository (EPR) together with the integration packages.
 By default the 'production' distribution / container is selected. Use the snapshot (or any other) distribution with
 `DISTRIBUTION=snapshot make run-registry`.

## How to test the package registry

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
    "download": "/epr/profiler_agent/profiler_agent-2.4.1.zip",
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
        "version": "^8.5.0"
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

## How to test the integration with the complete stack

```
$ elastic-package stack up
```

Then browse to `http://localhost:5601/` and log in as user `elastic` with password `changeme` and
test the integration.
