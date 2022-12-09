# Flask and uWSGI Docker image

Docker image with only Flask uWSGI, to be used with a reverse proxy such as Traefik. No reverse proxy is included in the image.

Currently Alpine Python 3.11 image. _If there is interest for a bigger matrix of tags, distributions or other publishing platforms, open an issue._


## Setup

### Docker Compose

```yml
version: '3'

services:
  web:
    image: ghcr.io/jonpas/flask-uwsgi:latest
    volumes:
      - ./app:/app
```


### Application

`web/app.py`:
```py
from flask import Flask
from werkzeug.middleware.proxy_fix import ProxyFix

app = Flask(__name__)

app.wsgi_app = ProxyFix(app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0")
```

`web/wsgi.py`:
```py
from web import app

if __name__ == "__main__":
    app.run()
```

`wsgi.py` is required for uWSGI to start correctly, however the application/folder name can be your own (`web` used as an example).

### Reverse Proxy

#### Traefik

Setup a rule, an entrypoint and any TLS configuration you require. Service port will be `8000` automatically as the only one exposed in the container.
