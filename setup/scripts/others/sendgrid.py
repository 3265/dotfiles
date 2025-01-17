import smtplib, sys, ssl
from email.mime.text import MIMEText
from email.header import Header

DEFAULT_SENDER = 'noreply@example.com'
SENDGRID_PASSWORD = 'SG.XXXXXXXXXXXXXX'

client = smtplib.SMTP_SSL('smtp.sendgrid.net', 465)
client.set_debuglevel(1)
client.login('apikey', SENDGRID_PASSWORD)

email_address_list = ["me@example.com"]
subject = "test"
body = "test body"

message = MIMEText(body)
message['Subject'] = Header(subject)
message['From'] = DEFAULT_SENDER
message['To'] = ','.join(email_address_list)

client.sendmail(DEFAULT_SENDER, email_address_list, message.as_string())

