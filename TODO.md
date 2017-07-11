# TODO
- https://github.com/goldmann/docker-squash squash docker images after they
  were built. This should allow us the introduction of cache layers that speed
  up our builds, while enabling us to build even smaller images. We can use
  https://hub.docker.com/r/rassie/docker-squash/ in CircleCI.
