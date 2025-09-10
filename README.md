### BrainBolt 2025 - Team Octaknight 

<img width="398" height="680" alt="image" src="https://github.com/user-attachments/assets/7c1e1d58-faf7-4554-926f-f5826269fef5" />

[Problem Statement](https://docs.google.com/document/d/1ikyRfr73T85nkyvhSJF4lqb2LKwG94twzKPiM_E-dpo/edit?tab=t.0)


### This repository contains the simulation of a 7-DOF articulated robotic manipulator with a hierarchical control system. The manipulator is simulated in CoppeliaSim and integrates real-time motor control concepts using ESP32, STM32, and CAN communication.

### Scene Hierarchy
![Scene Hierarchy](https://github.com/user-attachments/assets/087cfeb7-4c3d-41d2-a8d6-0591312f1f74)

### How it Works
<img width="450" height="840" alt="dia" src="https://github.com/user-attachments/assets/7079c657-6a98-4fdd-8312-cbd51df8eba9" />


### Project Overview

Simulation Environment: CoppeliaSim (Open Dynamics Engine).

Manipulator Type: 6-DOF articulated arm with end Effector.

Application: Pick-and-place tasks (similar to warehouse automation).

Control Approach: Three-layer hierarchy:

High-Level (PC / Python GUI): Mission planning, task sequencing, visualization.

Mid-Level (ESP32): Supervisory control, trajectory scheduling, CAN bus coordination.

Low-Level (STM32 FOC): Motor control using Field-Oriented Control (FOC).

### Hardware & Software Stack

ESP32-WROOM: Supervisory controller + communication gateway.

MCP2517FD: External CAN-FD controller (SPI).

STM32F4 (Moteus Controllers): Runs FOC + PI current loops.

AS5047P Encoder: 14-bit magnetic encoder for joint feedback.

BLDC Motors: Three-phase actuators for smooth torque.

CoppeliaSim: Simulation of arm kinematics/dynamics.

Python GUI: Task definition, visualization, and operator control.

Solidworks & Fusion360 : For Designing the robotic arm

Ansys Workbench : CFD Profiling 



