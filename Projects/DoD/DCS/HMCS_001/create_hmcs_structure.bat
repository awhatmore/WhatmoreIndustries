@echo off

echo Creating HMCS_001 program structure...

:: ========== Create Folders ==========
mkdir 00_README
mkdir 01_Development_Record
mkdir 02_Program_Intent_and_Strategy
mkdir 03_Shallow_Demonstration_Package
mkdir 04_Deep_Demonstration_Package
mkdir 05_Test_and_Validation
mkdir 06_Legal_and_Rights
mkdir 07_Implementation_and_Integration
mkdir 08_Human_Factors_and_Safety
mkdir 09_Evidence_Archive
mkdir 10_Narrative_and_Positioning
mkdir 11_Future_Roadmap
mkdir 12_Counter_Suggestion_and_Trajectory_Control
mkdir 13_Controlled_Demonstration_and_Exposure_Protocol

:: ========== Root README ==========
type nul > README.md

:: ========== 00 ==========
type nul > 00_README\README.md

:: ========== 01 ==========
type nul > 01_Development_Record\README.md
type nul > 01_Development_Record\DEVLOG_TEMPLATE.md

:: ========== 02 ==========
type nul > 02_Program_Intent_and_Strategy\README.md
type nul > 02_Program_Intent_and_Strategy\Program_Intent_v0.1.md

:: ========== 03 ==========
type nul > 03_Shallow_Demonstration_Package\README.md
type nul > 03_Shallow_Demonstration_Package\Concept_Brief_v0.1.md
mkdir 03_Shallow_Demonstration_Package\Visuals

:: ========== 04 ==========
type nul > 04_Deep_Demonstration_Package\README.md
type nul > 04_Deep_Demonstration_Package\System_Architecture.md
type nul > 04_Deep_Demonstration_Package\Telemetry_Flow.md
type nul > 04_Deep_Demonstration_Package\Known_Limits.md

:: ========== 05 ==========
type nul > 05_Test_and_Validation\README.md
type nul > 05_Test_and_Validation\Test_Plan_v0.1.md
mkdir 05_Test_and_Validation\Test_Scenarios
mkdir 05_Test_and_Validation\Results

:: ========== 06 ==========
type nul > 06_Legal_and_Rights\README.md
type nul > 06_Legal_and_Rights\Rights_Protection_Plan.md
type nul > 06_Legal_and_Rights\Disclosure_Boundaries.md

:: ========== 07 ==========
type nul > 07_Implementation_and_Integration\README.md
type nul > 07_Implementation_and_Integration\Simulator_Pathway.md
type nul > 07_Implementation_and_Integration\Live_Platform_Concept.md

:: ========== 08 ==========
type nul > 08_Human_Factors_and_Safety\README.md
type nul > 08_Human_Factors_and_Safety\Cognitive_Load_Notes.md
type nul > 08_Human_Factors_and_Safety\Failure_Behavior.md

:: ========== 09 ==========
type nul > 09_Evidence_Archive\README.md
mkdir 09_Evidence_Archive\Videos
mkdir 09_Evidence_Archive\Plots
mkdir 09_Evidence_Archive\Logs

:: ========== 10 ==========
type nul > 10_Narrative_and_Positioning\README.md
type nul > 10_Narrative_and_Positioning\One_Minute_Description.md
type nul > 10_Narrative_and_Positioning\What_This_Is_Not.md

:: ========== 11 ==========
type nul > 11_Future_Roadmap\README.md
type nul > 11_Future_Roadmap\Phase_1_Current.md
type nul > 11_Future_Roadmap\Phase_2_Sensing.md

:: ========== 12 ==========
type nul > 12_Counter_Suggestion_and_Trajectory_Control\README.md
type nul > 12_Counter_Suggestion_and_Trajectory_Control\Counter_Log.md
type nul > 12_Counter_Suggestion_and_Trajectory_Control\Trajectory_Review_Template.md
mkdir 12_Counter_Suggestion_and_Trajectory_Control\Decision_Records

:: ========== 13 ==========
type nul > 13_Controlled_Demonstration_and_Exposure_Protocol\README.md
type nul > 13_Controlled_Demonstration_and_Exposure_Protocol\Exposure_Plan_Log.md
type nul > 13_Controlled_Demonstration_and_Exposure_Protocol\Exposure_Plan_Template.md
mkdir 13_Controlled_Demonstration_and_Exposure_Protocol\Eposure_Records

echo.
echo HMCS_001 program scaffold complete.
pause