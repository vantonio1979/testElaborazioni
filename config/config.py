#BROWSER = 'Chrome'
BROWSER = 'headlesschrome'
WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

HOST='https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm'
IS_ANGULAR='False'
TAGETIK_VERSION_MAIN = '5'
TAGETIK_VERSION = '5.3.30.0'

LOGIN_URL = HOST + '/tagetikcpm'
TAGETIK_BASE_URL = HOST + '/tagetikcpm/' + TAGETIK_VERSION_MAIN + '?ver=' + TAGETIK_VERSION
TAGETIK_API_URL = HOST + '/tagetikcpm/api'

USERNAME = '${USER}'
PASSWORD = '${USER}!'

WAIT_A_BIT = '2s'
SELENIUM_TIMEOUT = '60s'
DOWNLOAD_PATH = ''

TAGETIK_DBNAME = 'TGK_DEV_QA_TRUNK_CONSOLIDATION_SYSTEMDEMO'
TAGETIK_DBUSER = 'tagetikcpm'
TAGETIK_DBPASSWORD = 'tagetikcpm'
TAGETIK_DBHOST = 'aws-tgk-systemdemo-postgres13.cjjjy1omgekj.eu-central-1.rds.amazonaws.com'
TAGETIK_DBPORT = '5432'
DB_ALIAS = 'consolidation'