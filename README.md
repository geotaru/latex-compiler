# latex-compiler

## Example

カレントディレクトリにあるresume.texをPDFに変換する

```
$ docker run --rm \
             -v `pwd`:/home/geotaru/workdir \
             -e target=/home/geotaru/workdir/resume.tex \
             geotaru/latex-compiler
```
