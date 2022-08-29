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

target "test" {
  target = "test"
  inherits = ["_tagged"]
}

target "_tagged" {
  args = {
    TAG = "${TAG}"
  }
}
