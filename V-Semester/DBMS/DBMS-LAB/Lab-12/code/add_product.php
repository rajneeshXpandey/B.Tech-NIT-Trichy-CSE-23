<?php
session_start();
if (!$_SESSION['auth']) {
    header("HTTP/1.1 401 Unauthorized");
    exit;
}
require_once __DIR__ . '/vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();
$client = new MongoDB\Client(
    'mongodb://' . $_ENV['MDB_URL'] . '/BILL'
);

$id = $name = $brand = $price = $res = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id = $_POST["id"];
    $name = $_POST["name"];
    $brand = $_POST["brand"];
    $price = $_POST["price"];

    $product_coll = $client->BILL->product;

    $insertOneProdRes = $product_coll->insertOne([
        'id' => $id,
        'name' => $name,
        'brand' => $brand,
        'price' => $price
    ]);

    $res = $insertOneProdRes->getInsertedCount();
}
?>
<html>

<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>

    <title>Add Products</title>
    <style>
        .error {
            color: #FF0000;
        }
    </style>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Bill Portal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="add_product.php">Add Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="bill.php">Transaction</a>
                    </li>
                </ul>
            </div>

            <div class="d-flex">
                <a href='logout.php' class="btn btn-outline-success" type="submit">Logout</a>
            </div>
        </div>
    </nav>
    <div class="container">
        <h4>Add Products to Inventory</h4>
        <form method="post" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>">
            <div class="mb-3 row">
                <label for="exampleFormControlInput1" class="col-sm-2 col-form-label">Id</label>
                <div class="col-sm-10">
                    <input type="text" name="id" value="<?php echo $id; ?>" class="form-control" id="exampleFormControlInput1" placeholder="Enter Id">
                </div>
            </div>

            <div class=" mb-3 row">
                <label for="exampleFormControlInput1" class="col-sm-2 col-form-label">Name</label>
                <div class="col-sm-10">
                    <input type="text" name="name" value="<?php echo $name; ?>" class="form-control" id="exampleFormControlInput1" placeholder="Enter Name">
                </div>
            </div>

            <div class="mb-3 row">
                <label for="exampleFormControlInput1" class="col-sm-2 col-form-label">Brand</label>
                <div class="col-sm-10">
                    <input type="text" name="brand" value="<?php echo $brand; ?>" class="form-control" id="exampleFormControlInput1" placeholder="Enter Brand">
                </div>
            </div>

            <div class="mb-3 row">
                <label for="exampleFormControlInput1" class="col-sm-2 col-form-label">Price</label>
                <div class="col-sm-10">
                    <input type="number" name="price" value="<?php echo $price; ?>" class="form-control" id="exampleFormControlInput1" placeholder="Enter Price">
                </div>
            </div>

            <input class="btn btn-primary" type="submit" name="submit" value="Submit">
        </form>
        <div>
</body>

</html>