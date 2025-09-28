#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "lib.typ": *
#import emoji: hands

#set page(paper: "a4", flipped: true, margin: 1cm)
#set text(font: "New Computer Modern", size: 11pt)
// #set text(font: "New Computer Modern Math", size: 11pt)

#let jstr(body: str) = { raw(body, lang: "Java") }

#show: cheatsheet.with(
  title: "CS2030S",
  authors: "chuanhao01",
  write-title: true,
  font-size: 5pt,
  line-skip: 1.5pt,
  x-margin: 0.1in,
  y-margin: 0.1in,
  num-columns: 6,
  column-gutter: 4pt,
)
#figure(caption: [#hands.folded])[#image("copyright/adi-yoga.jpg", width: 80%, alt: "Copyright sorry")]


= Week 1

Java is a #strong[statically] and #strong[strongly] typed language

== Subtypes

Given types $S$ and $T$ s.t. $S <: T$\
$S$ is a #emph[subtype] of $T$, $T$ is a #emph[supertype] of $S$\
#strong[Reflexive:] $S<:S$\
#strong[Transitive:] $S<:T and T<:U -> S<:U$\
#strong[Anti-Symmetry:] $S<:T and T<:S -> S=T$ i.e. $S$ and $T$ has to be the same type\
Any #emph[supertype] can hold a #emph[subtype], ```Java S s; T t = s```\
Any function expecting a #emph[supertype] can take in a #emph[subtype], ```Java void foo(T t); foo(s)```


== Primitive Types
byte <: short <: int <: long <: float <: double \
char <: int

== Class Intialization
```Java
class Circle {
  private int x;
  private int y;
}
...
Circle c1; // This is ok
Circle c2 = c1; // Compiler Error
Circle c1 = new Circle(); // x and y default to 0
```

= Week 2
#strong[Composition] is a #emph[has a] relationship, i.e. #jstr(body: "class A { private B b; }")\
#strong[Inheritance] is a #emph[is a] relationship, i.e. #jstr(body: "class A {} ... class B extends A {}"). It is also a #emph[subtype], $B<:A$\
#strong[Tell Don't Ask:] Do not request/get from an #emph[object], call an #emph[object] to do something\
#list[
  Fields are private
][
  No accessors/No asking for fields
][
  Tells to do X by #jstr(body: "super.equals(b)") etc.\
]
#strong[Information Hiding:] Keep fields hidden with #jstr(body: "private") if other #emph[objects] don't need access to them (by default)

== private
#jstr(body: "private") fields can only be accessed within the same #jstr(body: "class")
```Java
class A {
  private int x;
  ...
  void foo(A a) {
    A.x = 10; // this is ok
    a.x = 10; // this is ok
  }
}
```

== static
#jstr(body: "static") fields are tied to the #jstr(body: "class") and not the #emph[object]\
#jstr(body: "static") #emph[method] cannot access #jstr(body: "this")
```Java
class A {
  private static int x;
  public static int y;
  public A() {
    A.x += 1; // This is ok
  }
  public static foo(){
    x += 1; // Referring to static x
  }
}
...
A.y += 1; // This is ok
A a = new A(); a.foo(); // This is ok
```

== Constructor
#emph[constructor] functions has the same #strong[name] as the #jstr(body: "class") and #strong[no return type]
```Java
class A {
  public A() {} // valid
  private A(int x) {} // private is still valid
}
```

== Method Overriding
#strong[Method Signature:] #emph[method name], #emph[number of parameters], #emph[type of each parameter], #emph[order of parameters]\
#strong[Method Descriptor:] #emph[method signature] and #emph[return type]
```Java
// int -> descriptor,
// foo(int, double) -> signature
int foo(int a, double b){}
```
#jstr(body: "@Override") is an annotation that tells the compiler a #emph[method] is intended to override another #emph[method].
It is not required for a #emph[method] to be #emph[overriden]\

```Java
class A {
  public void foo(int x){}
}
class B {
  public void foo(int y){} // Overrides by Overloading
  @Override
  public void foo(int y){} // Overrides
  public void foo() {} // Overload
  public void foo(int y) // Fails without @Override
  @Override
  public void foo(){ // Fails with @Override
}
```

=== Override shenanigans
If #jstr(body: "@Override") is applied to a method it has to #emph[override] properly.
This means the #emph[method descriptor] has to be the same, if not it is #emph[overloading].

Without #jstr(body: "@Override"), for the method to override, by #strong[LSP] (or smth), there is this case.
```Java
// B <: A
class X {public A foo()}
class Y extends X {public B foo()}
// Y: B foo() overrides X: A foo()
```
This only applies for created types(#jstr(body: "class"), #jstr(body: "interface")) and not primitive types(#jstr(body: "int") etc.).


== Compile-Time and Runtime Types
#strong[CTT:] #emph[compile-time type], Type in code\
#strong[RTT:] #emph[runtime type], Type when running
```Java
// C <: A, CTT: a -> A, RTT: a -> C
A a = C c;
```

= Week 3
#strong[Method Overloading:] #emph[methods] with the same #emph[name] but different #emph[method signatures] i.e. #emph[return type] does not changes but the number of #emph[parameters] changes\
#strong[Polymorphism:] It allows us to write generic, succinct, code that is based only on the compile-time type of the target. The actual behavior of the code will be based on the run-time type of the target.\
It allows us to write future-proof code, since new classes can be added as subtypes without changing or breaking existing code written for the super types, as long as the new classes follows the Liskov Substitution Principle.\
#strong[Dynamic binding]: Applies to instance method invocation.


== instanceof
#jstr(body: "instanceof") checks at runtime for #emph[supertypes]
```Java
// C <: B <: A
B b = new B();
A a = b;
a instanceof A // true
a instanceof B // true
a instanceof C // false
```

== Type Casting
At #emph[compile] time it checks if it is possible. At #emph[runtime] it will fail if it is actually not possible.\
Possibility being that a #emph[compile-time supertype] can be narrowed/cast to a #emph[compile-time subtype].
Because the #emph[compile-time supertype] can possibly hold a valid #emph[runtime subtype]

```Java
// B <: A, C
A a = new A(); B b = new B(); C c = new C();
// CTT(A) of a could possibly hold a RTT(B)
// So this compiles and fails at runtime
b = (B) a;
b = (B) c; // Fails since at CTT is not possible
a = (A) b; // Ok, type-cast not needed
```

To check compilation, remember type widening and narrowing.

=== Type Casting shenanigans
Also for #jstr(body: "interface"), it can always be cast into any other #jstr(body: "interface"), since a potential #emph[subtype] could implement both the #jstr(body: "interface").

== Method Overloading

The name of the #emph[method] has to be the same.\
#strong[During CT:]
#list[
  Based on #strong[CTT] of the parameters and object, store the #emph[method descriptor] (based on specificity)
]
#strong[During RT:]
#list[
  Get the #emph[method descriptor], match and run based on the #strong[RTT]
]

```Java
class Circle {
  @Override
  public boolean equals(Object o) {...}
  public boolean equals(Circle c) {...}
}
...
Object o1, o2 = new Circle();
Circle c1, c2 = new Circle();
// Stores md: equals(Object) since Object only has equals(Object)
// Even though RTT o1(Circle).equals(Circle) exists
// Will only ever call Circle.equals(Object)
o1.equals((Circle) o2) || o1.equals(c2);
// Stores equals(Object) so calls Circle.equals(Object)
c1.equals(o1);
// Calls Circle.equals(Circle)
c1.equals(c2);
```

=== Same specificity

```Java
// B <: A
void foo(B b, A a)
void foo(A a, B b)
// Will not compile, reference to foo is ambiguous
foo(B, B)
```

Shorter interface example
```Java
interface I1
interface I2
class A implements T1, T2
void f(T1 x){}
void f(T2 x){}
f(new A());
```

== LSP
#strong[Liskov Substitution Principle(LSP):]\
Given types $S<:T$.
Objects of type $T$ can be replaced by objects of type $S$
without breaking any desirable property of the program.
Any logic/rules you expect $T$ to follow, $S$ should follow to.

E.x. Program depends on #jstr(body: "String") grades by a #jstr(body: "Grader") to be A-D.
Any #emph[subtypes] should not return other #jstr(body: "String") grades like "S" or "U" (S/U)

== final
```Java
final class A { // Cannot be extended
  final private int x = 100; // Cannot be change
  final void foo() {...} // Cannot be Override
}
```

== Abstract Classes
#list[
  Cannot be instantiated
][
  Can have abstract and concrete methods
][
  Like classes, can only inherit from 1 class
][
  Can have fields
][
  Can be used as a type
]
```Java
abstract class A extends C { // Only 1 class extends
  private int x;
  abstract void foo(); // Abstract method
  void bar(){...} // Concrete Method
}
class B extends A {}
```

== Interface
#list[
  Cannot be instantiated
][
  Can only have abstract methods
][
  Can extend multiple interfaces
][
  Cannot have fields
][
  Can be used as a type
]
```Java
interface A extends B, C{
  abstract void foo(); // Only abstract methods
}
class D implements A {}
```

#{
  show heading: none
  heading(level: 1)[Skip Week 4]
}

== Wrapper Class
#emph[Primitive Types] in Java have corresponding wrapper classes.
They have auto-boxing and unboxing.
The boxing and unboxing operation is performance intensive.
```Java
Integer a = 4; // Auto-boxing
int b = a; // Auto unboxing
```

== Variance
#strong[covariant: ] $S<:T -> C(S)<:C(T)$\
#strong[contravariant: ] $S<:T -> C(T)<:C(S)$\
#strong[invariant: ] Neither #strong[covariant] or #strong[contravariant]
Java arrays are covariant

== Java Array
Java #emph[arrays] are covariant and there could be runtime issues.
```Java
Integer[] ia = new Integer[2]{...};
Object[] oa = ia; // Type widening
oa[0] = "String" // Runtime error
```


== Exceptions
#strong[Never return in a finally block]

#strong[Unchecked Exception: ]
#emph[subtype] of #jstr(body: "RuntimeException") and not required to be checked in a program.
They are usually not explicitly caught or thrown.
(Notes: Exception caused by a programmer's errors)

#strong[Checked Exception: ]
#emph[subtype] of #jstr(body: "Exception") and has to be explicitly caught or thrown.
(Notes: Exception that a programmer has no control over)

#strong[catch blocks: ]
Will catch any #emph[subtypes] in the block.
They are checked top to bottom.

#strong[finally blocks: ]
Always ran last, regardless of it an exception is caught.

```Java
// E <: Exception, RE <: RuntimeException
void foo() throws E { // Needs to have the throws
  throws new E();
}
...
try {
  // Will run
  ...
  foo();
  //Will not run below
  ...
  // Catches E and Exception
  // Any T <: Exception
} catch (Exception e) {
  // Jumps here from foo
  ...
  // Will not be caught because catches
  // are checked top to bottom
} catch (E e) {
  ...
} finally {
  // Runs at the end
  // Will always runs regardless of exception caught
}
```
Also,
```Java
void foo(){
  try {
    // runs
    throws new Exception();
    // will not run
  } finally {
    // runs then throws the exception back to caller
  }
}
```

=== Exception shenanigans
Catching a supertype will not allow you to catch a #emph[subtype] after.
```Java
// EB <: EA
catch (EA e) {
} catch(EB e) { // Compilation error here
}
// If below compiles, we know EB <: EA
catch (EB e) {
} catch(EA e) {
}
```
Overriding a method does not allow you to throw a #emph[supertype] exception.
```Java
// EA <: Exception
class A {
  public void food() throws EA {}
}
class B extends A {
  // Compile error
  public void foo() throws Exception {}
}
```


= Week 5, Generics
Generics are #strong[invariant]
```Java
class Shape<S, T> {
  private S s;
  private T t;
  public <S extends T> void foo(S s){ // S here is different
    ...
  }
  public <U extends S> void foo(U s){ // Same as above
    ...
  }
}
Shape<int, double> shape = new Shape<int, double>();
shape.<int>foo(4);
```

#strong[Raw Types: ] Generics without type arguments (Should not be used)

== Generics shenanigans
```Java
// A <: Comparable<int> only, no other Comparable<string> etc
// Look at wildcards for Comparable<? extends int>
class A extends Comparable<int> {}
```

== Type Erasure
```Java
class A<T, S extends IA & IB> {
  private T t;
  private S s;
  public void foo() {
    this.s.ib();
  }
}
// After type erasure
class A {
  private Object t;
  // Takes the type of the first
  private IA s;
  public void foo() {
    // Type casting is done for type IB
    ((IB) this.s).ib();
  }
}
```

= Week 6 wildcards
#strong[Upper Bounded Wildcards/Extends]
#list[
  $S<:T$ then A<? extends S> <: A<? extends T> (covariance)
][
  Any S, A< S > <: A<? extends S> <: A<? extends T>
]
#strong[Lower Bounded Wildcards/super]
#list[
  $S<:T$ then A<? super T> <: A<? super S> (contravariant)
][
  Any T, A< T > <: A<? super T> <: A<? super S>
]
#strong[Unbounded Wildcards]
#list[
  A< ? > is the supertype of every parameterized type of A< T >\
  A< T > <: A< ? >
][
  Used by a method to allow any type
]
```Java
class A<T> { T get(); void set(T t);}
void foo(A<?> a){
  Object o = a.get(); // For any T, object can take T
  a.set(null); // T could be anything, so null is safe
}
```

== PECS
Producer Extends, Consumer Super\
#strong[Producer: ] You need them to give you a T\
#strong[Consumer: ] You need to pass a T in

== Type Inference
#strong[Target Typing: ] Return of the function\
#strong[Type Parameter: ] Any generic type declared\
#strong[Argument Typing: ] Argument passed and Argument generics\
```Java
public <T extends H> T foo(Seq<? extends T> a)
I i = foo(new Seq<G>(100));
// I i is Target Typing
// <T extends H> is Type Parameter
// Seq<G> with Seq<? extends T> is Argument Typing
```

=== Picking T
#list[
  Pick the most specific
][
  Ignore any other types not directly used (For the method call etc.)
]
Scenarios
#list[
  Given $A<:T<:B$\
  $T$ is A
][
  Given $A<:T$\
  $T$ is A
][
  Given $T<:B$\
  $T$ is B
]

= Immutability
From Jess
#list[
  Cannot have any visible changes outside of abstraction barrier
][
  If class contains generics the class will be immutable up till $T$ for #jstr(body: "C<T>")
]
Guidelines:
#list[
  Add final keyword to all fields(necessary condition)
][
  Remove any assignments to fields
][
  Change setter from void to return new instance
][
  Copy array initialization unless it is safe to share
]
Advantages:
#list[
  Ease of understanding
][
  Enable safe sharing of objects
][
  Enable safe concurrent execution
][
  Enable safe sharing of internals
]

= Stack and Heap diagram

#image("stack_and_heap.png"),

= Java Code
```Java
A[] a = new A[int size];
A[] a = new A[]{new A(), ...}

// Object overides
@Override
public String toString() {}
@Override
public boolean equals(Object o) {}

// Comparable<T>
@Override
public int compareTo(T o) {}

// String format
String.format("%s %d", s, d);
```
