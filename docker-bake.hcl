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
    bcmath = "target:bcmath",
    pcntl = "target:pcntl",
    xdebug = "target:xdebug",
  }
}

group "default" {
  targets = [
    "bcmath",
    "pcntl",
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

target "bcmath" {
  inherits = ["_extension"]
  context = "ext-bcmath"
  tags = [
    "ciaranmcnulty/php-ext-bcmath:${PHP_IMAGE_TAG}",
  ]
}

target "pcntl" {
  inherits = ["_extension"]
  context = "ext-pcntl"
  tags = [
    "ciaranmcnulty/php-ext-pcntl:${PHP_IMAGE_TAG}",
  ]
}

target "xdebug" {
  inherits = ["_extension"]
  context = "ext-xdebug"
  tags = [
    "ciaranmcnulty/php-ext-xdebug:${PHP_IMAGE_TAG}",
  ]
}
