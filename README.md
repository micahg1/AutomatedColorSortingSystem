# Automated Color Sorting System (ECE 317 Final Project)

**Repository for the Industrial Robotics Final Project at Miami University.**

## 📖 Project Overview
This project involves the design and programming of an automated sorting system using a **FANUC LR Mate 200iD/4S** industrial robot. The system autonomously identifies, sorts, and stacks blocks based on their color (Red, Green, Yellow) using 2D vision. The robot takes three random stacks of mixed-color blocks and reorganizes them into three distinct, color-sorted stacks.

https://github.com/user-attachments/assets/7573adfb-0747-4096-ae5b-82531cf2dd4d

### 👥 Team Members
* David Bartolin
* Micah Granadino
* Drew Zabkar

---

## 🛠️ Hardware & Setup
* **Robot:** FANUC LR Mate 200iD/4S.
* **Vision System:** FANUC iRVision (2D Guidance) utilized for image processing and recognition.
* **Props:**
  * 9 Blocks total (3 Red, 3 Green, 3 Yellow).
  * Blocks were created using Tic-Tac-Toe blocks wrapped in colored construction paper.
  * Dimensions: approx. 8.6cm x 8.6cm x 4.5cm.
* **Environment:** A placemat with designated "Tower" (pickup) and "Sort" (drop-off) zones.

---

## 💻 Software & Logic Architecture

The program is structured into a modular design using a main master program and several sub-programs to handle specific tasks like scanning, calculating offsets, and motion execution.

### 1. Main Program: `A_FINAL_PROJECT_BZG.LS`
This is the master loop that controls the overall workflow.
* **Initialization:** Resets user frames, tool frames, and counters (Yellow, Red, Green counts).
* **Looping Logic:** The robot iterates through a loop 9 times (once for each block), utilizing `R[68:LOOP_COUNT]`.
* **Tier Management:** When the loop count reaches 3 or 6, it calls `A_POS_CHANGE_BZG` to adjust the camera's view offset, ensuring the vision system stays in focus as the stack gets shorter.
* **Sequence:**
  1. Move to tower position (Left, Center, or Right).
  2. Call **Scan** routine (`A_SCAN_BZG`).
  3. Call **Place** routine (`A_PLACE_AT_BZG`).

### 2. Vision Processing: `A_SCAN_BZG.LS`
This sub-program handles image recognition.
* The robot moves the camera over the current stack and sequentially runs vision processes: `FIND 'YELLOW_BLOCK'`, `FIND 'RED_BLOCK'`, and `FIND 'GREEN_BLOCK'`.
* **Logic:** Once a color is found, it updates Register `R[67:BLOCK_BZG]` with a corresponding ID to track the block type:
  * 1 = Yellow
  * 2 = Red
  * 3 = Green

### 3. Pick & Place Logic: `A_PLACE_AT_BZG.LS`
This module handles the physical manipulation and dynamic height calculations.
* **Dynamic Offsets (Pickup):**
  * The program calculates the vertical pick position based on the current iteration rather than fixed points.
  * *Formula:* `R[173:offset] = 40 * R[171:bzg_div]` (where `bzg_div` represents the current tier of the stack).
* **Sorting Logic:**
  * Uses a `SELECT` statement based on the Color ID (`R[67]`) identified in the scan phase.
  * Routes the robot to the specific "Pre" and "Place" positions for Yellow, Red, or Green stacks.
* **Dynamic Offsets (Place):**
  * Similar to picking, the placement height is calculated dynamically based on how many blocks of that color have already been sorted.
  * *Formula:* `R[173:offset] = 42 * R[174:color offset]`.

---

## ⚙️ Key Features
* **Dynamic PR Offsets:** Heavily relies on Position Register (PR) offsets to calculate stack heights dynamically rather than hard-coding every single point.
* **Singularity Avoidance:** Specific intermediate points (e.g., `P[14:sing temp]`) were used to prevent the robot from entering a singularity configuration during complex moves.
* **Robust Error Handling:** The vision system includes specific exposure settings (e.g., Exposure = 0.8) to distinguish between red and green blocks, which looked similar under the lab lighting.

---

## 🚧 Challenges & Solutions
| Challenge | Solution |
| :--- | :--- |
| **Color Differentiation** | The camera struggled to distinguish Red from Green. We adjusted the **exposure to 0.8** and tuned the contrast settings (Red: 60, Yellow: 40) to clearly define edges. |
| **Singularity** | The robot encountered singularity errors when moving linearly between certain points. We added intermediate points (`sing temp`) to solve this. |
| **Variable Stack Heights** | Hardcoding points for every block was inefficient. We implemented **Wait commands** and mathematical **Offsets** (multiples of 40mm/42mm) to adjust Z-heights programmatically. |

---

## 🚀 Future Improvements
* **Expanded Sorting:** Add logic to sort by shape (Square, Circle, Octagon) in addition to color.
* **Scalability:** Increase the number of stacks or block types.
* **Precision:** Improve the alignment precision of the blocks.

---

*This project was completed for ECE 317 at Miami University, Fall 2025.*
