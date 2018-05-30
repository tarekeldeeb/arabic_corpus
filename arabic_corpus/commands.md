To convert all old Windows-1256 encoded arabic to UTF-8:

``find . -type f -name *.html -exec bash -c "iconv -f Windows-1256 {} > {}.utf8" \;``
