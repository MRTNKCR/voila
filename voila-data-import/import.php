<?php

require('vendor/autoload.php');

use Aws\DynamoDb\DynamoDbClient;
use Aws\DynamoDb\Marshaler;

$filename = 'kolonial_products.json';

$client = new DynamoDbClient([
    'region' => 'eu-west-1',
    'version' => '2012-08-10',
]);

$marshaler = new Marshaler();
$data = json_decode(file_get_contents($filename), true);

foreach ($data as $i => $item) {
    dump(($i + 1) .': '. $item['name']);
    $item = current($marshaler->marshalValue($item));
    $res = $client->putItem([
        'TableName' => 'products',
        'Item' => $item,
    ]);
}
