/*  irq_test.c - The simplest kernel module.
 */
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/io.h>
#include <linux/interrupt.h>

#include <linux/of_address.h>
#include <linux/of_device.h>
#include <linux/of_platform.h>

#include <linux/list.h>

#include <linux/cdev.h>
#include <linux/proc_fs.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#include <linux/time.h>

#include <linux/fs.h>
#include <linux/syscalls.h>

#include <asm/siginfo.h>
#include <linux/sched.h>
#include <linux/pid_namespace.h>
#include <linux/pid.h>
/* Standard module information, edit as appropriate */
MODULE_LICENSE("GPL");
MODULE_AUTHOR
    ("Xilinx Inc.");
MODULE_DESCRIPTION
    ("irq_test - loadable module template generated by petalinux-create -t modules");

#define DRIVER_NAME "irq_test"

/* Simple example of how to receive command line parameters to your module.
   Delete if you don't need them */
unsigned myint = 0xdeadbeef;
char *mystr = "default";

module_param(myint, int, S_IRUGO);
module_param(mystr, charp, S_IRUGO);

struct irq_test_local {
	int irq;
	unsigned long mem_start;
	unsigned long mem_end;
	void __iomem *base_addr;
};

struct timespec get_time(void){
	struct timespec start_time;
	getnstimeofday(&start_time);
	return start_time;
}

long get_time_diff(struct timespec start_time, struct timespec end_time){
	long timestamp;
	timestamp = start_time.tv_sec * 1000000000L + start_time.tv_nsec;
	//printk("start_time = %ld nsec.\n", timestamp);

	timestamp = end_time.tv_sec * 1000000000L + end_time.tv_nsec;
	//printk("end_time = %ld nsec.\n", timestamp);

	return (end_time.tv_nsec - start_time.tv_nsec);
}
/****************************************************/
/*****       		irq function      *****/
/****************************************************/
static struct timespec time0, time1, time2, time3, time4;
static int user_pid;
static struct task_struct *current_task;
static unsigned char tmp_buf[255];

static irqreturn_t irq_test_irq(int irq, void *lp)
{
	time0 = get_time(); //time0
	int i, ret;
	struct irq_test_local *test_lp = (struct irq_test_local*)lp;
	for(i = 0; i < 12; i++){
		tmp_buf[i] = ioread8(test_lp -> base_addr + i);
	}
	
	//time1 = get_time();	//time1

	struct siginfo info;
	memset(&info, 0, sizeof(struct siginfo));
	info.si_signo = 10;
	info.si_code = 0;
	info.si_int = 1234;
	if(current_task == NULL){
		rcu_read_lock();
		current_task = pid_task(find_vpid(user_pid), PIDTYPE_PID);
		rcu_read_unlock();
	}

	ret = send_sig_info(10, &info, current_task);
	if(ret < 0)
		printk("error sending signal\n");
	//time2 = get_time();	//time2
	return IRQ_HANDLED;
}

int irq_test_open(struct inode *inode, struct file *file);
int irq_test_release(struct inode *inode, struct file *file);
int irq_test_ioctl(struct inode *inode, struct file *file, unsigned int cmd, int pid);
ssize_t irq_test_read(struct file *file, char *buff, size_t count, loff_t *offset);
/****************************************************/
/*****       file operations strtuct      *****/
/****************************************************/
static struct file_operations irq_test_fops = {
	.owner = THIS_MODULE,
	.open = irq_test_open,
	.release  = irq_test_release,
	.read = irq_test_read,
	.write  = NULL,
	.mmap = NULL,
	.unlocked_ioctl = irq_test_ioctl,
};
/****************************************************/
/*****        open & close & ioctl        *****/
/****************************************************/

int irq_test_open(struct inode *inode, struct file *file){

	printk("open call\n");
	
	return 0;
}

int irq_test_release(struct inode *inode, struct file *file){
	
	printk("close call\n");
	return 0;	

}

int irq_test_ioctl(struct inode *inode, struct file *file, unsigned int cmd, int pid){
		
	printk("ioctl called\n");
	printk("user pid : %d\n", cmd);
	user_pid = cmd;
	current_task = NULL;
	return 0;

}

/****************************************************/
/*****             read & write           *****/
/****************************************************/
//static unsigned char tmp[255]; 

static long read_time;
static long signal_time;
static long irq_time;

ssize_t irq_test_read(struct file *file, char *buf, size_t count, loff_t *offset){

	if(copy_to_user(buf, tmp_buf, count)){
		printk("copy to user failed.\n");
		return -EFAULT;
	}
	time3 = get_time(); //time3
	
	//irq_time = get_time_diff(time0, time2);
	//printk("read_time : %ld nsec\n", get_time_diff(time0, time1));
	//printk("signal_time : %ld nsec\n", get_time_diff(time1, time2));
	printk("irq_time : %ld nsec\n", get_time_diff(time0, time3));
	//time4 = get_time();
	return count;
}

/****************************************************/
/*****             init & exit            *****/
/****************************************************/


#define MINOR_COUNT 2
#define BASE_ADDR 0x40000000

static dev_t dev_id;
static struct cdev c_dev;

static int init_irq_test(void){
	int ret;
	
	ret = alloc_chrdev_region(&dev_id, 0, MINOR_COUNT, DRIVER_NAME);
	
	if(ret < 0){
		printk(KERN_WARNING, "alloc_chrdev_region failed\n");
		return ret;
	}

	cdev_init(&c_dev, &irq_test_fops);
	c_dev.owner = THIS_MODULE;


	ret = cdev_add(&c_dev, dev_id, MINOR_COUNT);
	printk("add cdev: major %d, minor %d.\n", MAJOR(dev_id), MINOR(dev_id));

	if(ret < 0){
		printk(KERN_WARNING, "cdev_add failed\n");
		return ret;
	}

	return 0;
	
}

static void exit_irq_test(void){
	cdev_del(&c_dev);
	unregister_chrdev_region(dev_id, MINOR_COUNT);
}





static int irq_test_probe(struct platform_device *pdev)
{
	struct resource *r_irq; /* Interrupt resources */
	struct resource *r_mem; /* IO mem resources */
	struct device *dev = &pdev->dev;
	struct irq_test_local *lp = NULL;

	int rc = 0;
	
	dev_info(dev, "Device Tree Probing\n");

	/* Get iospace for the device */
	r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!r_mem) {
		dev_err(dev, "invalid address\n");
		return -ENODEV;
	}
	
	lp = (struct irq_test_local *) kmalloc(sizeof(struct irq_test_local), GFP_KERNEL);
	if (!lp) {
		dev_err(dev, "Cound not allocate irq_test device\n");
		return -ENOMEM;
	}
	
	dev_set_drvdata(dev, lp);
	
	lp->mem_start = r_mem->start;
	lp->mem_end = r_mem->end;

	if (!request_mem_region(lp->mem_start,
				lp->mem_end - lp->mem_start + 1,
				DRIVER_NAME)) {
		dev_err(dev, "Couldn't lock memory region at %p\n",
			(void *)lp->mem_start);
		rc = -EBUSY;
		goto error1;
	}

	lp->base_addr = ioremap(lp->mem_start, lp->mem_end - lp->mem_start + 1);
	if (!lp->base_addr) {
		dev_err(dev, "irq_test: Could not allocate iomem\n");
		rc = -EIO;
		goto error2;
	}

	/* Get IRQ for the device */
	r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
	if (!r_irq) {
		dev_info(dev, "no IRQ found\n");
		dev_info(dev, "irq_test at 0x%08x mapped to 0x%08x\n",
			(unsigned int __force)lp->mem_start,
			(unsigned int __force)lp->base_addr);
		return 0;
	}
	lp->irq = r_irq->start;
	
	rc = request_irq(lp->irq, &irq_test_irq, 0, DRIVER_NAME, lp);
	if (rc) {
		dev_err(dev, "testmodule: Could not allocate interrupt %d.\n",
			lp->irq);
		goto error3;
	}

	dev_info(dev,"irq_test at 0x%08x mapped to 0x%08x, irq=%d\n",
		(unsigned int __force)lp->mem_start,
		(unsigned int __force)lp->base_addr,
		lp->irq);
	return 0;
error3:
	free_irq(lp->irq, lp);
error2:
	release_mem_region(lp->mem_start, lp->mem_end - lp->mem_start + 1);
error1:
	kfree(lp);
	dev_set_drvdata(dev, NULL);
	return rc;
}

static int irq_test_remove(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct irq_test_local *lp = dev_get_drvdata(dev);
	free_irq(lp->irq, lp);
	release_mem_region(lp->mem_start, lp->mem_end - lp->mem_start + 1);
	kfree(lp);
	dev_set_drvdata(dev, NULL);
	return 0;
}

#ifdef CONFIG_OF
static struct of_device_id irq_test_of_match[] = {
	{ .compatible = "xlnx,axi-bram-ctrl-4.0", },
	{ /* end of list */ },
};
MODULE_DEVICE_TABLE(of, irq_test_of_match);
#else
# define irq_test_of_match
#endif


static struct platform_driver irq_test_driver = {
	.driver = {
		.name = DRIVER_NAME,
		.owner = THIS_MODULE,
		.of_match_table	= irq_test_of_match,
	},
	.probe		= irq_test_probe,
	.remove		= irq_test_remove,
};

static int __init irq_test_init(void)
{
	int ret;
	printk("<1>Hello module world.\n");
	printk("<1>Module parameters were (0x%08x) and \"%s\"\n", myint,
	       mystr);
	ret = platform_driver_register(&irq_test_driver);
	init_irq_test();
	return ret;
}


static void __exit irq_test_exit(void)
{
	exit_irq_test();
	platform_driver_unregister(&irq_test_driver);
	printk(KERN_ALERT "Goodbye module world.\n");
}
module_init(irq_test_init);
module_exit(irq_test_exit);
