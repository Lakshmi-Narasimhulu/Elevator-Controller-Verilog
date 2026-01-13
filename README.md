**🚀 FSM-Based Elevator Controller using Verilog**
📌 Project Overview

This project implements a 4-floor elevator controller using Verilog HDL.
The system is designed using a Finite State Machine (FSM) approach to manage elevator movement, direction control, door operation, and multi-floor request handling.

The controller supports:

Inside elevator requests

External up and down calls

Automatic direction decision

Request buffering

Safe floor-to-floor movement

This project is intended for VLSI/RTL design practice and was fully verified using a custom Verilog testbench.

🧠 Key Features

✔ FSM-based architecture (IDLE, UP, DOWN, DOOR)

✔ Handles multiple pending requests

✔ Intelligent direction control

✔ Separate request storage register

✔ Synthesizable Verilog design

✔ Fully simulated and verified in Vivado

🏗️ Architecture
🔹 FSM States
State	Description
IDLE	Waiting for requests
UP	Elevator moving upward
DOWN	Elevator moving downward
DOOR	Door open and request cleared

The controller continuously scans for requests above and below the current floor and changes direction dynamically.

⚙️ Inputs & Outputs
Inputs

clk – System clock

reset – Asynchronous reset

inside_request[3:0] – Inside elevator buttons

call_up[3:0] – Up requests from floors

call_down[3:0] – Down requests from floors

Outputs

current_floor[1:0] – Current elevator position

moving_up – Elevator moving up indicator

moving_down – Elevator moving down indicator

door_open – Door status

📂 Project Structure
📦 Elevator-Controller-Verilog
 ┣ 📜 elevator_controller.v   # Main RTL design
 ┣ 📜 elevator_tb.v           # Testbench
 ┣ 📄 README.md               # Project documentation
 ┗ 📷 waveform.png            # Simulation result screenshot

🧪 Verification

The design was verified using a Verilog testbench that applies:

Inside lift requests

External up/down calls

Multiple simultaneous requests

Direction change scenarios

The simulation confirms:

Correct floor movement

Proper door operation

Accurate request servicing

📷 A waveform screenshot is included in this repository.

▶️ How to Run Simulation (Vivado)

Create a new RTL project in Vivado

Add elevator_controller.v as design source

Add elevator_tb.v as simulation source

Set elevator_tb as simulation top

Run Behavioral Simulation

Observe waveform and console output

📈 Applications

Digital system design practice

FSM-based controller modeling

RTL design for VLSI internships

Embedded control logic learning

🧩 Future Improvements

Door open delay counter

Emergency stop feature

Overload detection

Seven-segment floor display

Parameterized number of floors

👨‍💻 Author

P Lakshmi Narasimhulu

VLSI / RTL Design Enthusiast

Focused on Verilog, FSM design, and digital systems
