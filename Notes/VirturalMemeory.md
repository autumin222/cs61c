## 虚拟内存

* 使每个程序认为自己占有很大的内存（多的部分可能存在于硬盘）

* 使得程序运行超过内存大小的程序

* 隐藏了不同硬件的区别

允许操作系统实现共享内存，以及程序之间内存空间的独立性

### 虚拟VS物理

* 对于每个程序都需要一点的内存空间来运行，但每个程序都不知道内存的具体情况，不能恰好将自己的数据放置在空闲的内存空间中

* 所以每个程序都认为自己的内存从零开始，或者说拥有一块独立的内存空间

* 而这些内存空间应该都是由操作系统同一分配和管理的

将虚拟的地址映射到物理地址上去

#### 地址空间

* 虚拟地址
  
  对于单个的程序而言 

* 物理地址
  
  存在于具体的硬件之上，对应用程序隔离

### 内存管理器

对内存空间进行控制，防止一个进程通过真实地址随意访问内存空间（避免访问那些不属于它的空间）

#### 功能

* 将虚拟地址翻译为物理地址

* 保护
  
  * 进程间内存隔离
  
  * 用户程序不能干扰OS
  
  * 单一进程崩溃不会影响其他进程

* 将内存拓展到硬盘
  
  * 在内存和硬盘间交换数据

### 分页内存

为方便在内存和硬盘间传输固定大小的数据块，将物理内存划分为页（page），大小一般为4k

* 对于一个32位的虚拟地址，高位20位标识页号，后12位标识页内偏移（100万页和4k的页大小）

#### 页表

每一个进程都有一个由操作系统管理的页表，储存页号（虚拟/程序需要的）和页框号（物理）的映射关系

* **具有一些控制位**，用于标识状态（列入可写入）

##### 页表的储存位置

页表中一项是32位，即4字节，而虚拟地址可以标识2^20个页号，所以页表最多可以占据$4\times2^{20} = 4MB$

**这对于缓存来说太大了，所以页表储存在内存中**

* 所以每次缓存miss都需要两次内存访问（一次获取页表，一次通过物理地址获取数据）

* 缓存中存放了可能使用频率较高的页表项，以此提高了页表查询的效率

##### 多级页表

如果每个进程都将自己的页表保存在内存中，那么需要的空间太大了

**那些不需要的页表不应该保留**

* 每个进程都有大量未使用的内存（堆和栈之间）

* 所以使用一个顶层页表用来**标识真正有被用到**的页表这样会减少下一级页表的数量（访问时产生页错误）

**增加了内存访问次数**

#### 页错误

当**页表条目无效**或者**页框存在于硬盘中**

##### 存在于硬盘中

1. 页表未满时，**页调入**

2. 否则，**页置换**

##### 条目无效

创建条目，**分配新页**

* **页表已满**则进行**页置换**

页错误实际被操作系统当作异常，在处理页错误时，通常会启动上下文切换，以执行其他进程；当处理结束之后，会重新执行发生异常的指令

#### 地址转换后援缓冲器TLB

也被称作快表

用于加快开销很大的地址转换使用的缓存机制

* 对于TLB，直接储存了虚拟地址和物理地址以及一些控制位（Valid，Dirty……）

* 命中则可以在单周期进行地址转换

* 未命中则开始从内存中取页表查询

##### 设计

* TLB通常拥有32-128个条目，使用全关联
  
  * 每个条目都是一个很大的页的映射，因此更可能产生**冲突未命中**
  
  * 更大的TLB（256-512条目）可能使用4路或8路组关联——以此在单周期完成

* 条目替换——LRU、随机或是**FIFO**
  
  LRU要在单周期实现可能很困难，采取一些近似

* “TLB Reach”——指的是直接从TLB访问的内存量
  
  即$条目数\times页大小$

##### 存在位置

对于处理器发出的一个虚拟地址的读写指令

1. 通过TLB转换为物理地址（hit）

2. 缓存接收物理地址，命中则返回数据，否则在内存中获取

对于TLB未命中的情况，则通过页表查询

##### TLB地址转换

虚拟地址被划分为虚拟页号和页偏移

1. TLB读取时，将虚拟页号划分为TLB Tag和TLB Index用于检索TLB

2. 若命中则返回物理页号PPN

3. 并将PPN和页偏移组合在一起，构成物理地址

而缓存使用物理地址时，又会将地址划分为TIO，进行检索

#### 平均访问时间

因为访问硬盘的时间非常长，所以内存命中率必须很高（99.999%）
