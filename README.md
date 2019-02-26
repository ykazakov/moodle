# Licence

Copyright 2016 by Anders O.F. Hendrickson (anders.hendrickson@snc.edu)
This work may be distributed and/or modified under the conditions of the LaTeX
Project Public License, either version 1.3 of this license or (at your option)
any later version.

The latest version of this license is in http://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions of LaTeX version
2005/12/01 or later.

This work has the LPPL maintenance status `maintained'. 

The Current Maintainer of this work is Anders O.F. Hendrickson.

# Authors

Original contents (2016): Anders O.F. Hendrickson (anders.hendrickson@snc.edu)

2019: Christophe Barès, Matthieu Guerquin-Kern

# Contents

This work consists of the files moodle.dtx and moodle.ins and the derived
file moodle.sty.

MAKEFILES are distributed to automate the building process (See Section BUILDING
below).

# Origin

The LaTeX package as of version 0.5 is hosted on CTAN:
<https://ctan.org/pkg/moodle>

These sources are hosted on a private server using hosting
[GITLAB](https://gitlab.com).
To gain access to the project, you must have an account on this server. To
create an account, there are two ways:
1. visit <https://gitlab.mattgk.myds.me> and register an account using your
email in "@ensea.fr".
2. send a public key (RSA or other) to the authors. They will create it for you.

Using your account, you can see the activity of the project at
<https://gitlab.mattgk.myds.me/ensea/ss_fame>. There, among other things, you
can download the latest version of the project files. If you upload a public key
in your profile settings, you will be able to access the project through GIT
(see below).

When your public key is registered in your profile settings (you must localy
have the corresponding private key), you can use GIT to access the project files
and contribute.
The sources are cloned locally using the command:

    $ git clone "ssh://git@gitlab.mattgk.myds.me:2222/ensea/moodle.git"

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
not necessary but amsmath and related, and PGF/TikZ might be useful.
Other tools are used:
* openssl (for graphics)
* ghostscript (for graphics)
* imagemagick (for graphics)
* optipng (for graphics)
* meld
* ... (list to be completed)

# Building

The GNU MAKE mechanism is used to automate the building process.
Standard targets 'all', 'clean', 'distclean' are available.
On multicore machines, you might want to parallelize the building process using the '-j' option of MAKE.
