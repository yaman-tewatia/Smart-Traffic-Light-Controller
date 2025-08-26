
## 1. Introduction

The Adaptive Traffic Light Controller is a Verilog-based smart traffic management system designed to improve road safety and traffic efficiency. It prioritizes emergency vehicles, pedestrian requests, and vehicle presence dynamically using a finite state machine (FSM). The controller ensures smooth state transitions and minimal waiting time by latching inputs and applying predefined priority rules.

### Key Highlights
 - #### Priority Handling
   - Emergency Vehicles have the highest priority (North → South → East → West).
   - Pedestrian Request has the second highest priority.
   - Car Presence (North → South → East → West) is served only if no higher-priority requests exist.
 - #### Latched Inputs
   - All requests (emergency, pedestrian, car) are stored in pending registers.
   - Ensures that no request is lost while another request is being served.  
 - ####  Counters for Timing Control
   - Green Light → 8 clock cycles.
   - Yellow Light → 4 clock cycles.
   - Pedestrian Mode → 5 clock cycles.
## 2. State Transition Diagram
   - States include IDLE, PED, N_GREEN, N_YELLOW, S_GREEN, S_YELLOW, E_GREEN, E_YELLOW, W_GREEN, W_YELLOW.
   - State transitions are determined by request priority and active counters.
  ### - View the [State Transition Diagram](https://github.com/yaman-tewatia/Smart-Traffic-Light-Controller/blob/main/state_transition_diagram.svg) for this project.

## 3. Code   
### - View the [Main code](https://github.com/yaman-tewatia/Smart-Traffic-Light-Controller/blob/main/adaptive_traffic_light_controller/traffic_light_controller.v) for this project.

### - View the [Testbench code](https://github.com/yaman-tewatia/Smart-Traffic-Light-Controller/blob/main/testbench/testbench.v) for this project.

## 4. RTL Schematic
### - View the [RTL Schematic](https://github.com/yaman-tewatia/Smart-Traffic-Light-Controller/blob/main/RTL_schematic.png) for this project.


## 5. Waveform
### - View the [Waveform](https://github.com/yaman-tewatia/Smart-Traffic-Light-Controller/blob/main/waveform.png) for this project.








