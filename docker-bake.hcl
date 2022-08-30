variable "PHP_IMAGE_TAG" {
  default="8.1"
}

target "_common" {
  platforms = [
    "linux/arm64",
    "linux/amd64",
  ]
  contexts = {
    php-base = "docker-image://php:${PHP_IMAGE_TAG}"
  }
}

target "test" {
  inherits = ["_common"]
  target = "test"
  contexts = {
    xdebug = "target:xdebug"
  }
}

group "default" {
  targets = [
    "xdebug",
  ]
}

target "compiler-base" {
  inherits = ["_common"]
  target = "compiler-base"
}

target "_extension" {
  inherits = ["_common"]
  target = "output"
  contexts = {
    compiler-base = "target:compiler-base"
  }
}

target "xdebug" {
  inherits = ["_extension"]
  context = "xdebug"
  tags = [
    "ciaranmcnulty/php-ext-xdebug:${PHP_IMAGE_TAG}",
  ]
}
