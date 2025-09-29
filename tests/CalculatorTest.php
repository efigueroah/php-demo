<?php

namespace Tests;

use PHPUnit\Framework\TestCase;
use App\Calculator;

class CalculatorTest extends TestCase
{
    private Calculator $calculator;

    protected function setUp(): void
    {
        $this->calculator = new Calculator();
    }

    public function testAddTwoPositiveNumbers()
    {
        $result = $this->calculator->add(3, 2);
        $this->assertEquals(5, $result);
    }

    public function testAddPositiveAndNegativeNumbers()
    {
        $result = $this->calculator->add(10, -3);
        $this->assertEquals(7, $result);
    }

    public function testAddTwoNegativeNumbers()
    {
        $result = $this->calculator->add(-5, -3);
        $this->assertEquals(-8, $result);
    }

    public function testAddZero()
    {
        $result = $this->calculator->add(5, 0);
        $this->assertEquals(5, $result);
    }

    public function testSubtractNumbers()
    {
        $result = $this->calculator->subtract(10, 3);
        $this->assertEquals(7, $result);
    }

    public function testMultiplyNumbers()
    {
        $result = $this->calculator->multiply(4, 3);
        $this->assertEquals(12, $result);
    }
}
