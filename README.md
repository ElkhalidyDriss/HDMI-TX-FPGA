# HDMI-TX-FPGA
## Project Overview
**Description**: A Verilog-based RTL design of an HDMI transmitter design implemented on a  FPGA.<br>
**Purpose**: Interface FPGA with an HDMI display, enabling video data transmission.
## Overview of HDMI 1.3 Signaling and Encoding Specifications

HDMI (High-Definition Multimedia Interface) employs three **TMDS (Transition Minimized Differential Signaling)** data channels and one TMDS clock channel. Each "channel" represents a differential pair of wires. During each cycle of the TMDS clock channel, all three TMDS data channels transmit a 10-bit character. These data channels include a **TMDS encoder/serializer**, which encodes the input data and serializes it for transmission. The figure below illustrates the architecture of an HDMI transmitter.
For additional details, refer to the [HDMI 1.3 Specification](https://www.hdmi.org/specifications/hdmi1_3).
![HDMI Transmitter link architecture.](./Docs/hdmi_architecture_overview.png)

## HDMI Transmitter architecture 
The HDMI transmission system consists of three channels (Channel 0, Channel 1, and Channel 2), each responsible for transmitting different types of data over the HDMI link. 
![HDMI Transmitter.](./Docs/HDMI_TX_architecture.svg)

The data for each channel is encoded using different encoding schemes as follows:

- **Pixel Data (8b/10b encoding)**: This data represents the video content transmitted over HDMI.
- **Auxiliary Data (4b/10b encoding)**: This data supports auxiliary functions like audio or additional information.
- **Control Data (2b/10b encoding)**: This data includes synchronization and control signals like Horizontal Sync (Hsync), Vertical Sync (Vsync), and other control flags.

The parallel data from each encoder is serialized using a serializer before being transmitted over the HDMI interface. The control signals `vde` (Video Data Enable) and `ade` (Auxiliary Data Enable) determine which type of data is being transmitted at any given moment (video data, auxiliary data, or control data).
- **vde (Video Data Enable)**: Indicates that video data should be transmitted on the channel.
- **ade (Auxiliary Data Enable)**: Indicates that auxiliary data should be transmitted on the channel.
| **vde** | **ade** | **Data period** |
|-----|-----|---------------------|
|  0  |  0  | Control Period      |
|  0  |  1  | Auxilary data period|
|  1  |  0  | Video Data period   |
![TMDS channel architecture.](./Docs/TMDS_Channel.svg)

| **Channel** | **Pixel Component** | **Auxiliary Data** | **Control Data** |
|-------------|---------------------|--------------------|------------------|
| **Channel 0** | Blue              | Packet header (e.g., Audio, or extended information) | Hsync, Vsync |
| **Channel 1** | Green (for Channel 1) |  Audio Sample, or extended information | CTL0, CTL1|
| **Channel 2** | Red (for Channel 2) | e.g., Audio Sample, or extended information | CTL2, CTL3|


 



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
