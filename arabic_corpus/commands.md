## General Commands

To convert all old Windows-1256 encoded arabic to UTF-8:
```sh
find . -type f -name \*.html -exec bash -c "iconv -f Windows-1256 {} > {}.utf8" \;
```

After merging all corpa, the utf8 should be encoded back to Windows-1256. This is a requirement to have each character encoded in a single byte. The GloVe implementation does not consider multi-byte character as in utf8.
```sh
iconv -f utf8 -t Windows-1256
```
To list files in a folder hierarchy, it's faster to ``find . -type f | xargs cat | sed ..`` that to ``find . -type f -exec cat {} \; | sed ..``

### Required Pre-processing
Do arabic preprocessing: Unify the Alef, remove short lines and long spaces, remove all non-arabic characters.
```sh
  sed "s/[$(echo -ne '\u060C\u061B\.,:')]/ /g" \
| sed "s/[^$(echo -ne '\u0621-\u064A ')\r]//g" \
| sed "s/  \+/ /g" \
| sed "/^.\{,30\}$/d" \
| sed "s/[$(echo -ne '\u0622\u0623\u0625')]/$(echo -ne '\u0627')/g"
```

## Corpus Specific Parsers
### Al Shamela Library
At Shamela Library, to dump MDB files, I rely on https://github.com/brianb/mdbtools available on apt.
Each MDB file has some books: t*index* and b*index* tables. It's required to list all b** tables and dump them as:
```sh
  export MDB_JET3_CHARSET=CP1256
  for b in `find Books/ -name \*.mdb` ; do 
    for t in `mdb-tables $b |  tr ' ' '\n' | grep -o "b[0-9]*"` ; do
      mdb-export -H $b $t >> ../shamela.txt; #May add sed commands here as well!
    done
  done
```

### Wikipedia
It's preferred to use a direct parser for the downloaded xml.gz into plain text. This is possible through this [Wiki 
Parser](https://dizzylogic.com/wiki-parser/). After doing a test run, choose the following options for a complete articles dump in plain text:
![wiki_parse](https://user-images.githubusercontent.com/90985/40912749-c55b9c26-67f2-11e8-904f-fc309b4c59c2.jpg)


