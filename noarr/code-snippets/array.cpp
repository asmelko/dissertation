template<char Dim, size_t L, class T>
struct array : contain<T> {
	constexpr size_t size() const noexcept { 
		return contain<T>::template get<0>().size() * L; 
	}
	constexpr size_t offset(size_t i) const noexcept { 
		return contain<T>::template get<0>().size() * i; 
	}
	static constexpr size_t length() noexcept { return L; }
};