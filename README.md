# ocrd-dita

> Build documentation for OCR-D module projects using Markdown/DITA

## Fetch DITA / LWDITA

```
  make download plugins
```

## Build docs

Docs source must be named `DOC.md`.

```
   make build IN="/path/to/folder-containing-DOC.md" OUT="/tmp/out"
```

## Example

In the root directory of the repository, run:

```
make download plugins build IN=example
```

The output will be in `./example/out`.
