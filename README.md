# HDMI-TX-FPGA
## Project Overview
**Description**: A Verilog-based RTL design of an HDMI transmitter design implemented on a  FPGA.
**Purpose**: Interface FPGA with an HDMI display, enabling video data transmission.
## Overview of HDMI 1.3 Signaling and Encoding Specifications**
# **Overview of HDMI 1.3 Signaling and Encoding Specifications**

HDMI (High-Definition Multimedia Interface) employs three **TMDS (Transition Minimized Differential Signaling)** data channels and one TMDS clock channel. Each "channel" represents a differential pair of wires. During each cycle of the TMDS clock channel, all three TMDS data channels transmit a 10-bit character. These data channels include a **TMDS encoder/serializer**, which encodes the input data and serializes it for transmission. The figure below illustrates the architecture of an HDMI transmitter.
-For additional details, refer to the [HDMI 1.3 Specification](https://www.hdmi.org/specifications/hdmi1_3).
![HDMI Transmitter link architecture.](./Docs/hdmi_architecture_overview.png)





## Features
- **Resolution Support**: 640x480p60
- **Color Depth**: 8-bit
- **Pixel Formats**: RGB
- **Audio**: Not yet fully Supported(But TMDS encoder designed to handle  audio data encoding).
- **Compliance**: HDMI 1.3 Compliance
## Directory Structure

## Hardware
- **Board**: Sipeed Tang Nano 9k .
- **FPGA**: Gowin FPGA (model and part number)
## Usage
- **Programming the FPGA**:
## Design Details
- **HDMI Signal Generation**: Description of the TMDS encoding, clock management, and signal generation process
- **Clock Management**: Explanation of clock generation and management for HDMI output signals
- **HDMI Protocol**: Overview of the HDMI protocol implementation (timing, signal encoding, etc.)
## Testing on FPGA
## Future Work
