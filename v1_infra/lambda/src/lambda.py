import boto3
import json
import logging
import os

from base64 import b64decode
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError


SLACK_CHANNEL = os.environ['SLACK_CHANEL']

ENCRYPTED_WEB_HOOK_URL = os.environ['WEB_HOOK_URL']
HOOK_URL = boto3.client('kms').decrypt(
        CiphertextBlob=b64decode(ENCRYPTED_WEB_HOOK_URL),
        EncryptionContext={'LambdaFunctionName': os.environ['AWS_LAMBDA_FUNCTION_NAME']}
    )['Plaintext'].decode('utf-8')
    
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    print('DECRYPTED : {}'.format(HOOK_URL))
    slack_message = {
        'channel': SLACK_CHANNEL,
        'attachments':  [{
            'title': 'DBでエラーが発生しました',
            'text': 'DBでエラーが発生しました'    
        }]
    }

    req = Request(HOOK_URL, json.dumps(slack_message).encode('utf-8'))
    
    try:
        response = urlopen(req)
        response.read()
        logger.info("Message posted to %s", slack_message['channel'])
    except HTTPError as e:
        logger.error("Request failed: %d %s", e.code, e.reason)
    except URLError as e:
        logger.error("Server connection failed: %s", e.reason)

