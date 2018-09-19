I: nreset = 0_1
I: reset_done = False
I: reset_performed = False

S1: nreset = 1_1
S1: reset_done = False
S1: reset_performed = False

S2: nreset = 0_1
S2: reset_performed = True
S2: reset_done = True

SD: reset_performed = True
SD: reset_done = False

I -> S1
S1 -> S2

S2 -> SD

SD -> SD