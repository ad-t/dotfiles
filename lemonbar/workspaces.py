#!/usr/bin/env python3

bspwmRawWorkspace = input()

focussed_and_window = u"\u25CF"
not_focussed_and_window = u"\u25CA"
focussed_and_no_window = u"\u25CC"
not_focussed_no_window = u"\u25CB"

splitString = bspwmRawWorkspace.split(':')[1:]
workspaceString = ""

for segment in splitString:
    # windows exist but not focussed
    if segment.startswith("O") or segment.startswith("F"):
        workspaceString += focussed_and_window
    elif segment.startswith("o") or segment.startswith("f"):
        workspaceString += not_focussed_no_window
    else:
        # account for just omitting something without adding more space
        continue
    
    workspaceString += " "

print(workspaceString)