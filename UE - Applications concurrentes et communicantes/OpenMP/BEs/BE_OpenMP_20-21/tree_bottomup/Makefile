CC       = clang
LINK     = $(CC)

CFLAGS   = -Xpreprocessor -fopenmp $(LIBS)
# CFLAGS   = -g -fopenmp
LDFLAGS  = $(CFLAGS) 
LIBS     = -lomp

OBJS =   main

SOURCES = *.c

main:
	$(LINK) $(LDFLAGS) $(SOURCES) -o $(OBJS)






clean:
	(rm -f *.o main)



%.o: %.c
	$(CC)  $(CFLAGS)  $(CINCLUDES) $(INCLUDES) $(CDEFS) $(PREC) -c $<
%.o: %.f90				       
	$(FC)  $(FCFLAGS) $(FINCLUDES) $(INCLUDES) $(FDEFS) $(DEFINE_PREPEND)$(PREC) -c $<




