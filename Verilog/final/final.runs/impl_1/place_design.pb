
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
82default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.112default:default2
00:00:00.112default:default2
2328.1802default:default2
0.0002default:default2
8412default:default2
26922default:defaultZ17-722h px� 
Z
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 7951865a
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.13 ; elapsed = 00:00:00.15 . Memory (MB): peak = 2328.180 ; gain = 0.000 ; free physical = 841 ; free virtual = 26922default:defaulth px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.112default:default2
00:00:00.102default:default2
2328.1802default:default2
0.0002default:default2
8412default:default2
26922default:defaultZ17-722h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
h
SPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 16b4555f9
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:08 ; elapsed = 00:00:04 . Memory (MB): peak = 2328.180 ; gain = 0.000 ; free physical = 781 ; free virtual = 26322default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 1ea5b0e35
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:21 ; elapsed = 00:00:13 . Memory (MB): peak = 2372.078 ; gain = 43.898 ; free physical = 701 ; free virtual = 25522default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 1ea5b0e35
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:21 ; elapsed = 00:00:13 . Memory (MB): peak = 2372.078 ; gain = 43.898 ; free physical = 701 ; free virtual = 25522default:defaulth px� 
I
4Phase 1 Placer Initialization | Checksum: 1ea5b0e35
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:22 ; elapsed = 00:00:13 . Memory (MB): peak = 2372.078 ; gain = 43.898 ; free physical = 701 ; free virtual = 25522default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
2.1 2default:default2!
Floorplanning2default:defaultZ18-101h px� 
C
.Phase 2.1 Floorplanning | Checksum: 24f5d94d0
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:23 ; elapsed = 00:00:13 . Memory (MB): peak = 2513.871 ; gain = 185.691 ; free physical = 680 ; free virtual = 25322default:defaulth px� 


Phase %s%s
101*constraints2
2.2 2default:default20
Physical Synthesis In Placer2default:defaultZ18-101h px� 
K
)No high fanout nets found in the design.
65*physynthZ32-65h px� 
�
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.112default:default2
00:00:00.112default:default2
2521.8752default:default2
0.0002default:default2
6652default:default2
25162default:defaultZ17-722h px� 
B
-
Summary of Physical Synthesis Optimizations
*commonh px� 
B
-============================================
*commonh px� 


*commonh px� 


*commonh px� 
�
~-----------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Optimization       |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
-----------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Very High Fanout   |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total              |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
-----------------------------------------------------------------------------------------------------------------------------
*commonh px� 


*commonh px� 


*commonh px� 
R
=Phase 2.2 Physical Synthesis In Placer | Checksum: 18d682850
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:05 ; elapsed = 00:00:33 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 664 ; free virtual = 25162default:defaulth px� 
D
/Phase 2 Global Placement | Checksum: 19778ffa8
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:10 ; elapsed = 00:00:35 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 668 ; free virtual = 25202default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 19778ffa8
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:11 ; elapsed = 00:00:35 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 668 ; free virtual = 25202default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 1e0ed948b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:19 ; elapsed = 00:00:42 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 647 ; free virtual = 24982default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 24e352841
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:20 ; elapsed = 00:00:42 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 645 ; free virtual = 24972default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 24e352841
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:20 ; elapsed = 00:00:42 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 645 ; free virtual = 24972default:defaulth px� 


Phase %s%s
101*constraints2
3.5 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.5 Small Shape Detail Placement | Checksum: 1106f5eed
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:24 ; elapsed = 00:00:45 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 631 ; free virtual = 24832default:defaulth px� 
u

Phase %s%s
101*constraints2
3.6 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.6 Re-assign LUT pins | Checksum: 1cfa33180
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:25 ; elapsed = 00:00:46 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 633 ; free virtual = 24852default:defaulth px� 
�

Phase %s%s
101*constraints2
3.7 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.7 Pipeline Register Optimization | Checksum: 1cfa33180
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:25 ; elapsed = 00:00:46 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 633 ; free virtual = 24852default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 1cfa33180
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:25 ; elapsed = 00:00:47 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 633 ; free virtual = 24852default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
V
APost Placement Optimization Initialization | Checksum: 1c904a40b
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
�
�BUFG insertion identified %s candidate nets, %s success, %s skipped for placement/routing, %s skipped for timing, %s skipped for netlist change reason.30*	placeflow2
02default:default2
02default:default2
02default:default2
02default:default2
02default:defaultZ46-31h px� 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 1c904a40b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:46 ; elapsed = 00:00:56 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 631 ; free virtual = 24822default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
36.6702default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 1525213b7
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:47 ; elapsed = 00:00:57 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 631 ; free virtual = 24822default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 1525213b7
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:47 ; elapsed = 00:00:57 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 631 ; free virtual = 24822default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 1525213b7
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:48 ; elapsed = 00:00:57 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 631 ; free virtual = 24832default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 1525213b7
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:48 ; elapsed = 00:00:58 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 632 ; free virtual = 24842default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 198647ef1
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:48 ; elapsed = 00:00:58 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 632 ; free virtual = 24842default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 198647ef1
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:48 ; elapsed = 00:00:58 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 632 ; free virtual = 24842default:defaulth px� 
>
)Ending Placer Task | Checksum: 16172de7b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:48 ; elapsed = 00:00:58 . Memory (MB): peak = 2521.875 ; gain = 193.695 ; free physical = 680 ; free virtual = 25322default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
492default:default2
22default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
place_design: 2default:default2
00:01:522default:default2
00:01:002default:default2
2521.8752default:default2
193.6952default:default2
6852default:default2
25362default:defaultZ17-722h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:052default:default2
00:00:022default:default2
2521.8752default:default2
0.0002default:default2
6182default:default2
25212default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2Q
=/home/cz9812/capstone2/final/final.runs/impl_1/top_placed.dcp2default:defaultZ17-1381h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2&
write_checkpoint: 2default:default2
00:00:072default:default2
00:00:052default:default2
2521.8752default:default2
0.0002default:default2
6672default:default2
25302default:defaultZ17-722h px� 
^
%s4*runtcl2B
.Executing : report_io -file top_io_placed.rpt
2default:defaulth px� 
�
�report_io: Time (s): cpu = 00:00:00.14 ; elapsed = 00:00:00.18 . Memory (MB): peak = 2521.875 ; gain = 0.000 ; free physical = 653 ; free virtual = 2515
*commonh px� 
�
%s4*runtcl2r
^Executing : report_utilization -file top_utilization_placed.rpt -pb top_utilization_placed.pb
2default:defaulth px� 
�
�report_utilization: Time (s): cpu = 00:00:00.45 ; elapsed = 00:00:00.52 . Memory (MB): peak = 2521.875 ; gain = 0.000 ; free physical = 664 ; free virtual = 2527
*commonh px� 
{
%s4*runtcl2_
KExecuting : report_control_sets -verbose -file top_control_sets_placed.rpt
2default:defaulth px� 
�
�report_control_sets: Time (s): cpu = 00:00:00.48 ; elapsed = 00:00:00.54 . Memory (MB): peak = 2521.875 ; gain = 0.000 ; free physical = 665 ; free virtual = 2528
*commonh px� 


End Record