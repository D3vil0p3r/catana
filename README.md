# CATANA - CUT your Wordlist!

![image](https://user-images.githubusercontent.com/83867734/165377486-cbae6ee7-80bc-4aaa-a7c3-351ef69ab3f3.png)

CATANA filters your wordlist according to the specified password policy.

catana.sh [-h] [-i <wordlist.txt>] [-o <filename.txt>]

Syntax: ./catana.sh [-h | i | o]

Options:
| Argument | Input Example | Description |
| -------- | ---------- | ----------- |
| `-h` | | Print this Help |
| `-i` | /usr/share/wordlists/passwords.txt | Input wordlist |
| `-o` | output.txt | Print to a file |

Usage Examples:\
./catana.sh -i rockyou.txt\
./catana.sh -i rockyou.txt -o wl.txt
