I: reset_done = False
I: axi_aresetn = 1_1

S1: reset_done = False
S1: axi_aresetn = 0_1

S2: reset_done = False
S2: axi_aresetn = 0_1

S3: reset_done = False
S3: axi_aresetn = 1_1

# extend it an extra state to make sure everything has settled
S4: reset_done = True
S4: axi_aresetn = 1_1

# TRANS
I->S1
S1->S2
S2->S3
S3->S4
S4->S4