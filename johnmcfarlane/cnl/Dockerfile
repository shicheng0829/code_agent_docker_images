FROM johnmcfarlane/cnl_ci:clang-14-libstdcpp

WORKDIR /app

# Copy the project files
COPY . .

# Install dependencies using Conan
RUN conan config install .github/conan/settings.yml && \
    conan install . --build=missing --profile .github/conan/profiles/linux-clang-14-libstdc++

# Build the project
RUN conan build . --build --configure

# Run tests
CMD ["conan", "build", ".", "--test"]