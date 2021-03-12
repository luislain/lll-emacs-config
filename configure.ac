#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([lll-emacs-config], [0.1], [lll@luislain.com])
AM_INIT_AUTOMAKE([-Wall -Werror])
AM_CONDITIONAL(XDG_CONFIG_AM, [ -z $XDG_CONFIG_HOME ])

# Checks for programs.
AC_PROG_AWK
# AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET

# Checks for libraries.
# FIXME: Replace `main' with a function in `-la':
AC_CHECK_LIB([a], [main])

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
