# Root user Settings

## 1. firstly, follow security status

https://console.aws.amazon.com/iam/home#/home

## 2. Delete Access key of root user

- open https://console.aws.amazon.com/iam/home#/security_credentials
- click Access keys (access key ID and secret access key)
- delete access key 

## 3. Enable Root User to login by MFA

- open https://console.aws.amazon.com/iam/home
- click Activate MFA on your root account
- add Activate MFA on your root account
- read QR-code by 1password
- type passcode

## 4. Create Management group 
- open https://console.aws.amazon.com/iam/home
- click group tab
- Add group following that:
   - group name: mgmt-group
   - select AdministratorAccess

## 5. Create Management IAM usre
- open IAM user list 
- Click Add button
- Add user following below that:
  - user name: mgmt-user
  - access type: AWS management console access
     - NOTE: management user doesn't see a need programmatic access, i.e. access key 
  - console password: custom
  - require password reset: no
  - group: mgmt-group
  - console access: enable
  - tag: none
  - MFA device: virtual MFA device
  

## 6. Change PW policy 

- minimum length is 8 
- need a large case
- need small case
- need number


## 7. update bill setting

defaultly, no one can not see the bill info withou root user.
but i don't want to use root user so i'll allow IAM user to see bill info.

- open https://console.aws.amazon.com/billing/home#/account
- scroll until IAM User and Role Access to Billing Information
- click edit
- enable Activate IAM Access and update it

## 8. setting for cost management and bill information

- open https://console.aws.amazon.com/billing/home#/preferences
- check following and save them
  - Receive PDF Invoice By Email
  - Receive Billing Alerts
  - Receive Free Tier Usage Alerts

## 9. make a billing alerm by cloudwatch

- open https://console.aws.amazon.com/cloudwatch/home?region=us-east-1
  - only us-east can do this operation
- click billing
- click create alarm by following cond
  - exceed: 100 USD
  - email: me@example.com
- confirm email
- click view alearm

# IAM management user settings

## change region

- login IAM management user
- change region to Tokyo

## make CloudTrail
 
- to leave a history or log of API call
- open https://ap-northeast-1.console.aws.amazon.com/cloudtrail/home?region=ap-northeast-1#/subscribe
- Create crowdtail by following info:
   - Trail name: mgmt-tail
   - Apply trail to all regions: yes
   - Create a new S3 bucket: yes
   - S3 Bucket: mgmt-tail
   

## git-secrets

```
$ yay -S git-secrets # on arch
$ cd /path/to/ur/repo
$ git secrets --install # install git secrets to the repo
$ git secrets --register-aws # deny secret, if u want to enable globally, just add --global options at last
$ git secrets --list
secrets.providers git secrets --aws-provider
secrets.patterns [A-Z0-9]{20}
secrets.patterns ("|')?(AWS|aws|Aws)?_?(SECRET|secret|Secret)?_?(ACCESS|access|Access)?_?(KEY|key|Key)("|')?\s*(:|=>|=)\s*("|')?[A-Za-z0-9/\+=]{40}("|')?
...
```


# References
- https://qiita.com/tmknom/items/303db2d1d928db720888
- https://www.slideshare.net/AmazonWebServicesJapan/awswebinar-aws-56260969
