To convert all old Windows-1256 encoded arabic to UTF-8:

``find . -type f -name *.html -exec bash -c "iconv -f Windows-1256 {} > {}.utf8" \;``

Do arabic preprocessing: Unify the Alef, remove dialects and long spaces, remove all non-arabic characters.

``sed -i "s/[$(echo -ne '\u0622\u0623\u0625')]/$(echo -ne '\u0627')/g" test.utf8``
``sed -i 's/  \+/ /g' test.utf8``
``sed -i "s/[^$(echo -ne '\u0621-\u064A ')]//g" test.utf8``
