<?php

require 'vendor/autoload.php';

$client = new MongoDB\Client;

//$companydb = $client->companydb;
$billing = $client->billing;

//$result1 = $companydb->createCollection('empCollection');

$transaction = $billing->Transaction;
//$transaction = $billing->createCollection('transaction');
$product = $billing->Product;
//$product = $billing->createCollection('product');
$customer = $billing->Customer;
//$customer = $billing->createCollection('customer');
$cashier = $billing->Cashier;
//$cashier = $billing->createCollection('cashier');
$cashierlogin = $billing->CashierLogin;


// $document = array( 
//     "cash_id" => "2", 
//     "cash_name" => "nike", 
//     "cash_cell_no" => 1324576809,
//     "cash_ssn" => 1234567890,
//     "cash_email" => "nike@nike.com",
//     "cash_doj" => "07/09/2021"
//  );

 //$cashier->insertOne($document);
 //$result1->insertOne($document);

 echo "Document inserted successfully";

//var_dump($result1);
