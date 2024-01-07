template <typename... Args> void run_stencil_grid(Args&&... args) {
    for (size_t x = 1; x < size_x - 1; x++)
        for (size_t y = 1; y < size_y - 1; y++)
            for (size_t z = 1; z < size_z - 1; z++)
                stencil(std::forward<Args>(args)..., x, y, z);
}