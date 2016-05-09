#!/bin/sh

# For Euslisp readline
if [ -z $INSIDE_EMACS ] && [ $TERM != "dumb" ]; then
  alias eusgl='rlwrap eusgl'
  alias irteusgl='rlwrap irteusgl'
  alias roseus='rlwrap roseus'
fi
