import random
import os

CHOICES = ( "Rock", "Paper", "Scissors")
CHOICES_MAP = { 1: "Rock", 2: "Paper", 3: "Scissors" }
BEATS_MAP = { "Rock": "Paper", "Paper": "Scissors", "Scissors": "Rock" }

# Global Scores
user_score = 0
computer_score = 0

def play_round(user_move, computer_move):
    """
    Determines the winner of the round, updates the score, and prints the result.
    """
    global user_score, computer_score

    print(f"\n--- Round Result ---\nUser: {user_move} vs. Computer: {computer_move}")

    if user_move == computer_move:
        print("It's a draw!")
    elif BEATS_MAP[user_move] == computer_move:
        print("You Lose!")
        computer_score += 1
    else:
        print("You Win!")
        user_score += 1

    print(f"Score: User {user_score} : {computer_score} Computer")


def get_user_move():
    """Prompts the user for a move and handles validation."""
    while True:
        try:
            # Display options
            selection = int(input("\nSelect one of the following:\n1. Rock\n2. Paper\n3. Scissors\nYour choice (1-3): "))
        except ValueError:
            print("Invalid input. Please enter a valid number (1, 2, or 3).")
            continue

        if selection in CHOICES_MAP:
            return CHOICES_MAP[selection] # Return the move string
        else:
            print("Not a valid entry. Please choose 1, 2, or 3.")


def start_game():
    """Main function to control the game loop."""
    while True:
        os.system('clear')

        # Get moves
        user_move = get_user_move()
        computer_move = random.choice(CHOICES)

        # Play the round
        play_round(user_move, computer_move)

        # Prompt for rematch
        rematch = input("\nType 'y' to play again, anything else to quit: ").lower()
        if rematch != "y":
            print(f"\nFinal Score:\n\nUser {user_score} : {computer_score} Computer")
            break

# Main Execution
if __name__ == "__main__":
    start_game()
