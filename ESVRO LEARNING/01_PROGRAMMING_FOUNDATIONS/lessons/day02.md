# Day 2 — Variables, Data Types and Arithmetic in Dart

**Objective:** Understand variables, identify Dart data types, perform arithmetic operations, write a small invoice calculation program, and understand why financial applications require accurate money representation.

**Status:** COMPLETED

---

## 1. Today's Learning Topics

- Understanding variables.
- Understanding data types.
- `int`, `double`, `String`, and `bool`.
- Basic arithmetic operators.
- Remainder operator `%`.
- Creating an invoice calculation program.
- Understanding floating-point precision.
- Formatting decimal output using `toStringAsFixed(2)`.
- Why accurate money calculations matter in ESVRO.

---

## 2. What Is a Variable?

A variable is a named storage location that holds a value.

Think of variables as boxes. Each box has a name and stores information.

Example:

```dart
int price = 30;
int quantity = 5;
```

Explanation:

- `int` identifies the data type.
- `price` is the variable name.
- `=` assigns a value.
- `30` is the stored value.
- `;` ends the statement.

Variables help programs store and reuse information.

### ESVRO Example

An invoice contains:

- Product price.
- Product quantity.
- Product total.

The program stores these values in variables and uses them to calculate the invoice.

---

## 3. Dart Data Types

Dart provides different data types for different kinds of information.

| Data type | Purpose | Example |
|---|---|---|
| `int` | Whole numbers | `25` |
| `double` | Decimal numbers | `25.50` |
| `String` | Text | `"Notebook"` |
| `bool` | True or false | `true` |

### Example

```dart
String productName = "Notebook";
double price = 30.50;
int quantity = 4;
bool isPaid = true;
```

Explanation:

- `String productName` stores product text.
- `double price` stores a decimal price.
- `int quantity` stores a whole-number quantity.
- `bool isPaid` stores whether the purchase is paid.

---

## 4. Basic Arithmetic Operators

| Operator | Operation | Example | Result |
|---|---|---|---|
| `+` | Addition | `10 + 5` | 15 |
| `-` | Subtraction | `10 - 5` | 5 |
| `*` | Multiplication | `10 * 5` | 50 |
| `/` | Division | `10 / 5` | 2.0 |
| `%` | Remainder | `10 % 3` | 1 |

### Understanding the remainder operator

`10 % 3` gives `1`.

Why?

- Three groups of 3 use 9.
- One remains.

The `%` operator returns the remainder after division.

---

## 5. ESVRO Invoice Exercise

### Problem

A customer purchases three notebooks.

- Product name: Nyxara
- Price: ₹99.99
- Quantity: 3
- Payment status: Paid

### Calculation

Total = Price × Quantity

99.99 × 3 = 299.97

### User's Dart practice program

File:

`02_DART/practice/day02_variables.dart`

The learner successfully executed a program that stored:

- Product name: Nyxara
- Price: 99.99
- Quantity: 3
- Payment status: true

The calculation produced:

```text
299.96999999999997
```

The program executed successfully, but the displayed result revealed a floating-point precision issue.

---

## 6. Understanding Floating-Point Precision

Computers represent many decimal numbers using binary floating-point values.

Some decimal values cannot be represented exactly in this format.

For example:

```dart
double price = 99.99;
int quantity = 3;

double total = price * quantity;

print(total);
```

The output may contain a tiny precision difference:

```text
299.96999999999997
```

This is not a mistake in the multiplication logic. It is a floating-point representation issue.

### Formatting the output

Dart provides:

```dart
toStringAsFixed(2)
```

This converts a number into a string with exactly two digits after the decimal point.

Example:

```dart
print(total.toStringAsFixed(2));
```

Output:

```text
299.97
```

Another example:

```dart
double price = 49.50;
int quantity = 2;

double total = price * quantity;

print(total.toStringAsFixed(2));
```

Output:

```text
99.00
```

**Important:** Formatting the output does not fix the underlying floating-point precision problem.

For ESVRO's real accounting engine, we should use integer minor units (paise) or another exact decimal representation rather than relying entirely on `double`.

---

## 7. Quiz Results

### Quiz 1 — Basic understanding

Score: 5/5

Topics assessed:

1. Meaning of a variable.
2. Decimal data type.
3. String data type.
4. Multiplication.
5. Remainder operator.

All answers correct.

### Additional questions

- Price ₹99.99: `double` — Correct.
- 99.99 × 3: ₹299.97 — Correct.
- `toStringAsFixed(2)` output for 99: `99.00` — Correct.
- Why should ESVRO calculate money accurately? To prevent incorrect money calculations — Correct.

---

## 8. Skills Acquired

| Skill | Status |
|---|---|
| Understand variables | Completed |
| Identify `int` | Completed |
| Identify `double` | Completed |
| Identify `String` | Completed |
| Identify `bool` | Completed |
| Understand arithmetic operators | Completed |
| Understand `%` | Completed |
| Calculate invoice totals | Completed |
| Understand floating-point precision | Completed |
| Format two decimal places | Completed |
| Understand importance of accurate money calculations | Completed |

---

## 9. Day 2 Review

Important concepts to remember:

- Variables store information.
- Data types determine what kind of value is stored.
- `int` stores whole numbers.
- `double` stores decimal numbers.
- `String` stores text.
- `bool` stores true or false.
- Arithmetic operators perform calculations.
- `%` returns the remainder.
- `toStringAsFixed(2)` formats a number to two decimal places.
- Formatting does not guarantee exact financial calculations.

---

## 10. Next Lesson — Day 3

Planned topics:

1. Accepting user input in Dart.
2. Understanding `stdin.readLineSync()`.
3. Converting text input into numbers.
4. Understanding `int.parse()` and `double.parse()`.
5. Handling simple input errors.
6. Building an interactive billing calculator.

### Final Day 2 Status

COMPLETED

The learner passed the quizzes, understood Dart variables and data types, independently executed an invoice calculation program, and discovered the importance of numerical accuracy in accounting software.
