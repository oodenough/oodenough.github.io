---
categories: w books       
tags: [book, program, lisp]
---

# ANSI Common Lisp -- Paul Graham
Some comments: [northwestern.edu](https://courses.cs.northwestern.edu/325/readings/graham/graham-notes.html)

## All Functions
1. `list` builds lists
```lisp
> (list 'my (+ 1 2) "Sons")
(MY 3 "Sons")
```
2. `cons` builds lists
```lisp
> (cons 'a '(b c d)) ;return a new list with the first element added to the front if its second argument is a list
(A B C D)
> (cons 'a (cons 'b nil));build up lists by consing new elements onto an empty list(nil)
(A B)
> (cons 'a 'b)
(A B)
```
3. `car` 
4. `cdr` 
5. `third and fourth...` can extract the elements of lists
```lisp
> (car (cdr (cdr '(a b c d))));use combinations to reach any element of a list
C
> (third '(a b c d));or simply call third 
C
```
6. `listp` returns true if its argument is a list
other predicate function:`numberp`
```list
> (listp '(a b c))
T
```
7. `null and not and or`
```lisp
> (null nil)
T
> (not nil)
T
```
8. `member` tests whether something is an element of a list
```lisp
> (member 'a '(b c))
NIL
> (member 'c '(a c b))
(C B)
> (member 'c '(a c b c d e))
(C B C D E)
```
9. `memberp`
10. `format and read`
11. `boundp`
12. `remove` takes an object and a list and returns a new list containing everything but that object
```lisp
> (setf lst '(c a r a t))
(C A R A T)
> (remove 'a lst)
(C R T);the original list is untouched
> lst
(C A R A T)
> (setf lst (remove 'a lst));change the original list
```
13. `progn` takes any number of expressions, evaluates them in order, and returns the value of the last.
14. `apply and funcall`
15. `typep`
```lisp
> (typep 27 'integer)
T
```

## Chapter1 Introduction

## Chapter2 Welcome to Lisp

### 2.1 Form
Lisp is an interactive language. Any Lisp system will include an interactive front-end called the `toplevel`.

### 2.2 Evaluation
In Lisp, `+` is a function, and an `expression` like (+ 2 3) is a `function call`.

Not all the `operators` in Common Lisp are functions, but most are.
`evaluation rule`:the arguments are evaluated left-to-right, and their values are passed to the function, which returns the value of the expression as a whole.

`special operator` doesn't follow the `evaluation rule`. the `quote` operator is one of them, it takes a single argument, and just returns it verbatim.
```lisp
> (list '(+ 2 1) (+ 2 1))
((+ 2 1) 3)
```

For convenience, Common Lisp defines `'` as an abbreiation for `quote`.

### 2.3 Data
two Lisp `data types` we don't commonly find in other languages are `symbols` and `lists`.

`symbols` are words, ordinarily converted to uppercase, not (usually) evaluate to themselves, so `quote` it when refering them.

`lists` are represented as zero or more elements enclosed in parentheses.

Two ways of representing the empty list in cl:`()` or `nil`

`nil` evaluates to itself ==> no `quote` needed

### 2.4 List Operations
1. cons
2. car cdr
3. third

### 2.5 Truth
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

### 2.6 Functions
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

### 2.7 Recursion
a simplified version of `member` function defined as a recursive function
```lisp
(defun our-member (obj lst)
  (if (null lst)
      nil
      (if (eql (car lst) obj)
	  lst
	  (our-member obj (cdr lst))))) 
```
some critical comments on Graham's preference for `if` over `cond`=> [click](https://courses.cs.northwestern.edu/325/readings/graham/chap2-notes.html)
`cond` example:
```lisp
(cond (condition1 expression)
      (condition2 expression)
      ...
      (conditionn expression)
```
a better vision of `our-member`:avoids the `nested conditional`
```lisp
(defun our-member (obj lst)
  (cond ((null lst) nil)
	((eql (car lst) obj) lst)
	(t (our-member obj (cdr lst)))))
```
A better metaphor for a function would be to think of it as a `process`.

### 2.8 Reading Lisp
Lisp programmers read and write code by indentation, not by parentheses.

Because everyone uses the same conventions, you can read code by the indentation, and ignore the parentheses.

### 2.9 Input and Output
`format` function takes two or more arguments: the first indecates where the output is to be printed, the second is a string template, and the remaining arguments are usually objects whose printed representions are to be inserted into the template.
```lisp
> (format t "~A plus ~A equals ~A.~%" 2 3 (+ 2 3))
2 plus 3 equals 5.
NIL
```
`NIL` is the value returned by the call to format, displayed in the usual way by the `toplevel`. 

Ordinarily a function like `format` is not called directly from the toplevel, but used within programs, so the return value is never seen.

`t` indicates that the output is to be sent to the default place. Ordinarily this will be the `toplevel`.

`~A` indicates a position to be filled, and the `~%` indicates a newline. The positions are filled by the values of the remaining arguments, in orger.

`read` function is a standard function for input. When given no arguments, it reads from the default place, which will usually be the `toplevel`.
```lisp
(defun ask (str)
  (format t "~A " str)
  (read))

> (ask "How old are you?")
How old are you? 23

23
```
`Bear in mind` that `read` will sit waiting indefinetely until you type something and (usually) hit return.

Actually, read is a complete `Lisp parser`. It doesn't just read characters and return them as a string. It parses what it reads, and returns the Lisp object that results.

`ask` function's body contains more than one expression. The body of a function can have any number of expressions. When the function is called, they will be evaluated in order, and the function will return the value of the last one.

`Pure Lisp`: Lisp without `side-effects`. A side-effect is some change to the state of the world that happers as a consequence of evaluating an expression. When we evaluate a pure Lisp expression like (+ 1 2), there are no side-effects; it just returns a value. But when we call `format`, as well as returning a value, it prints something. That's one kind of `side-effect`.

When we are writing code without `side-effects`, there is no point in defining functions with bodies of more than one expression. The value of the last expression is returned as the value of the function, but the values of any preceding expressions are thrown away. If such expresssions didn't have side-effects, you would have no way of telling whether Lisp bothered to evaluate them at all.

### 2.10 Variables
`let` allows you to introduce new `local variables`:
```lisp
> (let ((x 1) (y 2))
    (+ x y)
3
```
a `let` version of ask:
```lisp
(defun ask-number ()
  (format t "Please enter a number: ")
  (let ((val (read)))
    (if (numberp val)
	val
	(ask-number))))
```
try a `cond` version? faied

`defparameter`allows you to introduce `global variable`:
```lisp
> (defparameter *glob* 99)
*GLOB*;`start-glob-star`
```
Such a variable will then be accessible everywhere, except in expressions that create a new local variable with the same name. To avoid the possibility of this happening by accident, it's conventional to giev global variables names surrounded by asterisks`*`. 

`defconstant` allows you to introduce `global constants`.
Thers is need to give constants distinctive names, because it will cause an error if anyone uses the same name for a variable.

function `boundp` can test whether some symbol is the name of a global variable or constant

### 2.11 Assignment
In CL, the most general assignment operator is `setf`.
```lisp
> (let ((x 10))
    (setf x 2)
    x)
```
When the first argument to `setf` is a symbol that is not the name of a local variable, it is taken to be a `global variable`.That is, you can create global variables implicitly, just by assigning them values. In source files, at least, it is better style to use explicit `defparameter`.

the first argument to `setf` can be almost any expression that refers to a particular place:
```lisp
> (setf x (list 'a 'b 'c))
(A B C)
> (setf (car x) 'n)
(N B C)
```
You can give any(even) number of arguments to `setf`:
```lisp
(setf a b
      c d 
      e f)
;this is equivalent to :
(setf a b)
(setf c d)
(setf e f)
```

### 2.12 Functional Programming
`Functional programming` means writing programs that work by returning value, **instead of by modifying things**.It is the dominant paradigm in Lisp.

Most built-in Lisp functions are meant to be called for the values they return, not for side-effects.The more side-effects you do without, the better off you'll be.

function `remove`

One of the most important advantage of functional programming is that it allows `interactive testing`.

### 2.13 Iteration
The `do` macro is the fundamental iteration operator in CL.
```lisp
;do
(do ((variable initial update))
    ((test expression) (failed expression))
  (body of the loop))


(defun show-squares (start end)
  (do ((i start (+ i 1)))
      ((> i end) 'done)
    (format t "~A ~A~%" i (* i i))))

;recursive show-squares
(defun show-squares (i end)
  (if (> i end)
      'done
      (progn 
        (format t "~A ~A~%" i (* i i))
	(show-squares (+ i 1) end))))

;cond version avoids the nested progn
(defun show-squares (i end)
  (cond ((> i end) 'done)
	(t (format t "~A ~A~%" i (* i i))
	   (show-squares (+ i 1) end))))

;dolist
(dolist (variable expression)
  (body of expressions))
  
(defun our-length (lst)
  (let ((len 0))
    (dolist (obj lst)
      (setf len (+ len 1)))
    len))

;recursive our-length
(defun out-length (lst)
  (if (null lst)
      0
      (+ (our-length (cdr lst)) 1)))
```

### 2.14 Function as Objects
If we give the name of a function to `function`, it will return the associated object. `function` is a `special operator`, so we don't have to quote the argument.
 
We can use `#'`(sharp-quote) as an abbreviation for `function`.
```lisp
> (function +))
#<Compiled-Function +>
> #'+
#<Compiled-Function +>
```
Internally, a built-in function like + is likely to be a segment of machine language code.

Like any other kind of object, we can pass functions as arguments.

`apply` function takes a function and a list of arguments for it, and return the result of applying the function to the arguments:
```lisp
> (apply #'+ 1 2 '(3 4 5));the last has to be a list
15
> (funcall #'+ 1 2 3 4 5); do the same, the last one doesn't need to be a list
15
```
`lambda expression`:functions don't have to have names, and we don't need defun to define them.
```lisp
> ((lambda (x) (+ x 100)) 1)
101
(funcall #'(lambda (x) (+ x 1)) 1)
101
```

### 2.15 Types
In Common Lisp, `values` have types, not `variables`
You could imagine that every object had a label attached to it, identifying its type.This approach is called `manifest typing`. You don't have to declare the types of variables, because any variable can hold objects of any type.

An object has more that one type.
The type `t` is the supertype of all types, so everything is of type `t`

function: `typep`

### 2.16 Looking Forward


## Chapter3 Lists





