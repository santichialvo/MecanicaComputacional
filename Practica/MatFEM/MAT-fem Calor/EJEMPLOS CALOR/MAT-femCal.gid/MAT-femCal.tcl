# MAT-femCal.tcl  -*- TCL -*-
#---------------------------------------------------------------------------
#This file is written in TCL lenguage 
#For more information about TCL look at: http://www.sunlabs.com/research/tcl/
#
#At least two procs must be in this file:
#
#    InitGIDProject dir - Will be called whenever a project is begun to be used.
#           where dir is the project's directory
#    EndGIDProject - Will be called whenever a project ends to be used.
#
#For more information about GID internals, check the program scripts.
#---------------------------------------------------------------------------


proc MyBitmaps { dir { type "DEFAULT INSIDELEFT"} } {
    global MyBitmapsNames MyBitmapsCommands MyBitmapsHelp MAT-femCal

    set MyBitmapsNames(0) "fix.gif pload.gif uload.gif material.gif \
	    units.gif mesh.gif write.gif"
    set MyBitmapsCommands(0) [list [list -np- GidOpenConditions "Temperature_Constraints"] \
	    [list -np- GidOpenConditions "Punctual_Flux"] \
	    [list -np- GidOpenConditions "Uniform_Flux"] \
	    [list -np- GidOpenMaterials] \
	    [list -np- GidOpenProblemData] \
	    "Meshing generate" \
	    "File WriteCalcFile" ]
    set MyBitmapsHelp(0) { "Assign Temperarure Constrains" "Assign Punctal Flux" \
	    "Assign Uniform Flux" "Assign Material Properties" \
	    "Set Problem Units" "Generate Mesh" "Write MATLAB Input File" }
    
    # prefix values:
    #          Pre        Only active in the preprocessor
    #          Post       Only active in the postprocessor
    #          PrePost    Active Always

    set prefix Pre

    set MAT-femCal(toolbarwin) [CreateOtherBitmaps MyBar "My toolbar" \
	    MyBitmapsNames MyBitmapsCommands \
	    MyBitmapsHelp $dir "MyBitmaps [list $dir]" $type $prefix]
    AddNewToolbar "MAT-femCal bar" ${prefix}MyBarWindowGeom \
	    "MyBitmaps [list $dir]"
}

proc EndMyBitmaps {} {
    global MAT-femCal
    
    ReleaseToolbar "MAT-femCal bar"
    rename MyBitmaps ""
    
    catch { destroy $MAT-femCal(toolbarwin) }
}

proc InitGIDProject { dir } {
    global MenuNames MenuEntries MenuCommands MenuAcceler
    global MenuNamesP MenuEntriesP MenuCommandsP MenuAccelerP

    set num [lsearch $MenuNamesP "View results"]
    if { [GiDVersionCmp 11.0.8] < 0 } {
        WarnWinText [= "This program requires GiD %s or later" 11.0.8]
        return
       }

    Splash $dir

#    foreach i [array names MenuEntriesP $num,*] "unset MenuEntriesP($i)"
#    foreach i [array names MenuCommandsP $num,*] "unset MenuCommandsP($i)"
#    set MenuEntriesP($num) ""
#    set MenuCommandsP($num) "-np- CreatePostProcessMenu %W"

    set ipos [lsearch $MenuNames Help]
    if { $ipos != -1 } {
	set MenuEntries($ipos) [linsert $MenuEntries($ipos) 0 "Help on MAT-femCal"]
	set MenuCommands($ipos) [linsert $MenuCommands($ipos) 0 \
		[list -np- HelpOnMAT-femCal $dir]]
	set MenuAcceler($ipos) [linsert $MenuAcceler($ipos) 0 ""]
	CreateTopMenus
    }
    set ipos [lsearch $MenuNamesP Help]
    if { $ipos != -1 } {
	set MenuEntriesP($ipos) [linsert $MenuEntriesP($ipos) 0 "Help on MAT-femCal"]
	set MenuCommandsP($ipos) [linsert $MenuCommandsP($ipos) 0 \
		[list -np- HelpOnMAT-femCal $dir]]
	set MenuAccelerP($ipos) [linsert $MenuAccelerP($ipos) 0 ""]
    }

    MyBitmaps $dir

    GidChangeDataLabel "Data units" ""
    GidChangeDataLabel "Interval" ""
    GidChangeDataLabel "Conditions" ""
    GidChangeDataLabel "Local Axes" ""
    
    GidAddUserDataOptions "Fixed Termperatures" "GidOpenConditions Temperature_Condition" 2
    GidAddUserDataOptions "Punctual Flux" "GidOpenConditions Punctual_Flux" 3
    GidAddUserDataOptions "Uniform Flux" "GidOpenConditions Uniform_Flux" 4
    GidAddUserDataOptions "Units"         "GidOpenProblemData" 6
    GidAddUserDataOptions "---" "" 7
    
}

proc EndGIDProject {} {
    EndMyBitmaps
}

proc HelpOnMAT-femCal { dir } {

    WarnWin [join [list "To obtain help for MAT-femCal, check the lates news in " \
                        "www.cimne.com/projects/MAT-femCal "]]

}

#  Rutina Modificada para MAT-femCal
#  04 / 9 / 2006
#  Esta rutnia despliega el logo del programa y la version

proc Splash { dir } {
    global GIDDEFAULT

    set VersionNumber "g1.1/P04.09.2K6"

    if { [.gid.central.s disable windows] } { return }

    if { [ winfo exist .splash]} {
	destroy .splash
	update
    }

    toplevel .splash
        
    set im [image create photo -file [ file join $dir MAT-femCal-open.gif]]
    set x [expr [winfo screenwidth .splash]/2-[image width $im]/2]
    set y [expr [winfo screenheight .splash]/2-[image height $im]/2]

    wm geom .splash +$x+$y
    wm transient .splash .gid
    wm overrideredirect .splash 1
    pack [label .splash.l -image $im -relief ridge -bd 2]
    
    label .splash.lv -text $VersionNumber -font "times 7"
    place .splash.lv -x 500 -y 253
    bind .splash <1> "destroy .splash"
    bind .splash <KeyPress> "destroy .splash"
    raise .splash .gid
    grab .splash
    focus .splash
    update

    after 70000 "if { [ winfo exist .splash] } { 
	destroy .splash
    }"
}

