<?php 

// From Tshirtecommerce version 4.1.5

$product = $params['product'];
$data = $params['data'];

$price_option_oc = isset($data['price_option_oc']) ? $data['price_option_oc'] : 0;

$product->price = (isset($data['price_old_oc']) ? $data['price_old_oc'] : 0) + (float)$price_option_oc;
$product->sale_price = (isset($data['price_sale_oc']) ? $data['price_sale_oc'] : 0) + (float)$price_option_oc;
$product->tax = isset($data['price_taxes']) ? $data['price_taxes'] : 0;

$GLOBALS['product'] = $product;

?>