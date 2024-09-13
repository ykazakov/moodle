# License

See the [LICENSE](LICENSE) file.

# Authors

Original contents (2016): Anders O.F. Hendrickson (anders.o.f.hendrickson AT gmail.com)

2019-2023: Matthieu Guerquin-Kern (guerquin-kern AT crans.org)

# Contents

This work consists of the files [moodle.dtx](moodle.dtx) and [moodle.ins](moodle.ins)
and the derived files `moodle.sty` and `moodle.pdf`. Test files are located in the
[test/](test/) folder with a rudimentary unit test system (see section
[Unit Test](#unit-test) below).

MAKEFILES are distributed to automate the building process (see section
[Building](#building) below).

# Origin

The LaTeX package from version 0.5 onwards is hosted on CTAN:
<https://ctan.org/pkg/moodle>

The development happens on a server hosting a [GITLAB](https://gitlab.com)
instance.
The project is located at <https://framagit.org/mattgk/moodle>.
There, among other things, you can see the activity of the project and you
can download the latest version of the project files.

You can use GIT to access the project files using the command:

    $ git clone "https://framagit.org/mattgk/moodle.git"

To gain write access to the project and contribute, you must have an account on
this server. Visit <https://framagit.org> and register.

# Requirements

The building setup has been only tested under a GNU/LINUX environment (Ubuntu,
specifically).
Although, the building process might be also set on Windows and macOs
environments, the authors will only support the use of GNU/Linux. Windows/macOs
users can install GNU/Linux with a minimal impact on their main working
environment using either
1. a LiveUSB installation (see 
<https://en.wikipedia.org/wiki/List_of_tools_to_create_Live_USB_systems>), or
2. a virtual machine (see virtualbox for instance).

An installation of the TexLive suite is required. The full installation is
not necessary but the moodle package (`.sty` file) requires the following packages:
- `environ` (texlive-latex-extra),
- `xkeyval` (texlive-latex-recommended),
- `amssymb` (texlive-base),
- `iftex` (texlive-base),
- `etoolbox` (texlive-latex-recommended),
- `xpatch` (texlive-latex-extra),
- `array` (texlive-latex-extra),
- `ifplatform` (texlive-base),
- `shellesc` (texlive-latex-base),
- `readprov` (texlive-latex-extra),
- `fancybox` (texlive-latex-recommended), and
- `getitems` (texlive-latex-extra).

The package option `handout` requires:
- `randomlist` (`texlive-plain-generic`).

In order to manipulate images, the package relies on:
- `graphics` (texlive-latex-base)
- GhostScript (www.ghostscript.com),
- ImageMagick (www.imagemagick.org)(the imagemagick policy for pdf files must be modified to enable read and write)
- optipng ([optipng.sourceforge.net](http://optipng.sourceforge.net/)), and
- inkscape (https://inkscape.org)(for svg files).

The python package, that is used in some tests, requires a "python" command to be installed in your system. Typically, in new linux distributions, only python3 is installed by default and python must be linked to python3 to the test to run properly.
- "minted" test requires "pygmentize" to be installed in the system (in ubuntu 22.04 -> "apt install python3-pygments")

Instead, to compile the documentation, the following LaTeX packages are
necessary: `amssymb`, `babel`, `booktabs`, `changelog`, `dtxdescribe`, `eurosym`,
`hyperref`, `longtable`, `minted`, `microtype`, `tikz`, `threeparttable`, and `varioref`.

# Building

The GNU MAKE mechanism is used to automate the building process.
In the [root makefile](makefile), standard targets `all`, `clean`, `distclean`, `dist`,
and `install` are defined.
On multicore machines, you might want to parallelize the building process using
the `-j` option of MAKE.

Otherwise, the file `moodle.sty` can be generated using the command

    $ latex moodle.ins
    
and the documentation file `moodle.pdf` can be generated by running
successively the three commands:

    $ lualatex -halt-on-error -shell-escape moodle.dtx
    $ makeindex -s gglo.ist -o moodle.gls moodle.glo
    $ lualatex -halt-on-error -shell-escape moodle.dtx
    
( see the dependencies in the previous section)

# Install

To install the package on your local *nix system (under `~/texmf/`):

    $ make install

# Unit Test
A rudimentary unit test system is located in the [test/](test/) folder. That helps
ensuring no regression occurs. This system relies on the makefile mechanism.
To run the unit tests:

    $ make test

To ensure the execution of all the tests inside "test" folder:

    $ make clean && make test

## Packages required to perform tests
If while executing the tests a message similar to the following appears

~~~bash
sh: 1: optipng: not found
system returned with code 32512
~~~

Install the package that it is not found. In this case "optipng", and in Ubuntu:

~~~bash
sudo apt install optipng
~~~
