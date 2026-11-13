# ESVRO LEARNING — DAY 1

## Programming Foundations and Introduction to Dart

**Level:** Absolute Beginner  
**Teaching method:** ELI5 (Explain Like I'm Five)  
**Learning mode:** Teacher Mode  
**Status:** In Progress

---

# 1. Today's Learning Goals

By the end of this learning day, I should understand:

1. What programming means.
2. What an algorithm is.
3. What input, processing and output mean.
4. How to solve simple problems using logical steps.
5. What a variable is.
6. What Dart and Flutter are.
7. What main(), int and print() mean.
8. How a simple Dart program works.

---

# 2. Lesson 1 — What Is Programming?

Programming means giving instructions to a computer so that
it can perform tasks.

Example:

Imagine a robot that needs to clean a room.

We must give it clear instructions:

1. Pick up the book.
2. Put the book on the table.
3. Pick up the pencil.
4. Put the pencil in the box.

A computer also needs instructions.

Examples of tasks ESVRO must perform:

- Save receipts.
- Calculate bill totals.
- Store customer information.
- Calculate debit and credit totals.
- Display financial reports.

Programming is how we give computers these instructions.

## Important idea

A computer follows instructions. We must explain the
instructions clearly and in the correct order.

---

# 3. Lesson 2 — What Is an Algorithm?

An algorithm is a sequence of steps used to solve a problem.

Example:

A shopkeeper wants to calculate the price of a customer's
purchase.

The algorithm:

1. Get the item quantity.
2. Get the item price.
3. Multiply quantity by price.
4. Repeat for other items.
5. Add all item totals.
6. Display the final bill.

## Important idea

First understand the steps needed to solve a problem.
Then convert those steps into programming code.

---

# 4. Lesson 3 — Input, Processing and Output

Almost every basic program follows this pattern.

## Input

Information given to a program.

Example:
- Price = 100
- Quantity = 2

## Processing

The computer performs an operation.

Example:

100 * 2 = 200

## Output

The computer displays the result.

Example:

Total = 200

## Simple diagram

INPUT
  |
  v
PROCESSING
  |
  v
OUTPUT

---

# 5. Lesson 4 — First Algorithm Exercise

## Exercise 1: Shop Bill

Items:

| Item | Quantity | Price |
|---|---:|---:|
| Pen | 3 | Rs. 10 |
| Book | 2 | Rs. 25 |
| Pencil | 4 | Rs. 5 |

### User's algorithm

1. Input pen quantity and price.
2. Multiply pen quantity by pen price.
3. Input book quantity and price.
4. Multiply book quantity by book price.
5. Input pencil quantity and price.
6. Multiply pencil quantity by pencil price.
7. Add all three item totals.
8. Display the final bill.

### Calculations

Pen:

3 * 10 = Rs. 30

Book:

2 * 25 = Rs. 50

Pencil:

4 * 5 = Rs. 20

Final bill:

30 + 50 + 20 = Rs. 100

### Result

The user's algorithm was correct.

---

# 6. Lesson 5 — Practising Algorithms and Calculations

## Exercise 2: Apples and Oranges

Question:

- 5 apples at Rs. 8 each.
- 3 oranges at Rs. 10 each.

### User's answers

Apples:

5 * 8 = Rs. 40

Oranges:

3 * 10 = Rs. 30

Final bill:

40 + 30 = Rs. 70

### Result

All three answers were correct.

Score: 3/3.

## Exercise 3: Bags, Bottles and Boxes

Question:

- 2 bags at Rs. 150 each.
- 3 bottles at Rs. 20 each.
- 1 box at Rs. 80.

### User's algorithm

Start

Input bq, bp, oq, op, xq, xp

bt = bq * bp

ot = oq * op

xt = xq * xp

total = bt + ot + xt

Display total

Stop

### Variable meanings

- bq = Bag quantity
- bp = Bag price
- oq = Bottle quantity
- op = Bottle price
- xq = Box quantity
- xp = Box price
- bt = Bag total
- ot = Bottle total
- xt = Box total
- total = Final bill

### Calculations

Bags:

2 * 150 = Rs. 300

Bottles:

3 * 20 = Rs. 60

Box:

1 * 80 = Rs. 80

Final bill:

300 + 60 + 80 = Rs. 440

### Result

The user's algorithm was correct.

---

# 7. Lesson 6 — First Programming Concepts

## 7.1 What Is Dart?

Dart is a programming language.

We will use Dart to write the instructions for ESVRO.

We will use Dart for:

- Calculations.
- Accounting logic.
- Application logic.
- Data processing.
- Database operations.

## 7.2 What Is Flutter?

Flutter is a framework used to build application interfaces.

Flutter helps us create:

- Buttons.
- Text fields.
- Menus.
- Tables.
- Dashboards.
- Application screens.

### Difference

Dart = Programming language.

Flutter = Application development framework.

We will use both to build ESVRO.

## 7.3 What Is main()?

main() is the starting point of a normal Dart program.

Think of it as the entrance door of the program.

When we run a normal Dart program, execution starts
from main().

## 7.4 What Is int?

int means integer.

It is used to store whole numbers.

Examples:

10

50

200

-5

Numbers such as 10.5 are not integers.

## 7.5 What Is print()?

print() displays information on the screen.

Example:

print(200);

Expected output:

200

---

# 8. First Dart Program — Understanding the Code

```dart
void main() {
  int price = 50;
  int quantity = 4;

  int total = price * quantity;

  print(total);
}
```

Expected output:

200

## Line-by-line explanation

### Line 1

void main() {

- void means this function does not return a value.
- main() is the starting function.
- Opening curly bracket begins the function body.

### Line 2

int price = 50;

- int defines a whole-number variable.
- price is the variable name.
- = assigns a value.
- 50 is the stored value.
- ; ends the statement.

### Line 3

int quantity = 4;

Creates a variable named quantity and stores 4.

### Line 4

int total = price * quantity;

- Reads the value stored in price.
- Reads the value stored in quantity.
- Multiplies both values.
- Stores the answer in total.

Calculation:

50 * 4 = 200

### Line 5

print(total);

Displays the value stored in total.

Output:

200

### Line 6

}

Closes the main() function.

---

# 9. Important Programming Symbols

| Symbol | Meaning |
|---|---|
| { } | Groups instructions |
| ; | Ends a statement |
| = | Assigns a value |
| * | Multiplication |
| + | Addition |
| ( ) | Used with functions and expressions |

---

# 10. Variable Exercise

Question:

price = 50

quantity = 4

total = price * quantity

User's answer:

200

### Result

Correct.

Explanation:

50 * 4 = 200

The value 200 is stored in total.

---

# 11. Day 1 Knowledge Assessment

Topics introduced:

- Programming
- Algorithms
- Input
- Processing
- Output
- Variables
- Dart
- Flutter
- main()
- int
- print()

## Current understanding

| Skill | Progress |
|---|---|
| Understanding programming | Introduced |
| Writing algorithms | Good |
| Input and output | Good |
| Basic calculations | Good |
| Variable concept | Introduced |
| Dart fundamentals | Introduced |
| Writing Dart code independently | Not yet tested |

---

# 12. Mistakes and Corrections

No major logical mistakes in the completed algorithm exercises.

The user successfully:

- Wrote a shop billing algorithm.
- Calculated the apples and oranges bill.
- Independently wrote a three-item billing algorithm.
- Calculated a variable multiplication exercise.

Further practice is required for Dart syntax and independent coding.

---

# 13. Next Learning Tasks

1. Complete the first Dart concepts quiz.
2. Practise declaring variables.
3. Learn integer and decimal data types.
4. Learn arithmetic operators.
5. Write the first Dart program independently.
6. Run the program and understand its output.
7. Learn to identify and fix basic syntax errors.

---

# 14. Daily Learning Record

Date: 13 November 2026

Learning level: Beginner

Teaching style: ELI5

Learning mode: Teacher Mode

Duration: To be recorded at lesson completion.

Day status: IN PROGRESS

Next lesson: Complete Day 1 Dart quiz and first Dart coding exercise.

---

# 15. Important Learning Rules

1. Understand logic before syntax.
2. Explain every new code line.
3. Attempt exercises before seeing complete solutions.
4. Ask questions whenever something is unclear.
5. Practise writing code independently.
6. Learn from mistakes.
7. Use AI as a teacher and assistant, not as a replacement for learning.

The goal is to become capable of independently designing,
writing, testing and debugging ESVRO.
