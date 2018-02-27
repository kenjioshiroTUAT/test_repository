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

#include <linux/i2c-dev.h>

#define I2CDEV "/dev/i2c-0"
#define SLAVEADDR 0x20

struct timeval tv0, tv1, tv2, tv3;
long time0, time1, time2, time3;
int fd, i2c_fd, clk_wiz_fd;
unsigned int buf[255];
unsigned char data[12];

void sigusr1_handler(int sig){
	gettimeofday(&tv0, NULL);	//time0
	int i, slaveaddr;

	read(fd, buf, 12);
	
	gettimeofday(&tv1, NULL);	//time1
	
	for(i = 0; i < 3; i++){
		data[0 + i*4] = (buf[i] >> 24) & 0xff;
		data[1 + i*4] = (buf[i] >> 16) & 0xff;	
		data[2 + i*4] = (buf[i] >> 8) & 0xff;	
		data[3 + i*4] = buf[i] & 0xff;
	}
	if((data[10] & 0x80) == 0x80){
		//printf("change clk\n");
		//ioctl(clk_wiz_fd, 1, 2);
	}
	
	slaveaddr = data[0];
	ioctl(i2c_fd, I2C_SLAVE, slaveaddr);
	gettimeofday(&tv2, NULL);	//time2

	write(i2c_fd, data, 10);

	gettimeofday(&tv3, NULL);	//time3

	time0 = tv0.tv_sec * 1000000 + tv0.tv_usec;
	time1 = tv1.tv_sec * 1000000 + tv1.tv_usec;
	time2 = tv2.tv_sec * 1000000 + tv2.tv_usec;
	time3 = tv3.tv_sec * 1000000 + tv3.tv_usec;

	for(i = 0; i < 3; i++){	
		printf("buf[%d] = %x\n",i, buf[i]);
	}
	for(i = 0; i < 12; i++){	
		printf("data[%d] = %x\n",i, data[i]);
	}
	
	//printf("signal called\n");
	printf("read time : %ld usec.\n", time1 - time0);
	printf("prepare time : %ld usec.\n", time2 - time1);
	printf("send time : %ld usec.\n", time3 - time2);
}

int main(int argc, char *argv[])
{
	int pid;
	fd_set rfds;
	struct timeval tv;
	int retval;
	
	/*open & ready bram ctl dev*/
	pid = getpid();
	printf("pid : %d\n", pid);

	fd = open("/dev/irq_test", O_RDWR);
	if(fd > 0)
		printf("open irq devices\n");
	/*
	clk_wiz_fd = open("/dev/clk_wiz", O_RDWR);
	if(clk_wiz_fd > 0 )
			printf("open clk devices\n");
	*/
	ioctl(fd, 1, pid);

	/*open & ready i2c-0 dev*/
	i2c_fd = open(I2CDEV, O_RDWR);
	if(i2c_fd < 0){
		fprintf(stderr, "Failed to open port\n");
		return -1;
	}


	/*register signal and signal handler*/
	signal(SIGUSR1, sigusr1_handler);

	FD_ZERO(&rfds);
	//FD_SET(0, &rfds);

	
	while(1){
	printf("before select\n");
	
	retval = select(0, &rfds, NULL, NULL, NULL);

	printf("after select\n");
	}
	if(retval == -1){
		perror("select()");
	}else if(retval){
		printf("receive data\n");
	}else{
		printf("dont receive data\n"); 
	}
	
	close(fd);	
	
	return 0;
}


