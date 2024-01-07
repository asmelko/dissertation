template<class T>
struct scalar : contain<> {
	static constexpr size_t size() noexcept { return sizeof(T); }
	static constexpr size_t offset() noexcept { return 0; }
	static constexpr size_t length() noexcept { return 0; }
};