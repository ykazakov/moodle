# License

See LICENSE file.

# Authors

Original contents (2016): Anders O.F. Hendrickson (anders.hendrickson@snc.edu)

2019-2020: Matthieu Guerquin-Kern (guerquin-kern@crans.org)

# Contents

This work consists of the files moodle.dtx and moodle.ins and the derived
file moodle.sty. Test files are located in the test/ folder with a rudimentary
unit test system.

MAKEFILES are distributed to automate the building process (See Section BUILDING
below).

# Origin

The LaTeX package as of version 0.5 is hosted on CTAN:
<https://ctan.org/pkg/moodle>

These sources are hosted on a private server using hosting
[GITLAB](https://gitlab.com).
To gain access to the project, you must have an account on this server. To
create an account, there are two ways:
1. visit <https://gitlab.mattgk.myds.me> and register
2. send a public key (RSA or other) to Matthieu Guerquin-Kern.

Using your account, you can see the activity of the project at
<https://gitlab.mattgk.myds.me/mattguer/moodle>. There, among other things, you
can download the latest version of the project files. If you upload a public key
in your profile settings, you will be able to access the project through GIT
(see below).

When your public key is registered in your profile settings (you must localy
have the corresponding private key), you can use GIT to access the project files
and contribute.
The sources are cloned locally using the command:

    $ git clone "ssh://git@gitlab.mattgk.myds.me:2222/mattguer/moodle.git"

# Requirements

The building setup has been only tested under a GNU/LINUX environment (Ubuntu,
specifically).
Although, the building process might be also set on Windows and MacOs
environments, the authors will only support the use of GNU/LINUX. Windows/MacOs
users can install GNU/Linux with minimum modification of their main working
environment using either
1. a LiveUSB installation (see 
<https://en.wikipedia.org/wiki/List_of_tools_to_create_Live_USB_systems>), or
2. a virtual machine (see virtualbox for instance).

An installation of the TexLive suite is required. The complete installation is
not necessary but the moodle package (.sty file) requires the following packages:
- environ (texlive-latex-extra),
- xkeyval (texlive-latex-recommended),
- amssymb (texlive-base),
- trimspaces (texlive-latex-extra),
- etex (texlive-base),
- etoolbox (texlive-latex-recommended),
- xpatch (texlive-latex-extra),
- array (texlive-latex-extra),
- ifplatform (texlive-base),
- fancybox (texlive-latex-recommended),
- getitems (texlive-latex-extra).

In order to manipulate images, the package uses:
- GhostScript (www.ghostscript.com),
- ImageMagick (www.imagemagick.org), and
- optipng (http://optipng.sourceforge.net/).

In addition, to compile the documentation, the following LaTeX packages are
necessary: amssymb, metalogo, multirow, threeparttable, booktabs, hyperref,
tikz, minted, and microtype.

# Building

The GNU MAKE mechanism is used to automate the building process.
Standard targets 'all', 'clean', 'distclean' are available.
On multicore machines, you might want to parallelize the building process using
the '-j' option of MAKE.

# Unit Test
A rudimentary unit test system is located in the test/ folder. That helps
ensuring no regression occurs. This system relies on the makefile mechanism.
To run the unit tests:
    $ make test
