# CATANA - CUT your Wordlist!

![image](https://user-images.githubusercontent.com/83867734/165377486-cbae6ee7-80bc-4aaa-a7c3-351ef69ab3f3.png)

CATANA filters your wordlist according to the specified password policy.

catana.sh [-c] [-h] [-i <wordlist.txt>] [-o <filename.txt>]

Syntax: ./catana.sh [-h | i | o]

Options:
| Argument | Input Example | Description |
| -------- | ---------- | ----------- |
| `-c` | | Random colored output |
| `-h` | | Print this Help |
| `-i` | /usr/share/wordlists/passwords.txt | Input wordlist |
| `-o` | output.txt | Print to a file |

# Install
Clone the repository by:
```
git clone https://github.com/D3vil0per/catana
cd catana
chmod 755 catana.sh
```
# Usage
```
./catana.sh -i rockyou.txt\
./catana.sh -i rockyou.txt -o wl.txt
```
Note: if the input wordlist has root permission, you need to use `sudo`.
