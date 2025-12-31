# Automated Color Sorting System (ECE 317 Final Project)

**Repository for the Industrial Robotics Final Project at Miami University.**

## 📖 Project Overview
[cite_start]This project involves the design and programming of an automated sorting system using a **FANUC LR Mate 200iD/4S** industrial robot[cite: 22]. [cite_start]The system autonomously identifies, sorts, and stacks blocks based on their color (Red, Green, Yellow) using 2D vision[cite: 24, 26]. [cite_start]The robot takes three random stacks of mixed-color blocks and reorganizes them into three distinct, color-sorted stacks[cite: 24].

### 👥 Team Members
* [cite_start]David Bartolin [cite: 21]
* [cite_start]Micah Granadino [cite: 21]
* [cite_start]Drew Zabkar [cite: 21]

---

## 🛠️ Hardware & Setup
* [cite_start]**Robot:** FANUC LR Mate 200iD/4S[cite: 22].
* [cite_start]**Vision System:** FANUC iRVision (2D Guidance) utilized for image processing and recognition[cite: 26, 73].
* **Props:**
  * [cite_start]9 Blocks total (3 Red, 3 Green, 3 Yellow)[cite: 24].
  * [cite_start]Blocks were created using Tic-Tac-Toe blocks wrapped in colored construction paper[cite: 36, 37].
  * Dimensions: approx. [cite_start]8.6cm x 8.6cm x 4.5cm[cite: 84, 85].
* [cite_start]**Environment:** A placemat with designated "Tower" (pickup) and "Sort" (drop-off) zones[cite: 39].

---

## 💻 Software & Logic Architecture

[cite_start]The program is structured into a modular design using a main master program and several sub-programs to handle specific tasks like scanning, calculating offsets, and motion execution[cite: 30].

### 1. Main Program: `A_FINAL_PROJECT_BZG.LS`
This is the master loop that controls the overall workflow.
* [cite_start]**Initialization:** Resets user frames, tool frames, and counters (Yellow, Red, Green counts)[cite: 125, 137].
* [cite_start]**Looping Logic:** The robot iterates through a loop 9 times (once for each block), utilizing `R[68:LOOP_COUNT]`[cite: 139, 140].
* [cite_start]**Tier Management:** When the loop count reaches 3 or 6, it calls `A_POS_CHANGE_BZG` to adjust the camera's view offset, ensuring the vision system stays in focus as the stack gets shorter[cite: 141].
* **Sequence:**
  1. [cite_start]Move to tower position (Left, Center, or Right)[cite: 142, 145, 148].
  2. [cite_start]Call **Scan** routine (`A_SCAN_BZG`)[cite: 142].
  3. [cite_start]Call **Place** routine (`A_PLACE_AT_BZG`)[cite: 143].

### 2. Vision Processing: `A_SCAN_BZG.LS`
This sub-program handles image recognition.
* [cite_start]The robot moves the camera over the current stack and sequentially runs vision processes: `FIND 'YELLOW_BLOCK'`, `FIND 'RED_BLOCK'`, and `FIND 'GREEN_BLOCK'`[cite: 7, 12, 18].
* **Logic:** Once a color is found, it updates Register `R[67:BLOCK_BZG]` with a corresponding ID to track the block type:
  * [cite_start]1 = Yellow [cite: 8]
  * [cite_start]2 = Red [cite: 14]
  * [cite_start]3 = Green [cite: 20]

### 3. Pick & Place Logic: `A_PLACE_AT_BZG.LS`
This module handles the physical manipulation and dynamic height calculations.
* **Dynamic Offsets (Pickup):**
  * The program calculates the vertical pick position based on the current iteration rather than fixed points.
  * [cite_start]*Formula:* `R[173:offset] = 40 * R[171:bzg_div]` (where `bzg_div` represents the current tier of the stack)[cite: 187].
* **Sorting Logic:**
  * [cite_start]Uses a `SELECT` statement based on the Color ID (`R[67]`) identified in the scan phase[cite: 191].
  * [cite_start]Routes the robot to the specific "Pre" and "Place" positions for Yellow, Red, or Green stacks[cite: 193, 196, 199].
* **Dynamic Offsets (Place):**
  * Similar to picking, the placement height is calculated dynamically based on how many blocks of that color have already been sorted.
  * [cite_start]*Formula:* `R[173:offset] = 42 * R[174:color offset]`[cite: 203].

---

## ⚙️ Key Features
* [cite_start]**Dynamic PR Offsets:** Heavily relies on Position Register (PR) offsets to calculate stack heights dynamically rather than hard-coding every single point[cite: 27].
* [cite_start]**Singularity Avoidance:** Specific intermediate points (e.g., `P[14:sing temp]`) were used to prevent the robot from entering a singularity configuration during complex moves[cite: 52, 233].
* [cite_start]**Robust Error Handling:** The vision system includes specific exposure settings (e.g., Exposure = 0.8) to distinguish between red and green blocks, which looked similar under the lab lighting[cite: 109].

---

## 🚧 Challenges & Solutions
| Challenge | Solution |
| :--- | :--- |
| **Color Differentiation** | [cite_start]The camera struggled to distinguish Red from Green[cite: 45]. [cite_start]We adjusted the **exposure to 0.8** and tuned the contrast settings (Red: 60, Yellow: 40) to clearly define edges[cite: 109, 116]. |
| **Singularity** | [cite_start]The robot encountered singularity errors when moving linearly between certain points[cite: 52]. [cite_start]We added intermediate points (`sing temp`) to solve this[cite: 52, 197]. |
| **Variable Stack Heights** | Hardcoding points for every block was inefficient. [cite_start]We implemented **Wait commands** and mathematical **Offsets** (multiples of 40mm/42mm) to adjust Z-heights programmatically[cite: 32, 187, 203]. |

---

## 🚀 Future Improvements
* [cite_start]**Expanded Sorting:** Add logic to sort by shape (Square, Circle, Octagon) in addition to color[cite: 80].
* [cite_start]**Scalability:** Increase the number of stacks or block types[cite: 57].
* [cite_start]**Precision:** Improve the alignment precision of the blocks[cite: 59].

---

*This project was completed for ECE 317 at Miami University, Fall 2025.*
