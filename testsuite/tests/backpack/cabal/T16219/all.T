if config.cleanup:
   cleanup = 'CLEANUP=1'
else:
   cleanup = 'CLEANUP=0'

test('T16219',
     extra_files(['Setup.hs', 'backpack-issue.cabal', 'library-a', 'library-a-impl', 'library-b']),
     run_command,
     ['$MAKE -s --no-print-directory T16219 ' + cleanup])
