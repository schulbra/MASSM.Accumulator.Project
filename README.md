# MASSM.Accumulator.Project
Objectives:
Additional practice with the following:
    Implementing data validation
    Implementation of an accumulator
    Integer arithmetic
    Defining and using variables (integer and string)
    Using library procedures for I/O
    Implementing control structures (decision-making, loops, etc)

Problem Definition:
Write and test a MASM program to perform the following tasks:
    Display the program title and programmer’s name.
    Get the user’s name, and greet the user.
    Display instructions for the user.
    Repeatedly prompt the user to enter a number. Validate the user input to be in the range [-150, -1] (inclusive).
    Count and accumulate the valid user numbers until a non-negative number is entered.  (The non-negative number will be               discarded.)
    Calculate the (rounded integer) average of the negative numbers. The value should be rounded towards 0 (e.g. -34.8 rounds to -34).
    
Displays:
        The number of negative numbers entered (Note: if no negative numbers were entered, display a special message and skip to iv.)
        The sum of negative numbers entered.
        The average (rounded towards 0, as noted in step 5).
        A farewell message (which includes the user’s name).

Requirements:
    The main procedure must be modularized into commented logical sections (additional procedures are not allowed at this time)
    The program must be fully documented. This includes a complete header block for identification, description, etc., and a comment outline to explain each section of code.
    The lower limit must be defined as a constant. You are expected to use the = directive or the EQU directive.
    The usual requirements regarding documentation, readability, user-friendliness, etc., apply.
    Submit your text code file (.asm) to Canvas by the due date.
