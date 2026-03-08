# **ECE317 Automated Color Sorting System**
By David Bartolin, Micah Granadino, and Drew Zabkar

## **High-Level Description**
The goal was to program an industrial robot to autonomously sort and stack mixed blocks by color using 2D vision.

## **Background**
This project uses a FANUC LR Mate 200iD/4S robot and iRVision 2D guidance. The system starts with three random stacks of red, green, and yellow blocks. The robot has to figure out what color each block is, pick it up, and organize them into three separate, color-coded stacks in a drop-off zone. 

## **Design Description**
To implement this, the code was broken down into a main master program and a few sub-programs to handle scanning and movement.

The main loop runs 9 times, once for each block. During each loop, the robot moves over the current stack and runs a vision scan. The camera looks for a yellow, red, or green block and saves a color ID (1, 2, or 3) to a register so the robot knows where it needs to go next. 

Instead of hardcoding every single point for the robot to move to, dynamic position register (PR) offsets were used. The program calculates the pickup and drop-off Z-heights by multiplying the current stack tier by the block height (around 40mm to 42mm). A `SELECT` statement then routes the robot to the correct drop-off zone based on the scanned color ID.

During testing, the robot kept hitting singularity errors on certain paths, so an intermediate temporary waypoint was added to keep the arm out of singularity. The camera also had trouble telling red and green apart under the lab lights, which was fixed by dropping the camera exposure to 0.8 and adjusting the contrast.

## **Presentation of Results**
[Demonstration Link](https://github.com/user-attachments/assets/7573adfb-0747-4096-ae5b-82531cf2dd4d)

## **Conclusion**
The automated sorting system was successfully programmed and deployed. By using dynamic offsets and tuning the vision camera settings, we were able to complete the final project using the skills and equipment from the ECE317 labs.

## **Citations**
* FANUC LR Mate 200iD/4S and iRVision systems provided by the ECE317 lab
