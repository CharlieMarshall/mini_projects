import random

def get_valid_integer_input(prompt):
    """Prompts user until a valid positive integer is entered."""
    while True:
        try:
            user_input = int(input(prompt))
            if user_input > 0:
                return user_input
            else:
                print("Please enter a positive number.")
        except ValueError:
            print("Invalid input. Please enter a whole number.")

print("Guess the number game\n\n")

upper_bound = get_valid_integer_input("Choose a maximum number: ")
answer = random.randint(1,upper_bound)

print(f"\nOk, i've thought of a number between 1 and {upper_bound}")
print("Can you guess what it is")

#print(f"Answer: {answer}")

attempts = 0
while True:
    attempts += 1
    guess = get_valid_integer_input(f"Attempt {attempts}. Enter your guess: ")
    if guess > answer:
        print(f"Your guess {guess} was too high, try a lower number")
        continue
    elif guess < answer:
        print(f"Your guess {guess} was too low, try a higher number")
        continue
    else:
        print(f"\nCongragulations You guessed correctly!\n\nIt took you {attempts} attempts")
        break


