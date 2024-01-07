template <char I, char J, class struct_lhs_t, class struct_rhs_t, class struct_out_t>
__global__ float matmul_tile(const float* lhs_in, const float* rhs_in, float* out, const struct_lhs_t lhs_s, const struct_rhs_t rhs_s, struct_out_t out_s) {
    constexpr size_t tile_w = 16;
    constexpr auto tile_s = #\noarr{}#::array<I, tile_w, #\noarr{}#::array<J, tile_w, #\noarr{}#::scalar<float>>>();
    __shared__ float l_tile[tile_w * tile_w];
    __shared__ float r_tile[tile_w * tile_w];
    const uint32_t x = blockIdx.x * tile_size + threadIdx.x;
    const uint32_t y = blockIdx.y * tile_size + threadIdx.y;

    float acc = 0.f;
    for (uint32_t i = 0; i < lhs_s.get_length<J>(); i += tile_w) {
        tile_s.get_at<I, J>(l_tile, threadIdx.y, threadIdx.x) =
            lhs_s.get_at<I, J>(lhs_data, y, threadIdx.x + i);
        tile_s.get_at<I, J>(r_tile, threadIdx.y, threadIdx.x) =
            rhs_s.get_at<I, J>(rhs_data, threadIdx.y + i, x);
        __syncthreads();

        for (uint32_t j = 0; j < tile_w; j++)
            acc += tile_s.get_at<I, J>(l_tile, threadIdx.y, j)
                   * tile_s.get_at<J, I>(r_tile, threadIdx.x, j);
        __syncthreads();
    }
    out_s.get_at<I, J>(output_data, y, x) = acc;
}