## 数据通路控制

数据通路是一堆不会轻易改变的硬件，需要对不同的指令输入产生不同作用，因此需要对其中的元件进行控制

* 对于不同的阶段不同的元件，通过不同的控制信号（control bits）进行控制

### 控制指令

根据指令的类型（通过比较opcode，func3），确定每个控制信号（如pc信号，算数逻辑信号）

### 控制信号

对于每个指令，所有控制信号都被设定为可能的值（如果不需要考虑该信号，则设定为*未确定值*，表明该信号不影响该指令执行）

## 流水线

把一个进程的任务按使用的资源划分为小任务，使得一个资源不需要等待整个任务完成后再分配给其他进程，从而提高了资源的使用率

* 不会减少单一进程的时间

* 而是提高了多个任务对资源的使用效率，从而提高多个任务的速度

* 使用不同资源的多个任务可以同时运行

## 流水线数据通路

执行一系列指令时，会使用数据通路内的多个元件，但每个元件的使用都是独立的，

所以多个指令执行时，一个元件完成一个上一条指令的任务后，马上可以开始执行下一条指令的任务

* 一条指令的执行过程中，元件的使用是按时序的

* 多条指令执行时，元件利用率提高，使得多个指令的延迟只差一个元件，近乎同时执行

## 性能分析

处理器表现的**铁律**

`每个程序的时间 = 程序的指令数 * 每个指令的周期 *每个周期的时间`

### 程序指令数

取决于：

* 任务

* 算法

* 编程语言

* 编译器

* 指令集ISA

* 输入

### 指令的时钟周期（平均）

Clock cycles per Instruction，即CPI，取决于

* ISA和处理器实现（微结构）

* 指令的复杂度（如高级语言的高级指令，可能远大于1）

### 时钟周期

频率倒数

* 处理器微结构（关键路径）

* 技术规格

* 功耗

