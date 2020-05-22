An Order Book Matlab implementation using ZeroMQ (or rather JeroMQ) for inbound data flow.
For the default settings, the inbound order flow of messages need to be sent as:

1) For Market Data - TCP:127.0.0.1:5550  and  have the following sintax:
    a) Instrument
    b) DataType
    c) Price
    d) Volume
    e) Time
    f) PointValue
    g) TickSize
    h) Bid
    i) Ask

Example:
ES 06-20 Globex; Bid; 2943.75; 4; 5/11/2020 5:00:59 AM; False; 50; 0.25; 2943.75; 2944

2) For Market Depth - TCP:127.0.0.1:5551  and  have the following sintax:
    a) Instrument
    b) DataType
    c) Price
    d) Volume
    e) Time
    f) PointValue
    g) TickSize
    h) Operation
    i) Position

Example:
ES 06-20 Globex; Bid; 2943.25; 50; 5/11/2020 5:01:00 AM; False; 50; 0.25; ; Update; 2


How to make it work:

1) Open aMain_02.mlx and run each section up till, and excluding the last one.
2) Start sending the Level 2 Messages (following the above "contract") through the ZeroMQ library implementation on the Sender side. 

3) You will see the "executionDom" variable getting populated like a real DOM Application, as seen in the _Demo.png picture file.

4) Start playing with it ... 


