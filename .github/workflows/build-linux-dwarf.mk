SRC_HC_OPTS               = -O -H1024m
GhcStage1HcOpts           = -O
GhcStage2HcOpts           = -O2 -g3 -fprof-auto
GhcRtsHcOpts              = -O2 -g3
GhcLibHcOpts              = -O2 -g3
BUILD_PROF_LIBS           = YES
DYNAMIC_TOO               = NO
DYNAMIC_GHC_PROGRAMS      = NO
SplitObjs                 = NO
SplitSections             = YES
BUILD_SPHINX_HTML         = YES
BUILD_SPHINX_PDF          = NO
HADDOCK_DOCS              = YES
EXTRA_HADDOCK_OPTS        += --quickjump --hyperlinked-source
STRIP_CMD                 = :
