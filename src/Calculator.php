<?php

namespace App;

class Calculator
{
    /**
     * Suma dos números enteros
     * 
     * @param int $a Primer número
     * @param int $b Segundo número
     * @return int Resultado de la suma
     */
    public function add(int $a, int $b): int
    {
        return $a + $b;
    }

    /**
     * Resta dos números enteros
     * 
     * @param int $a Primer número
     * @param int $b Segundo número
     * @return int Resultado de la resta
     */
    public function subtract(int $a, int $b): int
    {
        return $a - $b;
    }

    /**
     * Multiplica dos números enteros
     * 
     * @param int $a Primer número
     * @param int $b Segundo número
     * @return int Resultado de la multiplicación
     */
    public function multiply(int $a, int $b): int
    {
        return $a * $b;
    }
}
