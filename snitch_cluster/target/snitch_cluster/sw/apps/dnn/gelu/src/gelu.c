// Copyright 2020 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// SW testbench for profiling linear kernels in different
// floating point precisions (fp64, fp32, fp16), as well as
// different memory layouts for matrices (transposed/not-transposed)
// Correctness of results are checked automatically

#include "dnn.h"
#include "snrt.h"

#include "data.h"

int main() {
    gelu_l.ifmap = (float*)gelu_ifmap_dram;
    // gelu_l.result = (float*)gelu_ofmap_dram;

    // checksum = (float*)gelu_checksum;

    gelu_layer(&gelu_l);

    // uint32_t error = check_gelu_layer(&linear_l, (float*)linear_checksum);

    return 0;
}