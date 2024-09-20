CPP=gcc -E
CC=gcc -S
ASM=gcc -c
LD=gcc

OUTDIR=build
OUTCPP=$(OUTDIR)/1cpp
OUTCC=$(OUTDIR)/2cc
OUTASM=$(OUTDIR)/3asm
OUTLD=$(OUTDIR)/4ld

SOURCE=main.c

all: precompile compile assemble link

precompile: main.c hello.c world/world.c
	mkdir -p $(OUTCPP)
	$(CPP) main.c -I world -o $(OUTCPP)/main.i
	$(CPP) hello.c -o $(OUTCPP)/hello.i
	$(CPP) world/world.c -o $(OUTCPP)/world.i

compile: $(OUTCPP)/main.i $(OUTCPP)/hello.i $(OUTCPP)/world.i
	mkdir -p $(OUTCC)
	$(CC) $(OUTCPP)/main.i -o $(OUTCC)/main.s
	$(CC) $(OUTCPP)/hello.i -o $(OUTCC)/hello.s
	$(CC) $(OUTCPP)/world.i -o $(OUTCC)/world.s

assemble: $(OUTCC)/main.s $(OUTCC)/hello.s $(OUTCC)/world.s
	mkdir -p $(OUTASM)
	$(ASM) $(OUTCC)/main.s -o $(OUTASM)/main.o
	$(ASM) $(OUTCC)/hello.s -o $(OUTASM)/hello.o
	$(ASM) $(OUTCC)/world.s -o $(OUTASM)/world.o

link: $(OUTASM)/main.o $(OUTASM)/hello.o $(OUTASM)/world.o
	mkdir -p $(OUTLD)
	$(LD) $(OUTASM)/main.o $(OUTASM)/hello.o $(OUTASM)/world.o -o $(OUTLD)/my_program.exe

clean:
	rm -f $(OUTCPP)/*.i
	rm -f $(OUTCC)/*.s
	rm -f $(OUTASM)/*.o

purge:
	rm -rf $(OUTDIR)/*

.PHONY: all precompile compile assemble link clean purge
