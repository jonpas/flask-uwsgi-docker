# Flask and uWSGI Docker image

Docker image with only Flask uWSGI, to be used with a reverse proxy such as Traefik.


## Example

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
