template <class lhs_bag_t, class rhs_bag_t, class out_bag_t>
void matmul(const lhs_bag_t& lhs, const rhs_bag_t& rhs, out_bag_t& out);

const auto file_layout = /*...*/;

template <class lhs_layout, class rhs_layout, class out_layout>
auto run_matmul(lhs_layout lhs_l, rhs_layout rhs_l, out_layout out_l, const char* lhs_data, const char* rhs_data)
{
    auto lhs = transform2bag(file_layout, lhs_l, lhs_data);
    auto rhs = transform2bag(file_layout, rhs_l, rhs_data);
    auto out = #\noarr{}#::make_bag(out_l);

    matmul(lhs, rhs, out);

    return transform2bag(out_layout, file_layout, out.data());
}