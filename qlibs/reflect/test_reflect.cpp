#include "reflect"

enum E { A, B };
struct foo { int a; E b; };

constexpr auto f = foo{.a = 42, .b = B};

// reflect::size
static_assert(2 == reflect::size(f));

// reflect::type_id
static_assert(reflect::type_id(f.a) != reflect::type_id(f.b));

// reflect::type_name
static_assert("foo" == reflect::type_name(f));
static_assert("int" == reflect::type_name(f.a));
static_assert("E" == reflect::type_name(f.b));

// reflect::enum_name
static_assert("B" == reflect::enum_name(f.b));

// reflect::member_name
static_assert("a" == reflect::member_name<0>(f));
static_assert("b" == reflect::member_name<1>(f));

// reflect::get
static_assert(42 == reflect::get<0>(f)); // by index
static_assert(B == reflect::get<1>(f));

static_assert(42 == reflect::get<"a">(f)); // by name
static_assert(B == reflect::get<"b">(f));

// reflect::to
constexpr auto t = reflect::to<std::tuple>(f);
static_assert(42 == std::get<0>(t));
static_assert(B == std::get<1>(t));

int main() {
  // Test that the library works at runtime too
  return 0;
}