## Generate a new key

```
[mike@mike-pc ~][19:03:13][Py:3.8.1][O][I][%][λ]> gpg --full-gen-key
gpg (GnuPG) 2.2.19; Copyright (C) 2019 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
  (14) Existing key from card
Your selection?
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
Key does not expire at all
Is this correct? (y/N) y

GnuPG needs to construct a user ID to identify your key.

Real name: mike
Name must be at least 5 characters long
Real name: mgoldchild
Email address: mgoldchild@gmail.com
Comment:
You selected this USER-ID:
    "xxx <xxx@example.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit?
Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: WARNING: server 'gpg-agent' is older than us (2.2.18 < 2.2.19)
gpg: Note: Outdated servers may lack important security fixes.
gpg: Note: Use the command "gpgconf --kill all" to restart them.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

gpg: key BDDB43041BF65C3E marked as ultimately trusted
gpg: directory '/home/mike/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/home/mike/.gnupg/openpgp-revocs.d/00637C918AFC60EF6C53F8FEBDDB43041BF65C3E.rev'
public and secret key created and signed.

pub   rsa4096 2020-01-17 [SC]
      00637C918AFC60EF6C53F8FEBDDB43041BF65C3E
uid                      xxx <xxx@example.com>
sub   rsa4096 2020-01-17 [E]

[mike@mike-pc ~][19:06:59][Py:3.8.1][O][I][%][λ]>
[mike@mike-pc ~][19:07:10][Py:3.8.1][O][I][%][λ]> gpg --list-secret-keys --keyid-format long
gpg: WARNING: server 'gpg-agent' is older than us (2.2.18 < 2.2.19)
gpg: Note: Outdated servers may lack important security fixes.
gpg: Note: Use the command "gpgconf --kill all" to restart them.
/home/mike/.gnupg/pubring.kbx
-----------------------------
sec   rsa4096/BDDB43041BF65C3E 2020-01-17 [SC]
      00637C918AFC60EF6C53F8FEBDDB43041BF65C3E
uid                 [ultimate] xxx <xxx@example.com>
ssb   rsa4096/5F95054F1052FAC5 2020-01-17 [E]

[mike@mike-pc ~][19:08:08][Py:3.8.1][O][I][%][λ]> gpg --armor --export BDDB43041BF65C3E
...
```
https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/

## export and import

```
$ gpg --export-secret-key -a > secretkey.asc
$ gpg --import secretkey.asc
$ shred --remove secretkey.asc
```

https://askubuntu.com/questions/32438/how-to-share-one-pgp-key-on-multiple-machines
