#include<stdio.h>
#include<Windows.h>

typedef struct person {
	char name[10];
	int age;
	char grade;
}PERSON;

void Writefile(PERSON* p) {
	FILE* stream;

	fprintf(stdout, "name : ");
	fscanf(stdin, "%s", p->name);
	fprintf(stdout, "age : ");
	fscanf(stdin, "%d", &p->age);
	while (getchar() != '\n'); //clear buffer in stdin
	fprintf(stdout, "grade : ");
	fscanf(stdin, "%c", &p->grade);

	stream = fopen("data.txt", "w"); // open data.txt mode write
	fprintf(stream, "%s %d %c", p->name, p->age, p->grade);
	fclose(stream);
}

void Readfile(PERSON *p) {
	FILE* stream;
	stream = fopen("data.txt", "r");

	fscanf(stream, "%s %d %c", p->name, &p->age, &p->grade);


	fclose(stream);
}

void Show(PERSON* p) {
	printf("name : %s \n", p->name);
	printf("age : %d \n", p->age);
	printf("grade : %c \n", p->grade);
}

int main() {
	PERSON p1;
	int sel;

	while (1) {
		system("cls");
		Show(&p1);
		puts("1. penson info changed\n2. person info show");
		fscanf(stdin, "%d", &sel);
		switch (sel) {
		case 1:
			Writefile(&p1);
			break;
		case 2:
			Readfile(&p1);
			break;
		default:
			puts("sel error\n");
			break;

		}
	}

	getch();
	return 0;
}