# Chainpoint OpenNTPD

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## About

A Docker container running Alpine Linux and [OpenNTPD](http://www.openntpd.org/index.html).

## Running

Docker Compose from this repository:

```
make up
```

As a standalone Docker container:

```
docker run --cap-add=SYS_TIME --cap-add=SYS_NICE --restart=always -d quay.io/chainpoint/chainpoint-ntpd
```

Docker Compose: Add something like this to your `docker-compose.yaml` file:

```
version: '2.1'

services:
  chainpoint-ntpd:
    build: .
    image: quay.io/chainpoint/chainpoint-ntpd:latest
    container_name: chainpoint-ntpd
    hostname: ntpd
    restart: on-failure:2
    cap_add:
      - SYS_TIME
      - SYS_NICE
    mem_limit: 64M

```

## License

[Apache License, Version 2.0](https://opensource.org/licenses/Apache-2.0)

```
Copyright (C) 2017 Tierion

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
