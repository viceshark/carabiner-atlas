# Serves the atlas with nginx at /.
# The page source is a Claude Artifact fragment (no doctype, head or body),
# so the build wraps it into a full HTML document and saves it as index.html.
FROM nginx:1.27-alpine

COPY carabiner-atlas.html /tmp/page.html
RUN { \
      printf '%s\n' '<!doctype html>' '<html lang="ru">' '<head>' \
        '<meta charset="utf-8">' \
        '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">' \
        '<style>[hidden]{display:none!important}</style>' \
        '</head>' '<body>'; \
      cat /tmp/page.html; \
      printf '%s\n' '</body>' '</html>'; \
    } > /usr/share/nginx/html/index.html \
 && rm /tmp/page.html

EXPOSE 80
