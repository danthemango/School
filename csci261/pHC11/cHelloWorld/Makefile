# Makefile to drive cew testing of asm code using gdb
# P Walsh Feb 2001

# Targets
#   interactive --- assemble program under test and load into gdb
#   bats --- make batch tester from bats.script
#   clean
#   submit -- submit assignment code

# source file
SRC=foolib

# directory where scripts are located and temp files
SD=CewDir

# code beautifier 
INDENT=cat

# version of awk
AWK=awk 

# extra debugger flags
XDBF=-batch -x

# tools 
AS=m68hc11-as
CC=m68hc11-gcc
LD=m68hc11-ld
GDB=m68hc11-gdb
OC=m68hc11-objcopy


interactive: main.elf
	$(GDB) main.elf

bats.gdb: bats.script
	rm -f $(SD)/tmp/bats.gdb
	perl $(SD)/bin/addLineNums.pl bats.script > $(SD)/tmp/bats.num
	m4 -B20000  $(SD)/tmp/bats.num | $(INDENT)  > bats.gdb

clean:
	rm -f *.o *.elf *.gdb *.lst $(SD)/tmp/* *.s19

bats:	main.elf bats.gdb
	$(GDB) $(XDBF) bats.gdb main.elf | $(SD)/bin/filterOutput.pl 

$(SRC).o: $(SRC).s
	$(AS)   -a=$(SRC).lst --gstabs -o $(SRC).o $(SRC).s

main.s: main.c
	$(CC) -S -Os -fomit-frame-pointer -mshort main.c

main.o: main.s
	$(AS)   -a=main.lst --gstabs -o main.o main.s

main.elf: main.o $(SRC).o
	$(LD)  -O0 --verbose -N -mshort -mm68hc11elfb main.o $(SRC).o -o main.elf
	$(OC) -O srec --only-section=.text main.elf main.s19

submit:
	@echo "Nothing to submit"
