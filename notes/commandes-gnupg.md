# Quelques commandes avec gnuPG

[gnuPG](https://wiki.archlinux.org/index.php/GnuPG) vous permet de crypter et de signer vos données et communications

* Lister public keys

    ```bash
    $ gpg --list-keys
    ```

* Lister private keys

    ```bash
    $ gpg --list-secret-keys
    ```

* Importer keys

    ```bash
    $ gpg --import key.gpg
    ```

* Exporter keys sous format binaire

    ```bash
    $ gpg --export zami3l@fsociety.me > zami3l.gpg
    ```

* Exporter keys sous format ASCII

    ```bash
    $ gpg --armor --export zami3l@fsociety.me > zami3l.asc
    ```

* Editer keys

    ```bash
    $ gpg --edit-key zami3l@fsociety.me
    ```