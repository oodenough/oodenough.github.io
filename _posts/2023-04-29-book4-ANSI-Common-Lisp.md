---
categories: w books       
tags: [book, program, lisp]
---

# ANSI Common Lisp -- Paul Graham
Some comments: [northwestern.edu](https://courses.cs.northwestern.edu/325/readings/graham/graham-notes.html)

## All Functions
`1. list` builds lists
```lisp
> (list 'my (+ 1 2) "Sons")
(MY 3 "Sons")
```
`2. cons` builds lists
```lisp
> (cons 'a '(b c d)) ;return a new list with the first element added to the front if its second argument is a list
(A B C D)
> (cons 'a (cons 'b nil));build up lists by consing new elements onto an empty list(nil)
(A B)
> (cons 'a 'b)
(A B)
```
`3. car 4. cdr 5. third fourth...` can extract the elements of lists
```lisp
> (car (cdr (cdr '(a b c d))));use combinations to reach any element of a list
C
> (third '(a b c d));or simply call third 
C
```
`6. listp` returns true if its argument is a list
```list
> (listp '(a b c))
T
```
`7. null and not and or`
```lisp
> (null nil)
T
> (not nil)
T
```

### Chapter1 Introduction

### Chapter2 Welcome to Lisp

#### 2.1 Form
Lisp is an interactive language. Any Lisp system will include an interactive front-end called the `toplevel`.

#### 2.2 Evaluation
In Lisp, `+` is a function, and an `expression` like (+ 2 3) is a `function call`.

Not all the `operators` in Common Lisp are functions, but most are.
`evaluation rule`:the arguments are evaluated left-to-right, and their values are passed to the function, which returns the value of the expression as a whole.

`special operator` doesn't follow the `evaluation rule`. the `quote` operator is one of them, it takes a single argument, and just returns it verbatim.
```lisp
> (list '(+ 2 1) (+ 2 1))
((+ 2 1) 3)
```

For convenience, Common Lisp defines `'` as an abbreiation for `quote`.

#### 2.3 Data
two Lisp `data types` we don't commonly find in other languages are `symbols` and `lists`.

`symbols` are words, ordinarily converted to uppercase, not (usually) evaluate to themselves, so `quote` it when refering them.

`lists` are represented as zero or more elements enclosed in parentheses.

Two ways of representing the empty list in cl:`()` or `nil`

`nil` evaluates to itself ==> no `quote` needed

#### 2.4 List Operations
1. cons
2. car cdr
3. third

#### 2.5 Truth
symbol `t` representes truth. Like `nil`, `t` evaluates to itself.

function 6 `listp`

a function whose return value is intended to be interpreted as truth or falsity is called a `predicate`. CL predicates ofter have names that end with `p`.

###### conditional => if
(if (`test` expression)
    (`then` expression)
    (`else` expression))

`else` is optional, if you omit it, it defaults to `nil`.
```lisp
> (if (listp '(a b c))
      (+ 1 2)
      (+ 5 6))
3

```
like `quote`, `if` is a `special operator`. It could not possibly be implemented as a function, because the arguments in a function call are always evaluated, and the whole point of if is that only one of the last two arguments is evaluated.

Everything except `nil` also counts as true in a logical context:
```lisp
> (if 27 1 2)
1
```

The `logical operators` like `and` and `or` resemble conditionals.
`or` stops as soon as it finds an argument that is true.
These two `operators` are `macros`. Like `special operators`, `macros` can circumvent the usual evaluation rule.

#### 2.6 Functions
define new functions with `defun`. it usually take three arguments.
```lisp
(defun name (a list of parameters)
  (one or more expressions)
  (that will make up the body of the function))
```
example:
```lisp
(defun find-third (x)
  (car (cdr (cdr x))))
```
the second argument, the `list` (x), says that the find-third function will take exactly one argument:x. 

A `symbol` used as a `placeholder` in this way is called a `variable`. Also called a `parameter` when representing an argument to a function as `x` does here.

`symbols` are `variable names`, existing as `objects` in their own right. A list has to be quoted because otherwise it will be treated as code; a symbol has to be quoted because otherwise it will be treated as a variable.

`Lisp makes no distinction between a program, a procedure, and a function.`

#### 2.7 Recursion

