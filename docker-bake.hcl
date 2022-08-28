variable "TAG" {
  default="8.1"
}

group "default" {
  targets = [
    "xdebug",
  ]
}

target "xdebug" {
  target = "xdebug-output"
  inherits = ["_tagged"]
  tags = [
    "ciaranmcnulty/php-ext-xdebug:${TAG}"
  ]
}

group "test" {
  targets = [
    "xdebug-test",
  ]
}

target "xdebug-test" {
  target = "xdebug-test"
  inherits = ["_tagged"]
}

target "_tagged" {
  args = {
    TAG = "${TAG}"
  }
}
