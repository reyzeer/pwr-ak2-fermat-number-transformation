#!/usr/bin/env php
<?php

$fermat_number_base = 4;
$fermat_number = pow(2, pow(2, $fermat_number_base)) + 1;

$alfa = 2;

$datain = [
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
];

$N = count($datain);

echo "Liczba Fermata o podstawie $fermat_number_base: $fermat_number\n";
echo "Alfa: $alfa\n";

$N = count($datain);

echo "Dlugosc wektora (N): $N\n";

//$count_element = 0;
//echo "Liczony element: $count_element\n";

$dataout = [];
for ($count_element = 0; $count_element < $N; $count_element++) {

  $sum = 0;
  for ($k = 0; $k < $N; $k++) {
    $x_k = $datain[$k];
    $kernel = pow($alfa, $count_element * $k);
    $sum += $x_k * $kernel;
  }

  $result = $sum % $fermat_number;

  echo "$count_element. Wynik: $result\n";

  $dataout[$count_element] = $result;

}

echo "Inwersja:\n";

//$dataout = [];
for ($count_element = 0; $count_element < $N; $count_element++) {

  $sum = 0;
  for ($k = 0; $k < $N; $k++) {
    $x_k = $dataout[$k];
    $kernel = pow($alfa, - ($count_element * $k));
    $sum += $x_k * $kernel;
  }

  $result = 1 / $N * $sum % $fermat_number;

  echo "$count_element. Wynik: $result\n";

  $dataout[$count_element] = $result;

}
