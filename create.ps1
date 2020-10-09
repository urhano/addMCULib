# Remove McuOnEclipseLibrary, if any
# TODO: check if McuOnEclipseLibrary exists
rm -Recurse -Force ./McuOnEclipseLibrary

# Remove McuLib, if any
# TODO: check if McuLib exists
rm -Recurse -Force ./McuLib

# get newest McuLib from github
git clone https://github.com/ErichStyger/McuOnEclipseLibrary --depth=1

# move lib into root Folder
mv ./McuOnEclipseLibrary/lib ./McuLib

# remove git repo
rm -Recurse -Force ./McuOnEclipseLibrary

# remove ARM_CM33 and RISC-V FreeRTOS files
rm -Recurse -Force ./McuLib/FreeRTOS/Source/portable/GCC/ARM_CM33
rm -Recurse -Force ./McuLib/FreeRTOS/Source/portable/GCC/RISC-V

# remove semihost-hardfault.c
rm -Force ./source/semihost_hardfault.c

# include McuLib Paths into Eclipse Project Files
$tmp_paths = '									<listOptionValue builtIn="false" value="&quot;${workspace_loc:/${ProjName}/CMSIS}&quot;"/>'
$paths = '									<listOptionValue builtIn="false" value="&quot;${workspace_loc:/${ProjName}/CMSIS}&quot;"/>
									<listOptionValue builtIn="false" value="../McuLib"/>
									<listOptionValue builtIn="false" value="../McuLib/config"/>
									<listOptionValue builtIn="false" value="../McuLib/config/fonts"/>
									<listOptionValue builtIn="false" value="../McuLib/fonts"/>
									<listOptionValue builtIn="false" value="../McuLib/src"/>
									<listOptionValue builtIn="false" value="../McuLib/FreeRTOS/Source/include"/>
									<listOptionValue builtIn="false" value="../McuLib/FreeRTOS/Source/portable/GCC/ARM_CM4F"/>
									<listOptionValue builtIn="false" value="../McuLib/SEGGER_RTT"/>
									<listOptionValue builtIn="false" value="../McuLib/SEGGER_Sysview"/>
									<listOptionValue builtIn="false" value="../McuLib/TraceRecorder/config"/>
									<listOptionValue builtIn="false" value="../McuLib/TraceRecorder/include"/>
									<listOptionValue builtIn="false" value="../McuLib/TraceRecorder/streamports/Jlink_RTT/include"/>
									<listOptionValue builtIn="false" value="../McuLib/HD44780"/>
									<listOptionValue builtIn="false" value="../McuLib/FatFS"/>
									<listOptionValue builtIn="false" value="../McuLib/FatFS/source"/>'
                  
(Get-Content ./.cproject).replace($tmp_paths, $paths) | Set-Content ./.cproject

# remove "Exclude resource from build"
$tmp_string = '						<entry flags="LOCAL|VALUE_WORKSPACE_PATH|RESOLVED" kind="sourcePath" name="board"/>'
$string = ' 						<entry flags="LOCAL|VALUE_WORKSPACE_PATH|RESOLVED" kind="sourcePath" name="board"/>
 						<entry excluding="FatFS|TraceRecorder|minIni|HDD44780" flags="LOCAL|VALUE_WORKSPACE_PATH|RESOLVED" kind="sourcePath" name="McuLib"/>'

(Get-Content ./.cproject).replace($tmp_string, $string) | Set-Content ./.cproject

# move IncludeConfig.h into source folder
mv ./McuLib/Template_IncludeMcuLibConfig.h ./source/IncludeMcuLibConfig.h

# set -include directive for IncludeConfig.h
$tmp_string = 'superClass="gnu.c.compiler.option.include.files" useByScannerDiscovery="false"/>'
$string = 'superClass="gnu.c.compiler.option.include.files" useByScannerDiscovery="false" valueType="includeFiles">
									<listOptionValue builtIn="false" value="&quot;${ProjDirPath}/source/IncludeMcuLibConfig.h&quot;"/>
								</option>'

(Get-Content ./.cproject).replace($tmp_string, $string) | Set-Content ./.cproject

# Change IncludeMcuLibConfig.h for K22
$tmp_string = '#if 1 /* example configuration for LPC845 */'
$string = '#if 0 /* example configuration for LPC845 */'

(Get-Content ./source/IncludeMcuLibConfig.h).replace($tmp_string, $string) | Set-Content ./source/IncludeMcuLibConfig.h

$tmp_string = '#elif 0 /* example configuration for Kinetis K22 */'
$string = '#elif 1 /* example configuration for Kinetis K22 */'

(Get-Content ./source/IncludeMcuLibConfig.h).replace($tmp_string, $string) | Set-Content ./source/IncludeMcuLibConfig.h
