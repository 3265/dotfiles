# NTP

Activate NTP server.

```
$ timedatectl
               Local time: Mon 2020-08-31 18:51:48 JST
           Universal time: Mon 2020-08-31 09:51:48 UTC
                 RTC time: Mon 2020-08-31 09:51:49
                Time zone: Asia/Tokyo (JST, +0900)
System clock synchronized: no
              NTP service: inactive
          RTC in local TZ: no
$ timedatectl set-ntp true
$ timedatectl
               Local time: Mon 2020-08-31 18:57:25 JST
           Universal time: Mon 2020-08-31 09:57:25 UTC
                 RTC time: Mon 2020-08-31 09:57:25
                Time zone: Asia/Tokyo (JST, +0900)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

## REFERENCES:
- https://qiita.com/j8takagi/items/cc63ee5e9cfcb20fd244
