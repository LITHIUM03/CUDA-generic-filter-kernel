# CUDA-generic-filter-kernel
Given a filter defined in main (driver code) will apply the filter using a ROWS X COLUMNS block grid.

Tested on 3x3 filters, such as the summing filter [[1,1,1],[1,1,1],[1,1,1]].

### TODO: 

1. Tweak the position of __syncthreads().

2. Test different filter sizes.
