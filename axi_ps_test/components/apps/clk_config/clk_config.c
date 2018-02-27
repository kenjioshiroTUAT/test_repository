/*
 * Placeholder PetaLinux user application.
 *
 * Replace this with your application code
 */
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#include <signal.h>
#include <sys/ioctl.h>
#include <fcntl.h>
int main(int argc, char *argv[])
{
	int fd, div_value;
	printf("input div_value\n");

	scanf("%d", div_value);
	
	if(div_value < 1){
		printf("invalid value\n");
		return -1;
	}	
	
	
	fd = open("/dev/clk_wiz", O_RDWR);
	if(fd < 0){
		printf("failed open clk_wiz device\n");
		return -1;
	}
	ioctl(fd, 1, div_value);
	close(fd);
	return 0;
}


