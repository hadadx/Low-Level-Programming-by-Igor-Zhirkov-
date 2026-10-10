# A&Q
___

 **Question 148 What is a literal?**
A literal is a value written directly in the source code like 4 6 "sdef" f
 
**Question 149 What are lvalue and rvalue?**
**lvalue** = an expression that refers to an object/location in memory.
**rvalue** = a value used in an expression.
```
x  -> lvalue
5  -> rvalue
```

x = x + 1;

The left `x` is used as an **lvalue** because we store into it.
The right `x` is used for its **value**, so there it behaves as an **rvalue**.


**Question 150 What is the difference between the statements and expressions?**
An expression produces a value, while a statement performs an action.

Example:
```
x + 5
```
This is an **expression** because it produces a value.
```
x = 5;
```
This is a **statement** because it performs an assignment.

**Question 151 What is a block of statements?**
A **block of statements** is a group of statements enclosed in braces `{ }`.

Example:

```
{
    int x = 5;
    x = x + 1;
    printf("%d", x);
}
```


**Question 152 how do you define a preprocessor symbol?**
You define a preprocessor symbol using `#define`.

 **Question 153 Why is break necessary at the end of each switch case?**
`break` stops execution of the current `case` and exits the `switch`.
Without `break`, execution continues into the next case. This is called **fall-through**.


**Question 154 how are truth and false values encoded in C89?**
falde = 0 , true = every thing that not 0 

**Question 155 What is the first argument of printf function?**
The first argument of `printf` is a pointer to the format string.




**Question 156 Is printf checking the types of its arguments?**
No


**Question 157 Where can you declare variables in C89?**
In C89, variables must be declared at the beginning of a block, before any executable statements.


