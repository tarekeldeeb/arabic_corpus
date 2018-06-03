To convert all old Windows-1256 encoded arabic to UTF-8:

```
find . -type f -name *.html -exec bash -c "iconv -f Windows-1256 {} > {}.utf8" \;
```

Do arabic preprocessing: Unify the Alef, remove dialects and long spaces, remove all non-arabic characters.
```
sed -i "s/[$(echo -ne '\u0622\u0623\u0625')]/$(echo -ne '\u0627')/g" test.utf8
sed -i 's/  \+/ /g' test.utf8
sed -i "s/[^$(echo -ne '\u0621-\u064A ')]//g" test.utf8
```

To list files in a folder hierarchy, it's faster to ``find . -type f | xargs cat | sed ..`` that to ``find . -type f -exec cat {} \; | sed ..``

At Shamela Library, to dump MDB files, I rely on https://github.com/brianb/mdbtools available on apt.
Each MDB file has some books: t*index* and b*index* tables. It's required to list all b** tables and dump them as:
```
  export MDB_JET3_CHARSET=CP1256
  for b in `find Books/ -name \*.mdb` ; do 
    for t in `mdb-tables $b |  tr ' ' '\n' | grep -o "b[0-9]*"` ; do
      mdb-export -H $b $t >> ../shamela.txt;
    done
  done
  
  
```
