import os
import shutil
import time
from datetime import datetime

# ASCII-шрифты для цифр и двоеточия
DIGITS = {
    "0": [
        " █████ ",
        "██   ██",
        "██   ██",
        "██   ██",
        " █████ "
    ],
    "1": [
        "   ██  ",
        " ████  ",
        "   ██  ",
        "   ██  ",
        "██████ "
    ],
    "2": [
        " █████ ",
        "██   ██",
        "   ███ ",
        " ███   ",
        "███████"
    ],
    "3": [
        "██████ ",
        "     ██",
        " █████ ",
        "     ██",
        "██████ "
    ],
    "4": [
        "██  ██ ",
        "██  ██ ",
        "██████ ",
        "    ██ ",
        "    ██ "
    ],
    "5": [
        "███████",
        "██     ",
        "██████ ",
        "     ██",
        "██████ "
    ],
    "6": [
        " █████ ",
        "██     ",
        "██████ ",
        "██   ██",
        " █████ "
    ],
    "7": [
        "███████",
        "     ██",
        "    ██ ",
        "   ██  ",
        "  ██   "
    ],
    "8": [
        " █████ ",
        "██   ██",
        " █████ ",
        "██   ██",
        " █████ "
    ],
    "9": [
        " █████ ",
        "██   ██",
        " ██████",
        "     ██",
        " █████ "
    ],
    ":": [
        "   ",
        "██ ",
        "   ",
        "██ ",
        "   "
    ]
}


def clear():
    os.system("cls" if os.name == "nt" else "clear")


def make_ascii_time(t):
    blocks = [DIGITS[ch] for ch in t]
    lines = []
    for row in range(5):
        line = "  ".join(block[row] for block in blocks)
        lines.append(line)
    return lines


while True:
    clear()

    now = datetime.now().strftime("%H:%M")  # "телефонное" время 24h
    art = make_ascii_time(now)

    term_size = shutil.get_terminal_size()
    width, height = term_size.columns, term_size.lines

    art_height = len(art)
    top_padding = max((height - art_height) // 2, 0)

    print("\n" * top_padding)

    for line in art:
        print(line.center(width))

    time.sleep(1)