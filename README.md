# latex-compiler

texファイルからPDFファイルを生成するDockerアプリケーション．

## Example

カレントディレクトリにあるresume.texをPDFに変換する．

```bash
$ docker run --rm \
             -v `pwd`:/home/geotaru/workdir \
             -e target=/home/geotaru/workdir/resume.tex \
             geotaru/latex-compiler
```
