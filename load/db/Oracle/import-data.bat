@del /f *.bad
@del /f *.log

@sqlldr st_zh/st_zh@ora18                        ^
  data=../../../dataset/adressen/adressen.csv    ^
  table                  = adressen_import       ^
  external_table         = not_used              ^
  field_names            = first_ignore          ^
  characterset           = utf8                  ^
  errors                 = 0                     ^
  silent                 = header,feedback       ^
  optionally_enclosed_by = '\"'

@echo(  58372 Rows expected
