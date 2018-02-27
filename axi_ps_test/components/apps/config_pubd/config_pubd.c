/*
 * Placeholder PetaLinux user application.
 *
 * Replace this with your application code
 */
#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <linux/i2c-dev.h>
#include <fcntl.h>

#define BUF_SIZE 256

int main(int argc, char *argv[])
{
	int fd, i, j, k;
	int dv = 0;
	int send_num;
	int addr  = 0;
	char *i2cdevName = "/dev/i2c-0";
	unsigned char buf[BUF_SIZE] = {0};

	if(argc != 6){
		printf("Invalid argument number\n");
		return -1;
	}

	if((fd = open(i2cdevName, O_RDWR)) < 0){
		fprintf(stderr, "Failed to open port\n");
		return -1;
	}
	
	for(i = 0; argv[1][i] != NULL; i++){
		addr = addr*16 + (int)(argv[1][i] - '0');
	}
	
	buf[0] = 0x00;
	buf[1] = 0x0f;
	for(i = 2, j = 2; i < argc; i++, j = j + 2){
		for(k = 0; argv[i][k] != NULL; k++){
			dv = dv*10 + (int)(argv[i][k] - '0');
		}
		buf[j] = dv & (0xff);
		buf[j + 1] = dv >> 8;
		dv = 0;
	}
	
	if(ioctl(fd, I2C_SLAVE, addr) < 0){
		fprintf(stderr, "Failed to get bus access to talk to slave\n");
		return -1;
	}
	
	if((write(fd, &buf, 10)) < 1){
		printf("fail to send messeage to PUBD\n");
	}else{
		printf("success to send messeage\n");
	}

	close(fd);
	
	return 0;
}


