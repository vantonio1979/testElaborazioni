import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from robot.libraries.BuiltIn import BuiltIn
import requests

subject = "Email Subject"
body = "This is the body of the text message"
sender = "vantonio79@libero.it"
recipients = ["vantonio79@gmail.com", "vantonio79@gmail.com"]
password = "provAaaa1@"


def prova():
    BuiltIn().log_to_console("sto qua 1")
    BuiltIn().log_to_console("sto qua 2")
    return  "Ciao mondo"

def send_email_py(subject, body, sender, recipients, password):
    msg =  MIMEMultipart("alternative")
    #msg = MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = sender
    msg['To'] = ', '.join(recipients)
    part1 = MIMEText(body, 'html')
    msg.attach(part1)
    #server = smtplib.SMTP("smtp.libero.it", 587)
    with smtplib.SMTP("smtp.libero.it", 25) as smtp_server:
       smtp_server.login(sender, password)
       smtp_server.sendmail(sender, recipients, msg.as_string())
    print("Message sent!")


#send_email_py(subject, body, sender, recipients, password)