<?php

# page size is capped at 100
$nextPage = "https://hub.docker.com/v2/repositories/library/php/tags?page_size=100";
$minVersion = "8.1.0";

while (is_string($nextPage)) {
    file_put_contents('php://stderr', "Fetching from $nextPage\n");
    $data = json_decode(file_get_contents($nextPage), true);
    $nextPage = $data['next'];

    foreach ($data['results'] as $result) {
        $is_supported = true;

        if (preg_match('/^[0-9.]+/', $result['name'], $matches)) {
            $is_supported = version_compare($matches[0], $minVersion, 'ge');
        }

        if (preg_match('/RC[0-9]/', $result['name']) || str_contains('rc-', $result['name'])) {
            $is_supported = false;
        }

        if (str_contains($result['name'], 'alpha') || str_contains($result['name'], 'beta')) {
            $is_supported = false;
        }

        if (preg_match('/alpine3.(?!:15)/', $result['name'])) {
            $is_supported = false;
        }

        if (
            str_contains($result['name'], 'jessie')
            || str_contains($result['name'], 'stretch')
            || str_contains($result['name'], 'buster')
        ) {
            $is_supported = false;
        }

        if ($is_supported) {
            file_put_contents('php://stdout', $result['name']. "\n");
        }
    }
}
