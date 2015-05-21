dnl The initialization part
AC_INIT([webkit-sharp], [0.3])
AC_CONFIG_SRCDIR([README])
AC_CANONICAL_TARGET
AM_INIT_AUTOMAKE
AM_MAINTAINER_MODE
AC_PROG_INSTALL

dnl Version information
MONO_REQUIRED_VERSION=2.6.0
WEBKIT_REQUIRED_VERSION=1.3
GTKSHARP_REQUIRED_VERSION=1.9.0

AC_SUBST(MONO_REQUIRED_VERSION)
AC_SUBST(WEBKIT_REQUIRED_VERSION)
AC_SUBST(GTKSHARP_REQUIRED_VERSION)

dnl Package settings
ASSEMBLY_NAME=$PACKAGE
ASSEMBLY_VERSION="1.1.15.0"
ASSEMBLY_NAMESPACE="WebKit"
ASSEMBLY_SHORTNAME="webkit"
ASSEMBLY_TITLE="WebKit#"
ASSEMBLY_DESCRIPTION="WebKit bindings for Mono"
ASSEMBLY_COMPANY="Novell, Inc."
ASSEMBLY_COPYRIGHT="2008, 2009 Novell, Inc."
ASSEMBLY_PC=$ASSEMBLY_NAME-1.0
ASSEMBLY_LICENSE="X11/MIT"
ASSEMBLY_URL="http://www.go-mono.org/"
						 
AC_SUBST(ASSEMBLY_NAME)
AC_SUBST(ASSEMBLY_VERSION)
AC_SUBST(ASSEMBLY_NAMESPACE)
AC_SUBST(ASSEMBLY_SHORTNAME)
AC_SUBST(ASSEMBLY_TITLE)
AC_SUBST(ASSEMBLY_DESCRIPTION)
AC_SUBST(ASSEMBLY_COMPANY)
AC_SUBST(ASSEMBLY_COPYRIGHT)
AC_SUBST(ASSEMBLY_PC)
AC_SUBST(ASSEMBLY_LICENSE)
AC_SUBST(ASSEMBLY_URL)

dnl Add additional configuration options
AC_ARG_ENABLE(monodoc,
AS_HELP_STRING([--enable-monodoc],[Enable the generation of documentation using monodoc (defaults to yes)]),
[ case "${enableval}" in
	yes) enable_monodoc="yes" ;;
	no) enable_monodoc="no" ;;
	*) AC_MSG_ERROR(bad value ${enableval} for --enable-monodoc) ;;
  esac ],
[ enable_monodoc="yes" ])


dnl Check for pkg-config
AC_PATH_PROG(PKG_CONFIG, pkg-config, no)
if test "x$PKG_CONFIG" = "xno"; then
	AC_MSG_ERROR(['pkg-config' is not in your PATH.])
fi


dnl Check for mono
PKG_CHECK_MODULES(MONO, mono >= $MONO_REQUIRED_VERSION, has_mono="yes", has_mono="no")
if test "x$has_mono" = "xno" ; then
	AC_MSG_ERROR([Mono at version at least $MONO_REQUIRED_VERSION not found])
fi


dnl Check for mono interpreter (mint)
PKG_CHECK_MODULES(MINT_DEPENDENCY, mint >= $MONO_REQUIRED_VERSION, has_mint="yes", has_mint="no")


dnl Check whether to use Mono or Mint
if test "x$has_mono" = "xyes"; then
	if test `uname -s` = "Darwin"; then
		AC_PATH_PROG(RUNTIME, mono, no)
		AC_PATH_PROG(CSC, mcs, no)
		LIB_PREFIX=
		LIB_SUFFIX=.dylib
	else
		AC_PATH_PROG(RUNTIME, mono, no)
		AC_PATH_PROG(CSC, mcs, no)
		LIB_PREFIX=.so
		LIB_SUFFIX=
	fi
else
	if test "x$has_mint" = "xyes"; then
		AC_PATH_PROG(RUNTIME, mint, no)
		AC_PATH_PROG(CSC, mcs, no)
		LIB_PREFIX=.so
		LIB_SUFFIX=
	else
		AC_PATH_PROG(CSC, csc.exe, no)
		if test x$CSC = "xno"; then
			AC_MSG_ERROR([You need to install either mono or .Net])
		else
			RUNTIME=
			LIB_PREFIX=
			LIB_SUFFIX=.dylib
		fi
	fi
fi

AC_SUBST(LIB_PREFIX)
AC_SUBST(LIB_SUFFIX)
AC_SUBST(RUNTIME)


dnl C# compiler checks
CS="C#"
if test "x$CSC" = "xno" ; then
    AC_MSG_ERROR([No $CS compiler found])
fi

AC_SUBST(CSC)


dnl Global Assembly Cache util check
AC_PATH_PROG(GACUTIL, gacutil, no)
if test "x$GACUTIL" = "xno" ; then
	AC_MSG_ERROR([No gacutil tool found])
fi

GACUTIL_FLAGS="/package $ASSEMBLY_NAME /root "'$(DESTDIR)$(libdir)'
                                     
AC_SUBST(GACUTIL)
AC_SUBST(GACUTIL_FLAGS)


dnl Check for gtk-sharp
PKG_CHECK_MODULES(GTK_SHARP, gtk-sharp-2.0 >= $GTKSHARP_REQUIRED_VERSION)
gtksharp_prefix=`pkg-config --variable=prefix gtk-sharp-2.0`

AC_SUBST(GTK_SHARP_CFLAGS)
AC_SUBST(GTK_SHARP_LIBS)
AC_SUBST(gtksharp_prefix)


dnl Check for WebKit
PKG_CHECK_MODULES(WEBKIT, webkit-1.0 >= $WEBKIT_REQUIRED_VERSION)
webkit_prefix=`pkg-config --variable=prefix webkit-1.0`
webkit_version=`pkg-config --modversion webkit-1.0`
ASSEMBLY_PACKAGE_VERSION=$webkit_version

AC_SUBST(WEBKIT_LIBS)
AC_SUBST(webkit_prefix)
AC_SUBST(ASSEMBLY_PACKAGE_VERSION)


dnl Check for gapi
AC_PATH_PROG(GAPI_PARSER, gapi2-parser, no)
if test "x$GAPI_PARSER" = "xno"; then
	AC_MSG_CHECKING(for gapi2-parser.exe)
	GAPI_PARSER=`which gapi2-parser.exe 2> /dev/null`
	if test "x$GAPI_PARSER" = "xno" ; then
		AC_MSG_ERROR(['gapi2_parser'/'gapi2-parser.exe' not found.])
	fi
	AC_MSG_RESULT($GAPI_PARSER)
	GAPI_PARSER="$MONO $GAPI_PARSER"
fi

AC_PATH_PROG(GAPI_FIXUP, gapi2-fixup, no)
if test "x$GAPI_FIXUP" = "xno"; then
	AC_MSG_CHECKING(for gapi2-fixup.exe)
	GAPI_FIXUP=`which gapi2-fixup.exe 2> /dev/null`
	if test "x$GAPI_FIXUP" = "xno" ; then
		AC_MSG_ERROR(['gapi2_fixup'/'gapi2-fixup.exe' not found.])
	fi
	AC_MSG_RESULT($GAPI_FIXUP)
	GAPI_FIXUP="$MONO $GAPI_FIXUP"
fi

AC_PATH_PROG(GAPI_CODEGEN, gapi2-codegen, no)
if test "x$GAPI_CODEGEN" = "xno"; then
	AC_MSG_CHECKING(for gapi2_codegen.exe)
	GAPI_CODEGEN=`which gapi2_codegen.exe 2> /dev/null`
	if test "x$GAPI_CODEGEN" = "xno" ; then
		AC_MSG_ERROR(['gapi2-codegen'/'gapi2_codegen.exe' not found.])
	fi
	AC_MSG_RESULT([$GAPI_CODEGEN])
	GAPI_CODEGEN="$MONO $GAPI_CODEGEN"
fi

AC_SUBST(GAPI_PARSER)
AC_SUBST(GAPI_FIXUP)
AC_SUBST(GAPI_CODEGEN)


dnl Check for monodoc
# We check existance only if documentation is wanted
if test "x$enable_monodoc" = "xyes" ; then
	AC_PATH_PROG(MDASSEMBLER, mdassembler, no)
	AC_PATH_PROG(MONODOCER, monodocer, no)
	if test "x$MONODOCER" = "xno" -o "x$MDASSEMBLER" = "xno"; then
		enable_monodoc=no
		doc_sources_dir=
	else
		enable_monodoc=yes
		doc_sources_dir="`pkg-config --variable=sourcesdir monodoc`"
	fi
else
	MDASSEMBLER=
	MONODOCER=
fi

AM_CONDITIONAL(ENABLE_MONODOC, test "x$enable_monodoc" = "xyes")

AC_SUBST(MDASSEMBLER)
AC_SUBST(MONODOCER)
AC_SUBST(enable_monodoc)


dnl Configuration files
AC_CONFIG_FILES([
	Makefile
	webkit-sharp.spec
	doc/Makefile
	samples/Makefile
	sources/Makefile
	sources/AssemblyInfo.cs
	sources/webkit-sharp-1.0.pc:sources/webkit-sharp.pc.in
	sources/webkit-sharp.dll.config
])
AC_CONFIG_COMMANDS([default],[[ echo timestamp > stamp-h ]],[[]])


dnl Output for user info
AC_OUTPUT

echo ""
echo "Configuration summary"
echo "---------------------"
echo ""
echo "   * Installation prefix: $prefix"
echo "   * compiler: $CSC"
echo "   * Documentation: $enable_monodoc ($MONODOCER)"
echo "   * WebKit version: $webkit_version"
echo ""

