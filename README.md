# Document Template HS Coburg

This repository provides a student-maintained and improved version of the
so far available FEIF document template. The template got reworked from
the ground up, improving the author's experience and providing a cleaner
interface to begin with.

While being a template, the project provides some useful commands and
allows the user to further customize and extend it.

You can find an [example document](https://github.com/btoschek/hsc-template/blob/example/Arbeit.pdf)
based on this template (including a small overview of features) over on the
[example](https://github.com/btoschek/hsc-template/tree/example) branch.

> ⚠️ **INFO**: The template is set up to only support German (despite this README
> and the source code being commented and written in English).

## Table of Contents:

- [Prerequisites](#prerequisites)
- [Compiling your document](#compiling-your-document)

## Prerequisites

The build-pipeline associated to this project isn't tailored to an IDE like
[Overleaf](https://www.overleaf.com/). It can easily be run and built with whatever
tool you prefer for writing lots of text.

If you want to build the template in your terminal (which I highly recommend,
cause it's easier than getting an IDE to work, at least from my experience),
you need the following programs installed on your system:

- [make](https://www.gnu.org/software/make/)
- A working [texlive](https://www.tug.org/texlive/) installation

### Installation on Unix-like systems (Linux, MacOS)

Installation on Debian-based distributions:

```sh
apt-get update
apt-get install make
apt-get install texlive-full
```

Installation on Arch-based distributions: (Untested, to be safe install
`texlive-lang` as well)

```sh
pacman -Syyuu
pacman -S make
pacman -S texlive-most
```

### Installation on Windows

Installing programs for development on Windows can get annoying rather quickly.
For this reason, I recommend using a package manager for Windows, namely
[scoop](https://scoop.sh/). We will only use it for one package, but having it on
your system can't hurt.

To install `make` with scoop, run the following commands in your
terminal:

```sh
scoop bucket add main
scoop install make
```

Install the complete TeXLive suite from https://tug.org/texlive/windows.html#install.

## Compiling your document

Compiling your document from scratch is as easy as running the following in your terminal.

```sh
make all
```

If you just want to rebuild the document and you haven't changed the content of index files
in `Verzeichnisse/`, call `make` without any arguments.

To remove temporary files and indices used during compilation, run:

```sh
make clean
```
