# Configuration d'un relay smtp

## Prerequisites

```zsh
sudo apt install bsd-mailx msmtp msmtp-mta
```

## Add conf

> ~/.mailrc
```zsh
set sendmail="/usr/bin/msmtp"
```

> ~/.msmtprc
```zsh
# Set default values for all following accounts.
defaults

account alert

host smtp.mailfence.com
tls_starttls off
port 465

user alert
passwordeval "pass mail/alert@mailfence.com"

from alert@mailfence.com

account default : alert
```

## Add permission
```zsh
chmod 600 ~/.mailrc
chmod 600 ~/.msmtprc
```

## Test mail
```zsh
echo "Hello friend" | mail -s "Friend" null@zami3l.com
```
