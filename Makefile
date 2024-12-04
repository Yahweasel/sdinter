CXX=clang++
OFLAGS=-O3
SD=./stable-diffusion.cpp
SDB=$(SD)/build
CXXFLAGS=$(OFLAGS) \
	-I$(SD) -I$(SD)/ggml/include -I$(SD)/thirdparty \
	-L/opt/rocm/llvm/lib \
	-L/opt/rocm/lib

all: sdinter

sdinter: sdinter.o
	$(CXX) $(CXXFLAGS) -o $@ $< $(SDB)/libstable-diffusion.a $(SDB)/ggml/src/libggml.a \
		-lomp -lhipblas -lrocblas -lamdhip64

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f sdinter.o sdinter
