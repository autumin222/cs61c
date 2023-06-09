## 访问内存映射I/O

对一部分的内存地址空间划分给I/O，有权限的进程可以进行读写，或是通过系统调用使用这些空间

* 外部设备的**控制和数据寄存器**会对这些位置进行读写

* 每个I/O设备都在这空间里储存了寄存器的副本

## 设备访问方法

各种设备传输的数据量不同

### 轮询

系统每隔一段时间就会扫描设别的状态寄存器，通常有一位标识该设备是否已经做好读/写准备（Ready bit），若以准备好，则处理器会向数据寄存器载入和存储数据

#### 特点

* 轮询需要耗费一点的时间（400 CLK）

* 对于数据量不大的设备，使用轮询不会占用很多CLK如鼠标

* 对于数据量很大的设备（硬盘），每秒需要对数据寄存器读写多次（10^6），使用轮询会占据非常多的CLK，以至于系统无法处理其他工作

轮询**不便于处理大块的数据**，并且浪费了很多处理器资源

### 中断

设备的资源数据已经准备好了，或者有消息需要通知，则会发出一个中断

* 系统接收到中断会停滞当前的进程，并转由系统的异常处理程序来处理     

* 中断代价很大，破坏了缓存，TLB，需要花费时间储存和恢复程序状态

所以中断常用于低速率设备

对于高速率设备，通常只在**开始传输**的时候产生中断，而**传输过程一般使用DMA技术**，即直接内存访问

### DMA直接内存访问

DMA允许设备直接内存读写

通过DMA引擎实现

#### DMA引擎

具有由CPU控制的寄存器，用于控制传输

#### 过程

1. CPU**接收中断**，开始处理传输

2. **向DMA控制器写入**指令（存储地址，数量，控制）

3. DMA**向设备控制器请求**传输

4. 设备开始传输数据

5. 当数据传输完毕后，设备控制器**返回确认**传输完成的信息ACK

6. DMA返回一个**中断**，以**通知CPU**传输已完成


