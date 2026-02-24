# dicom3tools

Packaging of some of [David A. Clunie's Dicom3tools software](https://www.dclunie.com/dicom3tools.html).

I'd originally planned to make this available in nixpkgs, but per the below
links, the person responsible for the project is deeply reluctant for some of
the binaries to be distributed if they're not compiled with the user's own
allocated UID.  Some of the binaries are clearly safe, and the key ones I
cared about for converting DICOM images to formats ImageMagick can work with
are ones I'd have thought were safe, but those aren't distributed in the
maintainer's binaries for Windows or Mac, and (unlike some binaries) don't
compile to byte-identical executables when compiled with different UIDs.

Maybe I could work out a way to do it safely, and/or just do what Debian did
and only provide binaries that don't include the ones I've been interested
in, but neither of those are very satisfying.  For now this package lives in
my local repository for the rare occasions I want it and for reference for
anyone who manages to stumble across it.

References:

-   [Mailing list discussion about packaging the tools for Debian](https://groups.google.com/g/comp.protocols.dicom/c/cZ8mYtQOXGM)
-   [Debian packaging notes](https://sources.debian.org/src/dicom3tools/1.00~20140902075059-1/debian/README.Debian/)
