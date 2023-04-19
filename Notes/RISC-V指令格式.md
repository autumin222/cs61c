# RISC-V指令格式

## 储存程序

由于指令和数据都储存在地址中，所以需要一个方法来将数据翻译为指令

按照约定，RISC-V的指令占一个字，即4比特，32位

指令具有六种指令格式（根据划分的**字段**不同）

* **R-Format**: 使用三个寄存器的指令
  –add, xor, mul —arithmetic/logical ops

* **I-Format**: 使用常数或是加载指令
  –addi, lw, jalr, slli

* **S-Format**: 储存指令

* **SB-Format**: 分支控制： beq, bge

* **U-Format**: 大写常数
  –lui, auipc —upper immediate is 20-bits

* **UJ-Format**: 跳跃指令: jal

## R-Format

32位被分为7 + 5 + 5 + 3 + 5 + 7（左高右低）

![](C:\Users\chenkexu\AppData\Roaming\marktext\images\2023-04-09-16-20-02-image.png)

每个字段有对应的名字，同时每个字段都被独立解释为一个无符号数

![](C:\Users\chenkexu\AppData\Roaming\marktext\images\2023-04-09-16-20-24-image.png)

### 字段解释

* opcode：每个格式都有固定的opcode，也就是一共有六个opcode

* funct7，3：描述操作的类型（分别为7，3）

* rs1，2：源寄存器

* rd：目标寄存器，寄存器的大小都是5

## I-Format

使用尽可能与R格式相似的格式

I类型最多需要使用两个寄存器

![](C:\Users\chenkexu\AppData\Roaming\marktext\images\2023-04-18-19-09-36-image.png)

* 只有imm字段与R格式不同

* `rs2`以及`func7`被替换成了12位的符号立即数`imm[11:0]`

由于所有的计算都是基于字的，所以计算之前必须先将12位的符号立即数拓展为32位
