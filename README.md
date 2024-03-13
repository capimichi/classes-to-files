# Classes to files

Move classes, from the same file, to another one.

## The problem

When a file has too many classes, it becomes hard to maintain. It's better to have a file for each class.

## Usage

```bash
$ classes_to_files <file>
```

## Installation

```bash
$ curl -s https://raw.githubusercontent.com/capimichi/classes-to-files/main/classes_to_files.sh > /usr/local/bin/classes_to_files
$ chmod +x /usr/local/bin/classes_to_files
```

## Example

```bash
$ classes_to_files input.php
```

```php
<?php

class A {
    // ...
}

class B {
    // ...
}

class C {
    // ...
}

```

Output:

```bash
$ ls
A.php B.php C.php input.php
```

```php
// A.php
<?php

class A {
// ...
}
```

```php
// B.php
<?php

class B {
// ...
}
```

```php
// C.php
<?php

class C {
// ...
}
```
