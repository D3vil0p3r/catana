# CATANA - CUT your Wordlist!

![image](https://user-images.githubusercontent.com/83867734/159940530-a1cff404-057f-4bb1-9588-5653549eebd2.png)

CATANA filters your wordlist according to the specified password policy.

catana.sh [-h] [-i <wordlist.txt>] [-o <filename.txt>]

Syntax: ./catana.sh [-h | i | o]

Options:
| Argument | Input Example | Description |
| -------- | ---------- | ----------- |
| `-h` | | Print this Help |
| `-i` | /usr/share/wordlists/passwords.txt | Input wordlist |
| `-o` | output.txt | Print to a file |

Usage Example:\
./catana.sh -i rockyou.txt
