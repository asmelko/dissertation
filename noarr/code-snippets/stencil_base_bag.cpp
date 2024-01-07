template <typename bag_t> constexpr void run_stencil_grid(bag_t in, bag_t out) {
    for (size_t x = 1; x < in.get_legth<'x'>() - 1; x++)
        for (size_t y = 1; y < in.get_legth<'y'>() - 1; y++)
            for (size_t z = 1; z < in.get_legth<'z'>() - 1; z++)
                stencil(in, out, x, y, z);
}
