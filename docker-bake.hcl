variable "PHP_IMAGE_TAG" {
  default="8.1"
}

group "default" {
  targets = [
    "xdebug",
  ]
}

target "xdebug" {
  target = "xdebug"
  inherits = ["_tagged"]
  tags = [
    "ciaranmcnulty/php-ext-xdebug:${PHP_IMAGE_TAG}"
  ]
}

target "test" {
  target = "test"
  inherits = ["_tagged"]
}

target "_tagged" {
  args = {
    TAG = "${PHP_IMAGE_TAG}"
  }
}
