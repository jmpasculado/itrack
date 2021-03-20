<?php
$con=mysqli_connect("localhost","root","","itrack");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

mysqli_query($con,"UPDATE inventory
SET    inventory.quantity = inventory.quantity - (SELECT   Quantity  FROM  orderdetails ORDER BY id DESC LIMIT 1)
WHERE  (SELECT   inventory FROM  orderdetails ORDER BY id DESC LIMIT 1)  = inventory.id ");

mysqli_close($con);
?>

