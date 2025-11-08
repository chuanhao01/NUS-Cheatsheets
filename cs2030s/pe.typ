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
  font-size: 7pt,
  line-skip: 1.5pt,
  margin: (x: 0.4in, y: 0.4in),
  num-columns: 3,
  column-gutter: 4pt,
)
// If from GH, you need to find and add the picture yourself
#figure(caption: [#hands.folded])[#image(
  "copyright/adi-yoga.jpg",
  width: 80%,
  alt: "Copyrighted, please find it on canvas youself if you want the picture here. :p",
)]

= Java Code
```Java
A[] a = new A[int size];
A[] a = new A[]{new A(), ...}
a.length // gets the size of the array

// Object overrides
@Override
public String toString() {}
@Override
public boolean equals(Object o) {}

// Comparable<T>
@Override
public int compareTo(T o) {}
// this: -1 less than, 0 equal, 1 more than

// String format
String.format("%s %d", s, d);
String.format("%b %c %f %.2f %t", boolean, char, float, float, Date)

// Multiple implements
interface A {}; interface B {}
class C {}
class D extends C implements A, B {}
// First extends for type has to be class (if any)
class E<T extends C & A & B, U> {}

// Use
a instanceof A<?>
// instead of raw types
a instanceof A
// Use
new Comparable<?>[10];
// instead of raw types
new Comparable[10]

// Use
@SuppressWarnings("unchecked")
T[] = (T[]) new Object[]
@SuppressWarnings("unchecked")
Pair<T>[] students = (Pair<T>[]) new Pair<?>[size];
```


= Immutability

A class is considered an immutable class if the instance of the class cannot have any visible changes outside of its abstraction barrier.

Rules:
#list[
  Add the modifier final to all fields as well as the class (if possible).
][
  Remove any assignments to the fields (compilation error due to final).
][
  Change setter from void to return a new instance.
]

\ \

= Cursed Generics
```Java
public abstract class Program<T> {
  public abstract T get();
  public abstract boolean isResult();
  public abstract <R> Program<R> flatMap(
      Transformer<? super T, ? extends Program<? extends R>> transformer);

  public static <T> Program<T> result(T value) {
    return new Result<T>(value);
  }
  public static <T, U> Program<U> chain(Program<? extends T> program,
      Transformer<? super T, ? extends Program<? extends U>> transformer) {
    return new Chain<T, U>(transformer, program);
  }

  private static class Result<T> extends Program<T> {
    private T value;
    private Result(T value) {
      this.value = value;
    }
    public T get() {
      return this.value;
    }
    public boolean isResult() {
      return true;
    }
    public <R> Program<R> flatMap(
        Transformer<? super T,
        ? extends Program<? extends R>> transformer) {
      return Program.chain(this, transformer);
    }
  }

  private static class Chain<T, U> extends Program<U> {
    private Transformer<? super T, ? extends Program<? extends U>>
      transformer;
    private Program<? extends T>
      program;
    private Chain(Transformer<? super T, ? extends Program<? extends U>> transformer,
        Program<? extends T> program) {
      this.transformer = transformer;
      this.program = program;
    }
    public U get() {
      return this.transformer.transform(this.program.get()).get();
    }
    public boolean isResult() {
      return false;
    }
    public <R> Program<R> flatMap(
        Transformer<? super U,
        ? extends Program<? extends R>> transformer) {
      return Program.chain(this, transformer);
    }
  }
}
```

= FP

```Java
public interface BooleanCondition<T> {
  boolean test(T t);
}
public interface Combiner<S, T, R> {
  R combine(S s, T t);
}
public interface Consumer<T> {
  void consume(T t);
}
public interface Producer<T> {
  T produce();
}
public interface Transformer<U, T> {
  T transform(U u);
}
```

== Maybe

```Java
public abstract class Maybe<T> {
  // Will always be of Maybe<T>
  public static <T> Maybe<T> some(T t);
  // null input will create None
  public static <T> Maybe<T> of(T t);

  public abstract Maybe<T> filter(BooleanCondition<? super T> bc);
  public abstract <U> Maybe<U> map(Transformer<? super T, ? extends U> transformer);
  public abstract <U> Maybe<U> flatMap(
      Transformer<? super T, ? extends Maybe<? extends U>> transformer);
  public abstract T orElse(T t);
  public abstract T orElseGet(Producer<? extends T> producer);
  public abstract void ifPresent(Consumer<? super T> consumer);
}
```

== Lazy
```Java
public class Lazy<T> {
  //private Producer<? extends T> producer;
  //private Maybe<T> value;
  //private Lazy(Maybe<T> v, Producer<? extends T> producer);

  public static <T> Lazy<T> of(T v);
  public static <T> Lazy<T> of(Producer<? extends T> producer);
  public <U> Lazy<U> map(Transformer<? super T, ? extends U> transformer);
  public <U> Lazy<U> flatMap(
    Transformer<? super T, ? extends Lazy<? extends U>> transformer);
  public Lazy<Boolean> filter(BooleanCondition<? super T> bc);
  public <U, R> Lazy<R> combine(Lazy<? extends U> other,
  Combiner<? super T, ? super U, ? extends R> combiner);
}

```

== InfiniteList
```Java
public class InfiniteList<T> {
  private static final Sentinel SENTINEL = new Sentinel();
  private InfiniteList(Lazy<Maybe<T>> head, Lazy<InfiniteList<T>> tail);
  public static <T> InfiniteList<T> generate(Producer<T> prod);
  public static <T> InfiniteList<T> iterate(T seed,
    Transformer<? super T, ? extends T> next);
  public T head();
  public InfiniteList<T> tail();
  public <R> InfiniteList<R> map(Transformer<? super T, ? extends R> func);
  public InfiniteList<T> filter(BooleanCondition<? super T> pred);
  public InfiniteList<T> append(InfiniteList<T> list);
  public boolean isSentinel();
  public static <T> InfiniteList<T> sentinel();
  public InfiniteList<T> limit(long n);
  public InfiniteList<T> takeWhile(BooleanCondition<T> bc);
  public <U> U reduce(U init, Combiner<U, T, U> comb);
  public InfiniteList<T> toHead();
  public long count();
  public List<T> toList();
  public <R> InfiniteList<R> flatMap(
    Transformer<? super T, ? extends InfiniteList<? extends R>> func);

```

== Stream
```Java
long count()
Stream<T> distinct()
Optional<T> findAny()
Optional<T> findFirst()
<R> Stream<R> flatMap(Function<? super T,? extends Stream<? extends R>> mapper)
static <T> Stream<T> generate(Supplier<? extends T> s)
static <T> Stream<T> iterate(T seed, UnaryOperator<T> f)
Stream<T> limit(long maxSize)
<R> Stream<R> map(Function<? super T,? extends R> mapper)
T reduce(T identity, BinaryOperator<T> accumulator)
<U> U reduce(U identity, BiFunction<U,? super T,U> accumulator, BinaryOperator<U> combiner)
Stream<T> sorted()
Stream<T> sorted(Comparator<? super T> comparator)
default Stream<T> takeWhile(Predicate<? super T> predicate)
default List<T> toList()

// Parallel Stream, use combiner reduce
stream.parallel()
// Potentially
stream.parallel().unordered()
```

== List
```Java
void add(int index, E element)
boolean add(E e)
boolean addAll(int index, Collection<? extends E> c)
boolean addAll(Collection<? extends E> c)
default void addFirst(E e)
default void addLast(E e)
void clear()
boolean contains(Object o)
boolean containsAll(Collection<?> c)
static <E> List<E> copyOf(Collection<? extends E> coll)
boolean equals(Object o)
E get(int index)
default E getFirst()
default E getLast()
int hashCode()
int indexOf(Object o)
boolean isEmpty()
int lastIndexOf(Object o)
ListIterator<E> listIterator()
ListIterator<E> listIterator(int index)
static <E> List<E> of()
static <E> List<E> of(E e1)
static <E> List<E> of(E... elements)
static <E> List<E> of(E e1, E e2)
E remove(int index)
boolean remove(Object o)
boolean removeAll(Collection<?> c)
default E removeFirst()
default E removeLast()
default void replaceAll(UnaryOperator<E> operator)
boolean retainAll(Collection<?> c)
default List<E> reversed()
E set(int index, E element)
int size()
default void sort(Comparator<? super E> c)
List<E> subList(int fromIndex, int toIndex)
Object[] toArray()
<T> T[] toArray(T[] a)
```

= Monad

Left Identity Law \
#jstr(body: "Monad.of(x).flatMap(x -> f(x))") must be the same as #jstr(body: "f(x)") \
Right Identity Law \
#jstr(body: "monad.flatMap(x -> Monad.of(x))") must be the same as #jstr(body: "monad") \
Associative Law \
#jstr(body: "monad.flatMap(x -> f(x)).flatMap(x -> g(x))") must be the same as #jstr(body: "monad.flatMap(x -> f(x).flatMap(y -> g(y)))") \

= Functors

Identity Law \
#jstr(body: "functor.map(x -> x)") is the same as #jstr(body: "functor") \
Composition Law \
#jstr(body: "functor.flatMap(x -> f(x)).flatMap(y -> g(y))") is the same as #jstr(body: "functor.flatMap(x -> f(x).flatMap(y -> g(y)))") \
