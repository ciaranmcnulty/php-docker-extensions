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
  inherits = ["_template"]
  tags = [
    "ciaranmcnulty/php-ext-xdebug:${PHP_IMAGE_TAG}",
  ]
}

target "test" {
  target = "test"
  inherits = ["_template"]
}

target "_template" {
  args = {
    TAG = "${PHP_IMAGE_TAG}",
  }
  platforms = [
    "linux/arm64",
    "linux/amd64",
  ]
}
