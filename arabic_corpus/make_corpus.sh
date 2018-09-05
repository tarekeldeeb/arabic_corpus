#!/bin/sh

# Assuming the following files are already downloaded:
# ar-download/
#	 AraCorpus.tar.gz
#	 ShamelaLibrary348.7z
#	 watan-2004.7z
#	 arwiki-latest-pages-articles.xml.bz2
#	 Tashkeela-arabic-diacritized-text-utf8-0.3.zip
#	 pos_arabic.txt and neg_arabic.txt
#	 UNv1.0.6way.ar.txt

DL_LOC="ar-download"
mkdir $DL_LOC/out
cd $DL_LOC/out

preproccp1256 () {
   tr $'\xA1\xBA.,:t' ' ' $1 |tr -d $'\x00-\x1F\x21-\xBF\xEE-\xFF\xD7\xDC\xE0\xE2\xE7-\xEB'| sed "s/  \+/ /g"| LANG=C sed "/^.\{,30\}$/d"| tr $'\xc5\xc2\xc3' $'\xc7'; 
}
#preprocutf8 () { sed "s/[$(echo -ne '\u060C\u061B\.,:')]/ /g" $1 | sed "s/[^$(echo -ne '\u0621-\u064A ')\r]//g" | sed "s/  \+/ /g" | sed "/^.\{,30\}$/d" | sed "s/[$(echo -ne '\u0622\u0623\u0625')]/$(echo -ne '\u0627')/g"; }

# Parse AraCorpus
tar xzf ../AraCorpus.tar.gz
cat AraCorpus/Data/Collection-* | preproccp1256 > aracorpus.txt
rm -fr AraCorpus

# Parse Tashkeela
unzip ../Tashkeela-arabic-diacritized-text-utf8-0.3.zip
find Tashkeela-arabic-diacritized-text-utf8-0.3/texts.txt -type d -exec rename 's/ //g' {} \;
find Tashkeela-arabic-diacritized-text-utf8-0.3/texts.txt -type f -exec rename 's/ //g' {} \;
find Tashkeela-arabic-diacritized-text-utf8-0.3/texts.txt/ -type f | gawk 'BEGIN{ a=1 }{ printf "mv %s Tashkeela-arabic-diacritized-text-utf8-0.3/texts.txt/%04d.utf8\n", $0, a++ }' | bash
cat Tashkeela-arabic-diacritized-text-utf8-0.3/texts.txt/*.utf8 > tash.unproc.utf8
iconv -c -f utf8 -t Windows-1256 tash.unproc.utf8 | preproccp1256 > tashkeela.txt
rm -f tash.unproc.utf8
rm -fr Tashkeela-arabic-diacritized-text-utf8-0.3

# Parse ShamelaLibrary
7z x ../ShamelaLibrary348.7z
export MDB_JET3_CHARSET=CP1256
export MDBICONV=CP1256
for b in `find shamela/Books/ -name \*.mdb` ; do
  for t in `mdb-tables $b |  tr ' ' '\n' | grep -o "b[0-9]*"` ; do
    mdb-export -H $b $t | preproccp1256 >> shamela.txt;
  done
done
rm -fr shamela

# Parse Wikpedia
## For a faster parser, use: https://dizzylogic.com/wiki-parser [64-bit Windows App]
wget https://raw.githubusercontent.com/attardi/wikiextractor/master/WikiExtractor.py
bzip2 -dk ../arwiki-latest-pages-articles.xml.bz2 
mv ../arwiki-latest-pages-articles.xml arwiki.xml
python WikiExtractor.py --processes 8 -b 50M -q arwiki.xml
find text -type f | xargs cat > wiki.unproc.utf8
iconv -c -f utf8 -t Windows-1256 wiki.unproc.utf8 | preproccp1256 > wiki.txt
rm -fr text WikiExtractor.py arwiki.xml wiki.unproc.utf8

# Parse Watan
mkdir watan
cd watan
7z x ../../watan-2004.7z
find . -type f | xargs cat | preproccp1256 > ../watan.txt
cd ..
rm -fr watan

# Parse UNv1
#tar xzf ../UNv1.0.ar-en.tar.gz
iconv -c -f utf8 -t Windows-1256 ../UNv1.0.6way.ar.txt | preproccp1256 > un.txt
#rm -fr ar-en

#Parse Arabic Tweets
cat ../*_arabic.txt > tweets.unproc.utf8
iconv -c -f utf8 -t Windows-1256 tweets.unproc.utf8 | preproccp1256 > tweets.txt
rm -f tweets.unproc.utf8

# Final Concat + Replace Linebreaks with a space
cat *.txt | tr '\r\n' ' ' > ../../arabic_corpus
cd ../..
echo "Done!"
echo "You may delete $DL_LOC directory."
