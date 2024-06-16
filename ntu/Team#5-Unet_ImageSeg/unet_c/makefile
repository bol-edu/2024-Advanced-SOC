main.o:main.c func.o imgDataSet.h filter.h
	g++ -o main.o main.c func.o
func.o:func.c func.h
	g++ -c func.c -o func.o

clean:
	rm -f main.o func.o