Interval extension
==================
This extension provides a representation of numeric intervals.  
Custom syntax for constructing an interval is provided:
`interval i = intr[-14.2, 100];`

The standard arithmetic (and equality) operators are overloaded: 
* `-i`: Interval negation
* `~i`: Interval inverse
* `i1 + i2`: Interval addition
* `i1 - i2`: Interval subtraction
* `i1 * i2`: Interval multiplication
* `i1 / i2`: Interval division
* `i1 == i2`: Interval equality

The `show()` operator introduced by the string extension is also overloaded to create a string representation of an interval.  

