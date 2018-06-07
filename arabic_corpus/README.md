This is the largest free arabic corpus online.
```
BUILDING VOCABULARY
Processed 1890071877 tokens.
Counted 2007558 unique words.
Truncating vocabulary at min count 5.
Using vocabulary of size 670441.
```
## Build the Arabic Corpus
### Dowload Resources
The arabic corpus {1.9B word} consists of the following resources:
 - ShamelaLibrary348.7z [link](https://www.quran.tv/ketab/ShamelaLibrary348.7z) {1.15B}
 - UN arabic corpus [link](http://conferences.unite.un.org/UNCorpus/en/DownloadOverview) {0.37B}
 - AraCorpus.tar.gz [link](http://aracorpus.e3rab.com/argistestsrv.nmsu.edu/AraCorpus.tar.gz) {0.14B}
 - Arabic Wikipedia Latest Articles Dump [link](https://dumps.wikimedia.org/arwiki/latest/arwiki-latest-pages-articles.xml.bz2) {0.11B}
 - Tashkeela-arabic-diacritized-text-utf8-0.3.zip [link](https://netix.dl.sourceforge.net/project/tashkeela/) {0.07}
 - watan-2004.7z [link](https://netix.dl.sourceforge.net/project/arabiccorpus/watan-2004corpus/watan-2004.7z) {0.01B}
 
More resources are listed by [Ayman Eddakrouri](https://sites.google.com/a/aucegypt.edu/infoguistics/directory/Corpus-Linguistics/arabic-corpora) 
### Parse and Process
After downloading the resources from the above links, run the [make_corpus.sh](make_corpus.sh) to automate the extraction, preprocessing,  formatting and finally generating a single-line file will the full arabic corpus. Some the the used commands are discussed in [commands](commands.md). 

Due to file sizes limits in github, no files are added due to huge file sizes.

## Download Pre-built Arabic Corpus
A zipped tar may be downloaded from my [Google Drive](https://drive.google.com/uc?export=download&id=11sy-bN658S3g6jXvJJW7C6RqwdhOkwre).
I welcome mirroring this file.
