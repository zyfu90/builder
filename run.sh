#!/bin/bash
bazel build //test/...

## run image locally
# bazel run //test:myapp_image
# docker run -td bazel/test:myapp_image


## push image to repository
bazel run //test:push_myapp_image