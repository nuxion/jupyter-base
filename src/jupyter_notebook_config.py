import os
from IPython.lib import passwd
c = c  # pylint:disable=undefined-variable
#c.NotebookApp.ip = '0.0.0.0'  # https://github.com/jupyter/notebook/issues/3946
c.NotebookApp.ip = os.getenv('JUPYTER_IP', '0.0.0.0')
c.NotebookApp.port = int(os.getenv('JUPYTER_PORT', 8888))
c.NotebookApp.base_url = os.getenv('JUPYTER_BASE', '/')
c.NotebookApp.open_browser = False

# sets a password if PASSWORD is set in the environment
password = os.getenv('JUP_PASSWORD', '')
c.NotebookApp.password = passwd(password)
c.NotebookApp.token = ''
