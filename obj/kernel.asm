
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	push   $0x0
        popfq
   4000c:	9d                   	popf
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmp    40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	push   $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	push   $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	push   $0x0
        pushq $32
   40038:	6a 20                	push   $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	push   $0x0
        pushq $48
   4003e:	6a 30                	push   $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	push   $0x0
        pushq $49
   40044:	6a 31                	push   $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	push   $0x0
        pushq $50
   4004a:	6a 32                	push   $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	push   $0x0
        pushq $51
   40050:	6a 33                	push   $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	push   $0x0
        pushq $52
   40056:	6a 34                	push   $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	push   $0x0
        pushq $53
   4005c:	6a 35                	push   $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	push   $0x0
        pushq $54
   40062:	6a 36                	push   $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	push   $0x0
        pushq $55
   40068:	6a 37                	push   $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	push   $0x0
        pushq $56
   4006e:	6a 38                	push   $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	push   $0x0
        pushq $57
   40074:	6a 39                	push   $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	push   $0x0
        pushq $58
   4007a:	6a 3a                	push   $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	push   $0x0
        pushq $59
   40080:	6a 3b                	push   $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	push   $0x0
        pushq $60
   40086:	6a 3c                	push   $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	push   $0x0
        pushq $61
   4008c:	6a 3d                	push   $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	push   $0x0
        pushq $62
   40092:	6a 3e                	push   $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	push   $0x0
        pushq $63
   40098:	6a 3f                	push   $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	push   $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	push   %gs
        pushq %fs
   400a2:	0f a0                	push   %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 f7 06 00 00       	call   407ba <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	pop    %fs
        popq %gs
   400df:	0f a9                	pop    %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 62 15 00 00       	call   416da <hardware_init>
    pageinfo_init();
   40178:	e8 e6 0b 00 00       	call   40d63 <pageinfo_init>
    console_clear();
   4017d:	e8 00 4b 00 00       	call   44c82 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 3a 1a 00 00       	call   41bc6 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 e0 04 00       	mov    $0x4e000,%edi
   4019b:	e8 c8 3b 00 00       	call   43d68 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 e0 04 00 	lea    0x4e000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be e6 4c 04 00       	mov    $0x44ce6,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 56 3c 00 00       	call   43e61 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 1);
   4020f:	be 01 00 00 00       	mov    $0x1,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	call   402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be ed 4c 04 00       	mov    $0x44ced,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 26 3c 00 00       	call   43e61 <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 2);
   4023f:	be 02 00 00 00       	mov    $0x2,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	call   402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be f8 4c 04 00       	mov    $0x44cf8,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 f9 3b 00 00       	call   43e61 <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 3);
   4026c:	be 03 00 00 00       	mov    $0x3,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	call   402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be fd 4c 04 00       	mov    $0x44cfd,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 cc 3b 00 00       	call   43e61 <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 3);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 03 00 00 00       	mov    $0x3,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	call   402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	call   402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 e0 04 00       	mov    $0x4e0f0,%edi
   402d1:	e8 fc 09 00 00       	call   40cd2 <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 4c 1b 00 00       	call   41e57 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 1c 32 00 00       	call   43531 <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 08 4d 04 00       	mov    $0x44d08,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40328:	e8 f8 22 00 00       	call   42625 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 e0 04 00 	lea    0x4e000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 2a 35 00 00       	call   4387f <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 38 4d 04 00       	mov    $0x44d38,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40368:	e8 b8 22 00 00       	call   42625 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 28 35 00 00       	call   438b7 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leave
   403b1:	c3                   	ret

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq
   403e5:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq
   40402:	c6 84 00 21 ef 04 00 	movb   $0x1,0x4ef21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leave
   40425:	c3                   	ret

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf ea 00 00 	mov    0xeacf(%rip),%rax        # 4ef00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 31 35 00 00       	call   4396a <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	ret

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba ea 00 00 	mov    0xeaba(%rip),%rax        # 4ef00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 00 2e 00 00       	call   4324f <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	ret

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b ea 00 00 	mov    0xea9b(%rip),%rax        # 4ef00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 88 37 00 00       	call   43bfc <process_page_alloc>
}
   40474:	c9                   	leave
   40475:	c3                   	ret

0000000000040476 <deallocate_heap>:

int deallocate_heap(proc * p, uintptr_t old_break, uintptr_t new_break)
{
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 70          	sub    $0x70,%rsp
   4047e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   40482:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   40486:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
    // this rounds down for the start of the old_break
    // we need this to know where to start the loop
    uintptr_t start = ROUNDDOWN(old_break, PAGESIZE);
   4048a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4048e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   40492:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40496:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4049c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // we need this to know where to end the loop
    // round up for the end
    uintptr_t end = ROUNDUP(new_break, PAGESIZE);
   404a0:	48 c7 45 e0 00 10 00 	movq   $0x1000,-0x20(%rbp)
   404a7:	00 
   404a8:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   404ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404b0:	48 01 d0             	add    %rdx,%rax
   404b3:	48 83 e8 01          	sub    $0x1,%rax
   404b7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   404bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404bf:	ba 00 00 00 00       	mov    $0x0,%edx
   404c4:	48 f7 75 e0          	divq   -0x20(%rbp)
   404c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404cc:	48 29 d0             	sub    %rdx,%rax
   404cf:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

    // this for loop is to loop through the start to the ned
    // this loop help deallocate memory
    for (uintptr_t i = start; i < end; i = i - PAGESIZE)
   404d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404d7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   404db:	e9 a3 00 00 00       	jmp    40583 <deallocate_heap+0x10d>
    {
        vamapping map = virtual_memory_lookup(p->p_pagetable,i);
   404e0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   404e4:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   404eb:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   404ef:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   404f3:	48 89 ce             	mov    %rcx,%rsi
   404f6:	48 89 c7             	mov    %rax,%rdi
   404f9:	e8 e9 27 00 00       	call   42ce7 <virtual_memory_lookup>
        // if it means -1 or 0 then it means it has been unmapped
        if (map.pn == -1 && map.perm == 0)
   404fe:	8b 45 b8             	mov    -0x48(%rbp),%eax
   40501:	83 f8 ff             	cmp    $0xffffffff,%eax
   40504:	75 07                	jne    4050d <deallocate_heap+0x97>
   40506:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40509:	85 c0                	test   %eax,%eax
   4050b:	74 6e                	je     4057b <deallocate_heap+0x105>

        }
        else
        {
            // this will check if ref count is greater than 0
            if (pageinfo[map.pn].refcount > 0)
   4050d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   40510:	48 98                	cltq
   40512:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40519:	00 
   4051a:	84 c0                	test   %al,%al
   4051c:	7e 2b                	jle    40549 <deallocate_heap+0xd3>
            {
                // if refcount greater than 0 it resets it
                pageinfo[map.pn].refcount = 0;
   4051e:	8b 45 b8             	mov    -0x48(%rbp),%eax
   40521:	48 98                	cltq
   40523:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4052a:	00 
                // once refcount is 0 then it resets the owner
                if (pageinfo[map.pn].refcount == 0)
   4052b:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4052e:	48 98                	cltq
   40530:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40537:	00 
   40538:	84 c0                	test   %al,%al
   4053a:	75 0d                	jne    40549 <deallocate_heap+0xd3>
                {
                    pageinfo[map.pn].owner = PO_FREE;
   4053c:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4053f:	48 98                	cltq
   40541:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   40548:	00 
                }
            }
            // this will unmap and virtual memory map
            if (virtual_memory_map(p->p_pagetable, i, 0, PAGESIZE, 0) > 0)
   40549:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4054d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40554:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40558:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   4055e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40563:	ba 00 00 00 00       	mov    $0x0,%edx
   40568:	48 89 c7             	mov    %rax,%rdi
   4056b:	e8 b4 23 00 00       	call   42924 <virtual_memory_map>
   40570:	85 c0                	test   %eax,%eax
   40572:	7e 07                	jle    4057b <deallocate_heap+0x105>
            {
                return -1;
   40574:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40579:	eb 1b                	jmp    40596 <deallocate_heap+0x120>
    for (uintptr_t i = start; i < end; i = i - PAGESIZE)
   4057b:	48 81 6d f8 00 10 00 	subq   $0x1000,-0x8(%rbp)
   40582:	00 
   40583:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40587:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4058b:	0f 82 4f ff ff ff    	jb     404e0 <deallocate_heap+0x6a>
            }

        }
    }
    return 0;
   40591:	b8 00 00 00 00       	mov    $0x0,%eax

}
   40596:	c9                   	leave
   40597:	c3                   	ret

0000000000040598 <sbrk>:

void* sbrk(proc * p, intptr_t difference) {
   40598:	55                   	push   %rbp
   40599:	48 89 e5             	mov    %rsp,%rbp
   4059c:	48 83 ec 20          	sub    $0x20,%rsp
   405a0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   405a4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    // TODO : Your code here

    // this saves the program break to old_break
    uintptr_t old_break = p->program_break;
   405a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405ac:	48 8b 40 08          	mov    0x8(%rax),%rax
   405b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

    // this wil calculate new break
    uintptr_t new_break = old_break + difference;
   405b4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   405b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405bc:	48 01 d0             	add    %rdx,%rax
   405bf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    // checks if less than heap original break
    if (p->program_break + difference < p->original_break) {
   405c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405c7:	48 8b 50 08          	mov    0x8(%rax),%rdx
   405cb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   405cf:	48 01 c2             	add    %rax,%rdx
   405d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405d6:	48 8b 40 10          	mov    0x10(%rax),%rax
   405da:	48 39 c2             	cmp    %rax,%rdx
   405dd:	73 09                	jae    405e8 <sbrk+0x50>
        return (void*) -1; 
   405df:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   405e6:	eb 4e                	jmp    40636 <sbrk+0x9e>
    }

    //check if new break moves beyond the heap
    if (new_break > (MEMSIZE_VIRTUAL - PAGESIZE))
   405e8:	48 81 7d f0 00 f0 2f 	cmpq   $0x2ff000,-0x10(%rbp)
   405ef:	00 
   405f0:	76 09                	jbe    405fb <sbrk+0x63>
    {
        return (void*) -1; 
   405f2:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   405f9:	eb 3b                	jmp    40636 <sbrk+0x9e>
    }


    if (difference < 0)
   405fb:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40600:	79 24                	jns    40626 <sbrk+0x8e>
    {
        if (deallocate_heap(p, old_break, new_break) != 0)
   40602:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40606:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   4060a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4060e:	48 89 ce             	mov    %rcx,%rsi
   40611:	48 89 c7             	mov    %rax,%rdi
   40614:	e8 5d fe ff ff       	call   40476 <deallocate_heap>
   40619:	85 c0                	test   %eax,%eax
   4061b:	74 09                	je     40626 <sbrk+0x8e>
        {
            return  (void*) -1;
   4061d:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   40624:	eb 10                	jmp    40636 <sbrk+0x9e>
        }
    }

    // updates proram break to new_break
    p->program_break = new_break;
   40626:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4062a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4062e:	48 89 50 08          	mov    %rdx,0x8(%rax)
    // returns the old break
    return (void*) old_break;
   40632:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   40636:	c9                   	leave
   40637:	c3                   	ret

0000000000040638 <brk>:

int brk(proc * p, intptr_t difference)
{
   40638:	55                   	push   %rbp
   40639:	48 89 e5             	mov    %rsp,%rbp
   4063c:	48 83 ec 10          	sub    $0x10,%rsp
   40640:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40644:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    if (sbrk(p, difference) != 0)
   40648:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4064c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40650:	48 89 d6             	mov    %rdx,%rsi
   40653:	48 89 c7             	mov    %rax,%rdi
   40656:	e8 3d ff ff ff       	call   40598 <sbrk>
   4065b:	48 85 c0             	test   %rax,%rax
   4065e:	74 07                	je     40667 <brk+0x2f>
    {
        return -1;
   40660:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40665:	eb 05                	jmp    4066c <brk+0x34>
    }
    else
    {
        return 0;
   40667:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4066c:	c9                   	leave
   4066d:	c3                   	ret

000000000004066e <syscall_mapping>:


void syscall_mapping(proc* p){
   4066e:	55                   	push   %rbp
   4066f:	48 89 e5             	mov    %rsp,%rbp
   40672:	48 83 ec 70          	sub    $0x70,%rsp
   40676:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4067a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4067e:	48 8b 40 48          	mov    0x48(%rax),%rax
   40682:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40686:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4068a:	48 8b 40 40          	mov    0x40(%rax),%rax
   4068e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40692:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40696:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4069d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406a1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406a5:	48 89 ce             	mov    %rcx,%rsi
   406a8:	48 89 c7             	mov    %rax,%rdi
   406ab:	e8 37 26 00 00       	call   42ce7 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   406b0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   406b3:	48 98                	cltq
   406b5:	83 e0 06             	and    $0x6,%eax
   406b8:	48 83 f8 06          	cmp    $0x6,%rax
   406bc:	0f 85 89 00 00 00    	jne    4074b <syscall_mapping+0xdd>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   406c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406c6:	48 83 c0 17          	add    $0x17,%rax
   406ca:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   406ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406d2:	48 c1 e8 0c          	shr    $0xc,%rax
   406d6:	89 c2                	mov    %eax,%edx
   406d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   406dc:	48 c1 e8 0c          	shr    $0xc,%rax
   406e0:	39 c2                	cmp    %eax,%edx
   406e2:	74 2c                	je     40710 <syscall_mapping+0xa2>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   406e4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406e8:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406ef:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   406f3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   406f7:	48 89 ce             	mov    %rcx,%rsi
   406fa:	48 89 c7             	mov    %rax,%rdi
   406fd:	e8 e5 25 00 00       	call   42ce7 <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40702:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40705:	48 98                	cltq
   40707:	83 e0 03             	and    $0x3,%eax
   4070a:	48 83 f8 03          	cmp    $0x3,%rax
   4070e:	75 3e                	jne    4074e <syscall_mapping+0xe0>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40710:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40714:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4071b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4071f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40723:	48 89 ce             	mov    %rcx,%rsi
   40726:	48 89 c7             	mov    %rax,%rdi
   40729:	e8 b9 25 00 00       	call   42ce7 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4072e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40732:	48 89 c1             	mov    %rax,%rcx
   40735:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40739:	ba 18 00 00 00       	mov    $0x18,%edx
   4073e:	48 89 c6             	mov    %rax,%rsi
   40741:	48 89 cf             	mov    %rcx,%rdi
   40744:	e8 21 35 00 00       	call   43c6a <memcpy>
   40749:	eb 04                	jmp    4074f <syscall_mapping+0xe1>
        return;
   4074b:	90                   	nop
   4074c:	eb 01                	jmp    4074f <syscall_mapping+0xe1>
            return; 
   4074e:	90                   	nop
}
   4074f:	c9                   	leave
   40750:	c3                   	ret

0000000000040751 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40751:	55                   	push   %rbp
   40752:	48 89 e5             	mov    %rsp,%rbp
   40755:	48 83 ec 18          	sub    $0x18,%rsp
   40759:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4075d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40761:	48 8b 40 48          	mov    0x48(%rax),%rax
   40765:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40768:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4076c:	75 14                	jne    40782 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4076e:	0f b6 05 8b 58 00 00 	movzbl 0x588b(%rip),%eax        # 46000 <disp_global>
   40775:	84 c0                	test   %al,%al
   40777:	0f 94 c0             	sete   %al
   4077a:	88 05 80 58 00 00    	mov    %al,0x5880(%rip)        # 46000 <disp_global>
   40780:	eb 36                	jmp    407b8 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40782:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40786:	78 2f                	js     407b7 <syscall_mem_tog+0x66>
   40788:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4078c:	7f 29                	jg     407b7 <syscall_mem_tog+0x66>
   4078e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40792:	8b 00                	mov    (%rax),%eax
   40794:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40797:	75 1e                	jne    407b7 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40799:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4079d:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   407a4:	84 c0                	test   %al,%al
   407a6:	0f 94 c0             	sete   %al
   407a9:	89 c2                	mov    %eax,%edx
   407ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407af:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   407b5:	eb 01                	jmp    407b8 <syscall_mem_tog+0x67>
            return;
   407b7:	90                   	nop
    }
}
   407b8:	c9                   	leave
   407b9:	c3                   	ret

00000000000407ba <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   407ba:	55                   	push   %rbp
   407bb:	48 89 e5             	mov    %rsp,%rbp
   407be:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
   407c5:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   407cc:	48 8b 05 2d e7 00 00 	mov    0xe72d(%rip),%rax        # 4ef00 <current>
   407d3:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
   407da:	48 83 c0 18          	add    $0x18,%rax
   407de:	48 89 d6             	mov    %rdx,%rsi
   407e1:	ba 18 00 00 00       	mov    $0x18,%edx
   407e6:	48 89 c7             	mov    %rax,%rdi
   407e9:	48 89 d1             	mov    %rdx,%rcx
   407ec:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   407ef:	48 8b 05 0a 08 01 00 	mov    0x1080a(%rip),%rax        # 51000 <kernel_pagetable>
   407f6:	48 89 c7             	mov    %rax,%rdi
   407f9:	e8 f5 1f 00 00       	call   427f3 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407fe:	8b 05 f8 87 07 00    	mov    0x787f8(%rip),%eax        # b8ffc <cursorpos>
   40804:	89 c7                	mov    %eax,%edi
   40806:	e8 16 17 00 00       	call   41f21 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   4080b:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40812:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40819:	48 83 f8 0e          	cmp    $0xe,%rax
   4081d:	74 14                	je     40833 <exception+0x79>
        && reg->reg_intno != INT_GPF)
   4081f:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40826:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4082d:	48 83 f8 0d          	cmp    $0xd,%rax
   40831:	75 16                	jne    40849 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   40833:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   4083a:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40841:	83 e0 04             	and    $0x4,%eax
   40844:	48 85 c0             	test   %rax,%rax
   40847:	74 1a                	je     40863 <exception+0xa9>
        check_virtual_memory();
   40849:	e8 a4 08 00 00       	call   410f2 <check_virtual_memory>
        if(disp_global){
   4084e:	0f b6 05 ab 57 00 00 	movzbl 0x57ab(%rip),%eax        # 46000 <disp_global>
   40855:	84 c0                	test   %al,%al
   40857:	74 0a                	je     40863 <exception+0xa9>
            memshow_physical();
   40859:	e8 0c 0a 00 00       	call   4126a <memshow_physical>
            memshow_virtual_animate();
   4085e:	e8 2e 0d 00 00       	call   41591 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40863:	e8 9c 1b 00 00       	call   42404 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40868:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   4086f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40876:	48 83 e8 0e          	sub    $0xe,%rax
   4087a:	48 83 f8 2c          	cmp    $0x2c,%rax
   4087e:	0f 87 9d 03 00 00    	ja     40c21 <exception+0x467>
   40884:	48 8b 04 c5 f8 4d 04 	mov    0x44df8(,%rax,8),%rax
   4088b:	00 
   4088c:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   4088e:	48 8b 05 6b e6 00 00 	mov    0xe66b(%rip),%rax        # 4ef00 <current>
   40895:	48 8b 40 48          	mov    0x48(%rax),%rax
   40899:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
                    if((void *)addr == NULL)
   4089d:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   408a2:	75 0f                	jne    408b3 <exception+0xf9>
                        kernel_panic(NULL);
   408a4:	bf 00 00 00 00       	mov    $0x0,%edi
   408a9:	b8 00 00 00 00       	mov    $0x0,%eax
   408ae:	e8 92 1c 00 00       	call   42545 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   408b3:	48 8b 05 46 e6 00 00 	mov    0xe646(%rip),%rax        # 4ef00 <current>
   408ba:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   408c1:	48 8d 85 78 ff ff ff 	lea    -0x88(%rbp),%rax
   408c8:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   408cc:	48 89 ce             	mov    %rcx,%rsi
   408cf:	48 89 c7             	mov    %rax,%rdi
   408d2:	e8 10 24 00 00       	call   42ce7 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   408d7:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   408db:	48 89 c1             	mov    %rax,%rcx
   408de:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   408e5:	ba a0 00 00 00       	mov    $0xa0,%edx
   408ea:	48 89 ce             	mov    %rcx,%rsi
   408ed:	48 89 c7             	mov    %rax,%rdi
   408f0:	e8 75 33 00 00       	call   43c6a <memcpy>
                    kernel_panic(msg);
   408f5:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   408fc:	48 89 c7             	mov    %rax,%rdi
   408ff:	b8 00 00 00 00       	mov    $0x0,%eax
   40904:	e8 3c 1c 00 00       	call   42545 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   40909:	48 8b 05 f0 e5 00 00 	mov    0xe5f0(%rip),%rax        # 4ef00 <current>
   40910:	8b 10                	mov    (%rax),%edx
   40912:	48 8b 05 e7 e5 00 00 	mov    0xe5e7(%rip),%rax        # 4ef00 <current>
   40919:	48 63 d2             	movslq %edx,%rdx
   4091c:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40920:	e9 0e 03 00 00       	jmp    40c33 <exception+0x479>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   40925:	b8 00 00 00 00       	mov    $0x0,%eax
   4092a:	e8 f7 fa ff ff       	call   40426 <syscall_fork>
   4092f:	89 c2                	mov    %eax,%edx
   40931:	48 8b 05 c8 e5 00 00 	mov    0xe5c8(%rip),%rax        # 4ef00 <current>
   40938:	48 63 d2             	movslq %edx,%rdx
   4093b:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   4093f:	e9 ef 02 00 00       	jmp    40c33 <exception+0x479>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40944:	48 8b 05 b5 e5 00 00 	mov    0xe5b5(%rip),%rax        # 4ef00 <current>
   4094b:	48 89 c7             	mov    %rax,%rdi
   4094e:	e8 1b fd ff ff       	call   4066e <syscall_mapping>
                break;
   40953:	e9 db 02 00 00       	jmp    40c33 <exception+0x479>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   40958:	b8 00 00 00 00       	mov    $0x0,%eax
   4095d:	e8 d9 fa ff ff       	call   4043b <syscall_exit>
                schedule();
   40962:	e8 f5 02 00 00       	call   40c5c <schedule>
                break;
   40967:	e9 c7 02 00 00       	jmp    40c33 <exception+0x479>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   4096c:	e8 eb 02 00 00       	call   40c5c <schedule>
                break;                  /* will not be reached */
   40971:	e9 bd 02 00 00       	jmp    40c33 <exception+0x479>

        case INT_SYS_BRK:
            {
                // TODO : Your code here
                // this will get the difference from the rdi register
                intptr_t difference = (intptr_t)current->p_registers.reg_rdi - current->program_break;
   40976:	48 8b 05 83 e5 00 00 	mov    0xe583(%rip),%rax        # 4ef00 <current>
   4097d:	48 8b 50 48          	mov    0x48(%rax),%rdx
   40981:	48 8b 05 78 e5 00 00 	mov    0xe578(%rip),%rax        # 4ef00 <current>
   40988:	48 8b 40 08          	mov    0x8(%rax),%rax
   4098c:	48 29 c2             	sub    %rax,%rdx
   4098f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)

                // does sbrk and calls on result
                void* result = sbrk(current, difference);
   40993:	48 8b 05 66 e5 00 00 	mov    0xe566(%rip),%rax        # 4ef00 <current>
   4099a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4099e:	48 89 d6             	mov    %rdx,%rsi
   409a1:	48 89 c7             	mov    %rax,%rdi
   409a4:	e8 ef fb ff ff       	call   40598 <sbrk>
   409a9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

                // stores that result in rax register
                current->p_registers.reg_rax = (uintptr_t)result;
   409ad:	48 8b 05 4c e5 00 00 	mov    0xe54c(%rip),%rax        # 4ef00 <current>
   409b4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   409b8:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   409bc:	e9 72 02 00 00       	jmp    40c33 <exception+0x479>
        case INT_SYS_SBRK:
            {
                // TODO : Your code here

                // this will get the difference from the rdi register
                intptr_t difference = (intptr_t)current->p_registers.reg_rdi;
   409c1:	48 8b 05 38 e5 00 00 	mov    0xe538(%rip),%rax        # 4ef00 <current>
   409c8:	48 8b 40 48          	mov    0x48(%rax),%rax
   409cc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

                // does sbrk and calls on result
                void* result = sbrk(current, difference);
   409d0:	48 8b 05 29 e5 00 00 	mov    0xe529(%rip),%rax        # 4ef00 <current>
   409d7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   409db:	48 89 d6             	mov    %rdx,%rsi
   409de:	48 89 c7             	mov    %rax,%rdi
   409e1:	e8 b2 fb ff ff       	call   40598 <sbrk>
   409e6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

                // stores that result in rax register
                current->p_registers.reg_rax = (uintptr_t)result;
   409ea:	48 8b 05 0f e5 00 00 	mov    0xe50f(%rip),%rax        # 4ef00 <current>
   409f1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   409f5:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   409f9:	e9 35 02 00 00       	jmp    40c33 <exception+0x479>
            }
    case INT_SYS_PAGE_ALLOC:
        {
        intptr_t addr = reg->reg_rdi;
   409fe:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40a05:	48 8b 40 30          	mov    0x30(%rax),%rax
   40a09:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        syscall_page_alloc(addr);
   40a0d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40a11:	48 89 c7             	mov    %rax,%rdi
   40a14:	e8 39 fa ff ff       	call   40452 <syscall_page_alloc>
        break;
   40a19:	e9 15 02 00 00       	jmp    40c33 <exception+0x479>
        }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40a1e:	48 8b 05 db e4 00 00 	mov    0xe4db(%rip),%rax        # 4ef00 <current>
   40a25:	48 89 c7             	mov    %rax,%rdi
   40a28:	e8 24 fd ff ff       	call   40751 <syscall_mem_tog>
                break;
   40a2d:	e9 01 02 00 00       	jmp    40c33 <exception+0x479>
            }

        case INT_TIMER:
            {
                ++ticks;
   40a32:	8b 05 e8 e8 00 00    	mov    0xe8e8(%rip),%eax        # 4f320 <ticks>
   40a38:	83 c0 01             	add    $0x1,%eax
   40a3b:	89 05 df e8 00 00    	mov    %eax,0xe8df(%rip)        # 4f320 <ticks>
                schedule();
   40a41:	e8 16 02 00 00       	call   40c5c <schedule>
                break;                  /* will not be reached */
   40a46:	e9 e8 01 00 00       	jmp    40c33 <exception+0x479>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40a4b:	0f 20 d0             	mov    %cr2,%rax
   40a4e:	48 89 45 90          	mov    %rax,-0x70(%rbp)
    return val;
   40a52:	48 8b 45 90          	mov    -0x70(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   40a56:	48 89 45 c8          	mov    %rax,-0x38(%rbp)


                // will check if the address is in the heap
                // if in the heap it will run the code inside
                if (addr >= current->original_break && addr < current->program_break) {
   40a5a:	48 8b 05 9f e4 00 00 	mov    0xe49f(%rip),%rax        # 4ef00 <current>
   40a61:	48 8b 40 10          	mov    0x10(%rax),%rax
   40a65:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   40a69:	0f 82 bc 00 00 00    	jb     40b2b <exception+0x371>
   40a6f:	48 8b 05 8a e4 00 00 	mov    0xe48a(%rip),%rax        # 4ef00 <current>
   40a76:	48 8b 40 08          	mov    0x8(%rax),%rax
   40a7a:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   40a7e:	0f 83 a7 00 00 00    	jae    40b2b <exception+0x371>
                    
                    // This will create a new address by rounding up
                    uintptr_t new_address = ROUNDDOWN(addr, PAGESIZE);
   40a84:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40a88:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   40a8c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40a90:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a96:	48 89 45 b8          	mov    %rax,-0x48(%rbp)

                    // use palloc to allocate and free a physical page
                    uintptr_t page = (uintptr_t)palloc(current->p_pid);
   40a9a:	48 8b 05 5f e4 00 00 	mov    0xe45f(%rip),%rax        # 4ef00 <current>
   40aa1:	8b 00                	mov    (%rax),%eax
   40aa3:	89 c7                	mov    %eax,%edi
   40aa5:	e8 8c 26 00 00       	call   43136 <palloc>
   40aaa:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
                    // check if allocated a free page successfully
                    // if allocate successfully 
                    if (page == (uintptr_t)NULL) {
   40aae:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   40ab3:	75 20                	jne    40ad5 <exception+0x31b>
                        //console_printf(CPOS(24, 0), 0x0C00, "Cannot allocate any memory\n");
                        // assigns the p_state to be broken
                        current->p_state = P_BROKEN;
   40ab5:	48 8b 05 44 e4 00 00 	mov    0xe444(%rip),%rax        # 4ef00 <current>
   40abc:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40ac3:	00 00 00 
                        // calls exit syscall_exit
                        syscall_exit();
   40ac6:	b8 00 00 00 00       	mov    $0x0,%eax
   40acb:	e8 6b f9 ff ff       	call   4043b <syscall_exit>
                        break;
   40ad0:	e9 5e 01 00 00       	jmp    40c33 <exception+0x479>
                    }

                    // once goes here that means the page has been allocated successfully

                    // this well then virtually map the address to the new allocated page
                    int r = virtual_memory_map(current->p_pagetable, new_address, page, PAGESIZE, PTE_P | PTE_W | PTE_U);
   40ad5:	48 8b 05 24 e4 00 00 	mov    0xe424(%rip),%rax        # 4ef00 <current>
   40adc:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40ae3:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   40ae7:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
   40aeb:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40af1:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40af6:	48 89 c7             	mov    %rax,%rdi
   40af9:	e8 26 1e 00 00       	call   42924 <virtual_memory_map>
   40afe:	89 45 ac             	mov    %eax,-0x54(%rbp)
                    // this checks if it mapped it sucessfully
                    // if virtual memory mapped it sucessfully
                    if (r != 0) {
   40b01:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   40b05:	0f 84 27 01 00 00    	je     40c32 <exception+0x478>
                        // if goes here that means did not map it sucessfully
                        // calls on p_broken and syscall_exit
                        //console_printf(CPOS(24, 0), 0x0C00, "Could not map the address to the allocated page");
                        current->p_state = P_BROKEN;
   40b0b:	48 8b 05 ee e3 00 00 	mov    0xe3ee(%rip),%rax        # 4ef00 <current>
   40b12:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40b19:	00 00 00 
                        syscall_exit();
   40b1c:	b8 00 00 00 00       	mov    $0x0,%eax
   40b21:	e8 15 f9 ff ff       	call   4043b <syscall_exit>
                        break;
   40b26:	e9 08 01 00 00       	jmp    40c33 <exception+0x479>

                    // This will resume the process
                    break;
                }

                const char* operation = reg->reg_err & PFERR_WRITE
   40b2b:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40b32:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b39:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   40b3c:	48 85 c0             	test   %rax,%rax
   40b3f:	74 07                	je     40b48 <exception+0x38e>
   40b41:	b8 6b 4d 04 00       	mov    $0x44d6b,%eax
   40b46:	eb 05                	jmp    40b4d <exception+0x393>
   40b48:	b8 71 4d 04 00       	mov    $0x44d71,%eax
                const char* operation = reg->reg_err & PFERR_WRITE
   40b4d:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
                const char* problem = reg->reg_err & PFERR_PRESENT
   40b51:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40b58:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b5f:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   40b62:	48 85 c0             	test   %rax,%rax
   40b65:	74 07                	je     40b6e <exception+0x3b4>
   40b67:	b8 76 4d 04 00       	mov    $0x44d76,%eax
   40b6c:	eb 05                	jmp    40b73 <exception+0x3b9>
   40b6e:	b8 89 4d 04 00       	mov    $0x44d89,%eax
                const char* problem = reg->reg_err & PFERR_PRESENT
   40b73:	48 89 45 98          	mov    %rax,-0x68(%rbp)

                if (!(reg->reg_err & PFERR_USER)) {
   40b77:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40b7e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b85:	83 e0 04             	and    $0x4,%eax
   40b88:	48 85 c0             	test   %rax,%rax
   40b8b:	75 2f                	jne    40bbc <exception+0x402>
                    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40b8d:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40b94:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40b9b:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   40b9f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   40ba3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ba7:	49 89 f0             	mov    %rsi,%r8
   40baa:	48 89 c6             	mov    %rax,%rsi
   40bad:	bf 98 4d 04 00       	mov    $0x44d98,%edi
   40bb2:	b8 00 00 00 00       	mov    $0x0,%eax
   40bb7:	e8 89 19 00 00       	call   42545 <kernel_panic>
                            addr, operation, problem, reg->reg_rip);
                }
                console_printf(CPOS(24, 0), 0x0C00,
   40bbc:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40bc3:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                        "Process %d page fault for %p (%s %s, rip=%p)!\n",
                        current->p_pid, addr, operation, problem, reg->reg_rip);
   40bca:	48 8b 05 2f e3 00 00 	mov    0xe32f(%rip),%rax        # 4ef00 <current>
                console_printf(CPOS(24, 0), 0x0C00,
   40bd1:	8b 00                	mov    (%rax),%eax
   40bd3:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   40bd7:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40bdb:	52                   	push   %rdx
   40bdc:	ff 75 98             	push   -0x68(%rbp)
   40bdf:	49 89 f1             	mov    %rsi,%r9
   40be2:	49 89 c8             	mov    %rcx,%r8
   40be5:	89 c1                	mov    %eax,%ecx
   40be7:	ba c8 4d 04 00       	mov    $0x44dc8,%edx
   40bec:	be 00 0c 00 00       	mov    $0xc00,%esi
   40bf1:	bf 80 07 00 00       	mov    $0x780,%edi
   40bf6:	b8 00 00 00 00       	mov    $0x0,%eax
   40bfb:	e8 1f 3f 00 00       	call   44b1f <console_printf>
   40c00:	48 83 c4 10          	add    $0x10,%rsp
                current->p_state = P_BROKEN;
   40c04:	48 8b 05 f5 e2 00 00 	mov    0xe2f5(%rip),%rax        # 4ef00 <current>
   40c0b:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40c12:	00 00 00 
                syscall_exit();
   40c15:	b8 00 00 00 00       	mov    $0x0,%eax
   40c1a:	e8 1c f8 ff ff       	call   4043b <syscall_exit>
                break;
   40c1f:	eb 12                	jmp    40c33 <exception+0x479>
            }



        default:
            default_exception(current);
   40c21:	48 8b 05 d8 e2 00 00 	mov    0xe2d8(%rip),%rax        # 4ef00 <current>
   40c28:	48 89 c7             	mov    %rax,%rdi
   40c2b:	e8 25 1a 00 00       	call   42655 <default_exception>
            break;                  /* will not be reached */
   40c30:	eb 01                	jmp    40c33 <exception+0x479>
                    break;
   40c32:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40c33:	48 8b 05 c6 e2 00 00 	mov    0xe2c6(%rip),%rax        # 4ef00 <current>
   40c3a:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c40:	83 f8 01             	cmp    $0x1,%eax
   40c43:	75 0f                	jne    40c54 <exception+0x49a>
        run(current);
   40c45:	48 8b 05 b4 e2 00 00 	mov    0xe2b4(%rip),%rax        # 4ef00 <current>
   40c4c:	48 89 c7             	mov    %rax,%rdi
   40c4f:	e8 7e 00 00 00       	call   40cd2 <run>
    } else {
        schedule();
   40c54:	e8 03 00 00 00       	call   40c5c <schedule>
    }
}
   40c59:	90                   	nop
   40c5a:	c9                   	leave
   40c5b:	c3                   	ret

0000000000040c5c <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40c5c:	55                   	push   %rbp
   40c5d:	48 89 e5             	mov    %rsp,%rbp
   40c60:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40c64:	48 8b 05 95 e2 00 00 	mov    0xe295(%rip),%rax        # 4ef00 <current>
   40c6b:	8b 00                	mov    (%rax),%eax
   40c6d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40c70:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c73:	8d 50 01             	lea    0x1(%rax),%edx
   40c76:	89 d0                	mov    %edx,%eax
   40c78:	c1 f8 1f             	sar    $0x1f,%eax
   40c7b:	c1 e8 1c             	shr    $0x1c,%eax
   40c7e:	01 c2                	add    %eax,%edx
   40c80:	83 e2 0f             	and    $0xf,%edx
   40c83:	29 c2                	sub    %eax,%edx
   40c85:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40c88:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c8b:	48 63 d0             	movslq %eax,%rdx
   40c8e:	48 89 d0             	mov    %rdx,%rax
   40c91:	48 c1 e0 04          	shl    $0x4,%rax
   40c95:	48 29 d0             	sub    %rdx,%rax
   40c98:	48 c1 e0 04          	shl    $0x4,%rax
   40c9c:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40ca2:	8b 00                	mov    (%rax),%eax
   40ca4:	83 f8 01             	cmp    $0x1,%eax
   40ca7:	75 22                	jne    40ccb <schedule+0x6f>
            run(&processes[pid]);
   40ca9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cac:	48 63 d0             	movslq %eax,%rdx
   40caf:	48 89 d0             	mov    %rdx,%rax
   40cb2:	48 c1 e0 04          	shl    $0x4,%rax
   40cb6:	48 29 d0             	sub    %rdx,%rax
   40cb9:	48 c1 e0 04          	shl    $0x4,%rax
   40cbd:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40cc3:	48 89 c7             	mov    %rax,%rdi
   40cc6:	e8 07 00 00 00       	call   40cd2 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40ccb:	e8 34 17 00 00       	call   42404 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40cd0:	eb 9e                	jmp    40c70 <schedule+0x14>

0000000000040cd2 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40cd2:	55                   	push   %rbp
   40cd3:	48 89 e5             	mov    %rsp,%rbp
   40cd6:	48 83 ec 10          	sub    $0x10,%rsp
   40cda:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ce2:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40ce8:	83 f8 01             	cmp    $0x1,%eax
   40ceb:	74 14                	je     40d01 <run+0x2f>
   40ced:	ba 60 4f 04 00       	mov    $0x44f60,%edx
   40cf2:	be 0b 02 00 00       	mov    $0x20b,%esi
   40cf7:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40cfc:	e8 24 19 00 00       	call   42625 <assert_fail>
    current = p;
   40d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d05:	48 89 05 f4 e1 00 00 	mov    %rax,0xe1f4(%rip)        # 4ef00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40d0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d10:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40d12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d16:	8b 00                	mov    (%rax),%eax
   40d18:	83 c0 02             	add    $0x2,%eax
   40d1b:	48 98                	cltq
   40d1d:	0f b7 84 00 c0 4c 04 	movzwl 0x44cc0(%rax,%rax,1),%eax
   40d24:	00 
    console_printf(CPOS(24, 79),
   40d25:	0f b7 c0             	movzwl %ax,%eax
   40d28:	89 d1                	mov    %edx,%ecx
   40d2a:	ba 79 4f 04 00       	mov    $0x44f79,%edx
   40d2f:	89 c6                	mov    %eax,%esi
   40d31:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40d36:	b8 00 00 00 00       	mov    $0x0,%eax
   40d3b:	e8 df 3d 00 00       	call   44b1f <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40d40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d44:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40d4b:	48 89 c7             	mov    %rax,%rdi
   40d4e:	e8 a0 1a 00 00       	call   427f3 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40d53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d57:	48 83 c0 18          	add    $0x18,%rax
   40d5b:	48 89 c7             	mov    %rax,%rdi
   40d5e:	e8 60 f3 ff ff       	call   400c3 <exception_return>

0000000000040d63 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40d63:	55                   	push   %rbp
   40d64:	48 89 e5             	mov    %rsp,%rbp
   40d67:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d6b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40d72:	00 
   40d73:	e9 81 00 00 00       	jmp    40df9 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40d78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d7c:	48 89 c7             	mov    %rax,%rdi
   40d7f:	e8 0e 0f 00 00       	call   41c92 <physical_memory_isreserved>
   40d84:	85 c0                	test   %eax,%eax
   40d86:	74 09                	je     40d91 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40d88:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40d8f:	eb 2f                	jmp    40dc0 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40d91:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40d98:	00 
   40d99:	76 0b                	jbe    40da6 <pageinfo_init+0x43>
   40d9b:	b8 10 70 05 00       	mov    $0x57010,%eax
   40da0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40da4:	72 0a                	jb     40db0 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40da6:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40dad:	00 
   40dae:	75 09                	jne    40db9 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40db0:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40db7:	eb 07                	jmp    40dc0 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40db9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40dc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dc4:	48 c1 e8 0c          	shr    $0xc,%rax
   40dc8:	89 c1                	mov    %eax,%ecx
   40dca:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40dcd:	89 c2                	mov    %eax,%edx
   40dcf:	48 63 c1             	movslq %ecx,%rax
   40dd2:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40dd9:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40ddd:	0f 95 c2             	setne  %dl
   40de0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40de4:	48 c1 e8 0c          	shr    $0xc,%rax
   40de8:	48 98                	cltq
   40dea:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40df1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40df8:	00 
   40df9:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40e00:	00 
   40e01:	0f 86 71 ff ff ff    	jbe    40d78 <pageinfo_init+0x15>
    }
}
   40e07:	90                   	nop
   40e08:	90                   	nop
   40e09:	c9                   	leave
   40e0a:	c3                   	ret

0000000000040e0b <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40e0b:	55                   	push   %rbp
   40e0c:	48 89 e5             	mov    %rsp,%rbp
   40e0f:	48 83 ec 50          	sub    $0x50,%rsp
   40e13:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40e17:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e1b:	25 ff 0f 00 00       	and    $0xfff,%eax
   40e20:	48 85 c0             	test   %rax,%rax
   40e23:	74 14                	je     40e39 <check_page_table_mappings+0x2e>
   40e25:	ba 80 4f 04 00       	mov    $0x44f80,%edx
   40e2a:	be 39 02 00 00       	mov    $0x239,%esi
   40e2f:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40e34:	e8 ec 17 00 00       	call   42625 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e39:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40e40:	00 
   40e41:	e9 9a 00 00 00       	jmp    40ee0 <check_page_table_mappings+0xd5>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40e46:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40e4a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40e4e:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e52:	48 89 ce             	mov    %rcx,%rsi
   40e55:	48 89 c7             	mov    %rax,%rdi
   40e58:	e8 8a 1e 00 00       	call   42ce7 <virtual_memory_lookup>
        if (vam.pa != va) {
   40e5d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e61:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e65:	74 27                	je     40e8e <check_page_table_mappings+0x83>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40e67:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40e6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e6f:	49 89 d0             	mov    %rdx,%r8
   40e72:	48 89 c1             	mov    %rax,%rcx
   40e75:	ba 9f 4f 04 00       	mov    $0x44f9f,%edx
   40e7a:	be 00 c0 00 00       	mov    $0xc000,%esi
   40e7f:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40e84:	b8 00 00 00 00       	mov    $0x0,%eax
   40e89:	e8 91 3c 00 00       	call   44b1f <console_printf>
        }
        assert(vam.pa == va);
   40e8e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e92:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e96:	74 14                	je     40eac <check_page_table_mappings+0xa1>
   40e98:	ba a9 4f 04 00       	mov    $0x44fa9,%edx
   40e9d:	be 42 02 00 00       	mov    $0x242,%esi
   40ea2:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40ea7:	e8 79 17 00 00       	call   42625 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40eac:	b8 00 60 04 00       	mov    $0x46000,%eax
   40eb1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40eb5:	72 21                	jb     40ed8 <check_page_table_mappings+0xcd>
            assert(vam.perm & PTE_W);
   40eb7:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40eba:	48 98                	cltq
   40ebc:	83 e0 02             	and    $0x2,%eax
   40ebf:	48 85 c0             	test   %rax,%rax
   40ec2:	75 14                	jne    40ed8 <check_page_table_mappings+0xcd>
   40ec4:	ba b6 4f 04 00       	mov    $0x44fb6,%edx
   40ec9:	be 44 02 00 00       	mov    $0x244,%esi
   40ece:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40ed3:	e8 4d 17 00 00       	call   42625 <assert_fail>
         va += PAGESIZE) {
   40ed8:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40edf:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40ee0:	b8 10 70 05 00       	mov    $0x57010,%eax
   40ee5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ee9:	0f 82 57 ff ff ff    	jb     40e46 <check_page_table_mappings+0x3b>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40eef:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40ef6:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40ef7:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40efb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40eff:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f03:	48 89 ce             	mov    %rcx,%rsi
   40f06:	48 89 c7             	mov    %rax,%rdi
   40f09:	e8 d9 1d 00 00       	call   42ce7 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40f0e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40f12:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40f16:	74 14                	je     40f2c <check_page_table_mappings+0x121>
   40f18:	ba c7 4f 04 00       	mov    $0x44fc7,%edx
   40f1d:	be 4b 02 00 00       	mov    $0x24b,%esi
   40f22:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40f27:	e8 f9 16 00 00       	call   42625 <assert_fail>
    assert(vam.perm & PTE_W);
   40f2c:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40f2f:	48 98                	cltq
   40f31:	83 e0 02             	and    $0x2,%eax
   40f34:	48 85 c0             	test   %rax,%rax
   40f37:	75 14                	jne    40f4d <check_page_table_mappings+0x142>
   40f39:	ba b6 4f 04 00       	mov    $0x44fb6,%edx
   40f3e:	be 4c 02 00 00       	mov    $0x24c,%esi
   40f43:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40f48:	e8 d8 16 00 00       	call   42625 <assert_fail>
}
   40f4d:	90                   	nop
   40f4e:	c9                   	leave
   40f4f:	c3                   	ret

0000000000040f50 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40f50:	55                   	push   %rbp
   40f51:	48 89 e5             	mov    %rsp,%rbp
   40f54:	48 83 ec 20          	sub    $0x20,%rsp
   40f58:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f5c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40f5f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40f62:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40f65:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40f6c:	48 8b 05 8d 00 01 00 	mov    0x1008d(%rip),%rax        # 51000 <kernel_pagetable>
   40f73:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40f77:	75 67                	jne    40fe0 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40f79:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40f87:	eb 51                	jmp    40fda <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40f89:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f8c:	48 63 d0             	movslq %eax,%rdx
   40f8f:	48 89 d0             	mov    %rdx,%rax
   40f92:	48 c1 e0 04          	shl    $0x4,%rax
   40f96:	48 29 d0             	sub    %rdx,%rax
   40f99:	48 c1 e0 04          	shl    $0x4,%rax
   40f9d:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40fa3:	8b 00                	mov    (%rax),%eax
   40fa5:	85 c0                	test   %eax,%eax
   40fa7:	74 2d                	je     40fd6 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40fa9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40fac:	48 63 d0             	movslq %eax,%rdx
   40faf:	48 89 d0             	mov    %rdx,%rax
   40fb2:	48 c1 e0 04          	shl    $0x4,%rax
   40fb6:	48 29 d0             	sub    %rdx,%rax
   40fb9:	48 c1 e0 04          	shl    $0x4,%rax
   40fbd:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   40fc3:	48 8b 10             	mov    (%rax),%rdx
   40fc6:	48 8b 05 33 00 01 00 	mov    0x10033(%rip),%rax        # 51000 <kernel_pagetable>
   40fcd:	48 39 c2             	cmp    %rax,%rdx
   40fd0:	75 04                	jne    40fd6 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40fd2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40fd6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40fda:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40fde:	7e a9                	jle    40f89 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40fe0:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40fe3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fe6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fea:	be 00 00 00 00       	mov    $0x0,%esi
   40fef:	48 89 c7             	mov    %rax,%rdi
   40ff2:	e8 03 00 00 00       	call   40ffa <check_page_table_ownership_level>
}
   40ff7:	90                   	nop
   40ff8:	c9                   	leave
   40ff9:	c3                   	ret

0000000000040ffa <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40ffa:	55                   	push   %rbp
   40ffb:	48 89 e5             	mov    %rsp,%rbp
   40ffe:	48 83 ec 30          	sub    $0x30,%rsp
   41002:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41006:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41009:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4100c:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   4100f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41013:	48 c1 e8 0c          	shr    $0xc,%rax
   41017:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   4101c:	7e 14                	jle    41032 <check_page_table_ownership_level+0x38>
   4101e:	ba d8 4f 04 00       	mov    $0x44fd8,%edx
   41023:	be 69 02 00 00       	mov    $0x269,%esi
   41028:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   4102d:	e8 f3 15 00 00       	call   42625 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41032:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41036:	48 c1 e8 0c          	shr    $0xc,%rax
   4103a:	48 98                	cltq
   4103c:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41043:	00 
   41044:	0f be c0             	movsbl %al,%eax
   41047:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   4104a:	74 14                	je     41060 <check_page_table_ownership_level+0x66>
   4104c:	ba f0 4f 04 00       	mov    $0x44ff0,%edx
   41051:	be 6a 02 00 00       	mov    $0x26a,%esi
   41056:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   4105b:	e8 c5 15 00 00       	call   42625 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41060:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41064:	48 c1 e8 0c          	shr    $0xc,%rax
   41068:	48 98                	cltq
   4106a:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41071:	00 
   41072:	0f be c0             	movsbl %al,%eax
   41075:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41078:	74 14                	je     4108e <check_page_table_ownership_level+0x94>
   4107a:	ba 18 50 04 00       	mov    $0x45018,%edx
   4107f:	be 6b 02 00 00       	mov    $0x26b,%esi
   41084:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   41089:	e8 97 15 00 00       	call   42625 <assert_fail>
    if (level < 3) {
   4108e:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41092:	7f 5b                	jg     410ef <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41094:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4109b:	eb 49                	jmp    410e6 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   4109d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410a1:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410a4:	48 63 d2             	movslq %edx,%rdx
   410a7:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   410ab:	48 85 c0             	test   %rax,%rax
   410ae:	74 32                	je     410e2 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   410b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410b4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410b7:	48 63 d2             	movslq %edx,%rdx
   410ba:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   410be:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   410c4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   410c8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   410cb:	8d 70 01             	lea    0x1(%rax),%esi
   410ce:	8b 55 e0             	mov    -0x20(%rbp),%edx
   410d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   410d5:	b9 01 00 00 00       	mov    $0x1,%ecx
   410da:	48 89 c7             	mov    %rax,%rdi
   410dd:	e8 18 ff ff ff       	call   40ffa <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   410e2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   410e6:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   410ed:	7e ae                	jle    4109d <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   410ef:	90                   	nop
   410f0:	c9                   	leave
   410f1:	c3                   	ret

00000000000410f2 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   410f2:	55                   	push   %rbp
   410f3:	48 89 e5             	mov    %rsp,%rbp
   410f6:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   410fa:	8b 05 d8 cf 00 00    	mov    0xcfd8(%rip),%eax        # 4e0d8 <processes+0xd8>
   41100:	85 c0                	test   %eax,%eax
   41102:	74 14                	je     41118 <check_virtual_memory+0x26>
   41104:	ba 48 50 04 00       	mov    $0x45048,%edx
   41109:	be 7e 02 00 00       	mov    $0x27e,%esi
   4110e:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   41113:	e8 0d 15 00 00       	call   42625 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41118:	48 8b 05 e1 fe 00 00 	mov    0xfee1(%rip),%rax        # 51000 <kernel_pagetable>
   4111f:	48 89 c7             	mov    %rax,%rdi
   41122:	e8 e4 fc ff ff       	call   40e0b <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41127:	48 8b 05 d2 fe 00 00 	mov    0xfed2(%rip),%rax        # 51000 <kernel_pagetable>
   4112e:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41133:	48 89 c7             	mov    %rax,%rdi
   41136:	e8 15 fe ff ff       	call   40f50 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4113b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41142:	e9 9c 00 00 00       	jmp    411e3 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   41147:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4114a:	48 63 d0             	movslq %eax,%rdx
   4114d:	48 89 d0             	mov    %rdx,%rax
   41150:	48 c1 e0 04          	shl    $0x4,%rax
   41154:	48 29 d0             	sub    %rdx,%rax
   41157:	48 c1 e0 04          	shl    $0x4,%rax
   4115b:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41161:	8b 00                	mov    (%rax),%eax
   41163:	85 c0                	test   %eax,%eax
   41165:	74 78                	je     411df <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41167:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4116a:	48 63 d0             	movslq %eax,%rdx
   4116d:	48 89 d0             	mov    %rdx,%rax
   41170:	48 c1 e0 04          	shl    $0x4,%rax
   41174:	48 29 d0             	sub    %rdx,%rax
   41177:	48 c1 e0 04          	shl    $0x4,%rax
   4117b:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   41181:	48 8b 10             	mov    (%rax),%rdx
   41184:	48 8b 05 75 fe 00 00 	mov    0xfe75(%rip),%rax        # 51000 <kernel_pagetable>
   4118b:	48 39 c2             	cmp    %rax,%rdx
   4118e:	74 4f                	je     411df <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41190:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41193:	48 63 d0             	movslq %eax,%rdx
   41196:	48 89 d0             	mov    %rdx,%rax
   41199:	48 c1 e0 04          	shl    $0x4,%rax
   4119d:	48 29 d0             	sub    %rdx,%rax
   411a0:	48 c1 e0 04          	shl    $0x4,%rax
   411a4:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   411aa:	48 8b 00             	mov    (%rax),%rax
   411ad:	48 89 c7             	mov    %rax,%rdi
   411b0:	e8 56 fc ff ff       	call   40e0b <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   411b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411b8:	48 63 d0             	movslq %eax,%rdx
   411bb:	48 89 d0             	mov    %rdx,%rax
   411be:	48 c1 e0 04          	shl    $0x4,%rax
   411c2:	48 29 d0             	sub    %rdx,%rax
   411c5:	48 c1 e0 04          	shl    $0x4,%rax
   411c9:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   411cf:	48 8b 00             	mov    (%rax),%rax
   411d2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411d5:	89 d6                	mov    %edx,%esi
   411d7:	48 89 c7             	mov    %rax,%rdi
   411da:	e8 71 fd ff ff       	call   40f50 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   411df:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411e3:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   411e7:	0f 8e 5a ff ff ff    	jle    41147 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411ed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   411f4:	eb 67                	jmp    4125d <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   411f6:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411f9:	48 98                	cltq
   411fb:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41202:	00 
   41203:	84 c0                	test   %al,%al
   41205:	7e 52                	jle    41259 <check_virtual_memory+0x167>
   41207:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4120a:	48 98                	cltq
   4120c:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41213:	00 
   41214:	84 c0                	test   %al,%al
   41216:	78 41                	js     41259 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41218:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4121b:	48 98                	cltq
   4121d:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41224:	00 
   41225:	0f be c0             	movsbl %al,%eax
   41228:	48 63 d0             	movslq %eax,%rdx
   4122b:	48 89 d0             	mov    %rdx,%rax
   4122e:	48 c1 e0 04          	shl    $0x4,%rax
   41232:	48 29 d0             	sub    %rdx,%rax
   41235:	48 c1 e0 04          	shl    $0x4,%rax
   41239:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   4123f:	8b 00                	mov    (%rax),%eax
   41241:	85 c0                	test   %eax,%eax
   41243:	75 14                	jne    41259 <check_virtual_memory+0x167>
   41245:	ba 68 50 04 00       	mov    $0x45068,%edx
   4124a:	be 95 02 00 00       	mov    $0x295,%esi
   4124f:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   41254:	e8 cc 13 00 00       	call   42625 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41259:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4125d:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41264:	7e 90                	jle    411f6 <check_virtual_memory+0x104>
        }
    }
}
   41266:	90                   	nop
   41267:	90                   	nop
   41268:	c9                   	leave
   41269:	c3                   	ret

000000000004126a <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   4126a:	55                   	push   %rbp
   4126b:	48 89 e5             	mov    %rsp,%rbp
   4126e:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41272:	ba 98 50 04 00       	mov    $0x45098,%edx
   41277:	be 00 0f 00 00       	mov    $0xf00,%esi
   4127c:	bf 20 00 00 00       	mov    $0x20,%edi
   41281:	b8 00 00 00 00       	mov    $0x0,%eax
   41286:	e8 94 38 00 00       	call   44b1f <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4128b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41292:	e9 f8 00 00 00       	jmp    4138f <memshow_physical+0x125>
        if (pn % 64 == 0) {
   41297:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4129a:	83 e0 3f             	and    $0x3f,%eax
   4129d:	85 c0                	test   %eax,%eax
   4129f:	75 3c                	jne    412dd <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   412a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412a4:	c1 e0 0c             	shl    $0xc,%eax
   412a7:	89 c1                	mov    %eax,%ecx
   412a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412ac:	8d 50 3f             	lea    0x3f(%rax),%edx
   412af:	85 c0                	test   %eax,%eax
   412b1:	0f 48 c2             	cmovs  %edx,%eax
   412b4:	c1 f8 06             	sar    $0x6,%eax
   412b7:	8d 50 01             	lea    0x1(%rax),%edx
   412ba:	89 d0                	mov    %edx,%eax
   412bc:	c1 e0 02             	shl    $0x2,%eax
   412bf:	01 d0                	add    %edx,%eax
   412c1:	c1 e0 04             	shl    $0x4,%eax
   412c4:	83 c0 03             	add    $0x3,%eax
   412c7:	ba a8 50 04 00       	mov    $0x450a8,%edx
   412cc:	be 00 0f 00 00       	mov    $0xf00,%esi
   412d1:	89 c7                	mov    %eax,%edi
   412d3:	b8 00 00 00 00       	mov    $0x0,%eax
   412d8:	e8 42 38 00 00       	call   44b1f <console_printf>
        }

        int owner = pageinfo[pn].owner;
   412dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412e0:	48 98                	cltq
   412e2:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   412e9:	00 
   412ea:	0f be c0             	movsbl %al,%eax
   412ed:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   412f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412f3:	48 98                	cltq
   412f5:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   412fc:	00 
   412fd:	84 c0                	test   %al,%al
   412ff:	75 07                	jne    41308 <memshow_physical+0x9e>
            owner = PO_FREE;
   41301:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41308:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4130b:	83 c0 02             	add    $0x2,%eax
   4130e:	48 98                	cltq
   41310:	0f b7 84 00 c0 4c 04 	movzwl 0x44cc0(%rax,%rax,1),%eax
   41317:	00 
   41318:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4131c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4131f:	48 98                	cltq
   41321:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41328:	00 
   41329:	3c 01                	cmp    $0x1,%al
   4132b:	7e 1a                	jle    41347 <memshow_physical+0xdd>
   4132d:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41332:	48 c1 e8 0c          	shr    $0xc,%rax
   41336:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41339:	74 0c                	je     41347 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4133b:	b8 53 00 00 00       	mov    $0x53,%eax
   41340:	80 cc 0f             	or     $0xf,%ah
   41343:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
        color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41347:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4134a:	8d 50 3f             	lea    0x3f(%rax),%edx
   4134d:	85 c0                	test   %eax,%eax
   4134f:	0f 48 c2             	cmovs  %edx,%eax
   41352:	c1 f8 06             	sar    $0x6,%eax
   41355:	8d 50 01             	lea    0x1(%rax),%edx
   41358:	89 d0                	mov    %edx,%eax
   4135a:	c1 e0 02             	shl    $0x2,%eax
   4135d:	01 d0                	add    %edx,%eax
   4135f:	c1 e0 04             	shl    $0x4,%eax
   41362:	89 c1                	mov    %eax,%ecx
   41364:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41367:	89 d0                	mov    %edx,%eax
   41369:	c1 f8 1f             	sar    $0x1f,%eax
   4136c:	c1 e8 1a             	shr    $0x1a,%eax
   4136f:	01 c2                	add    %eax,%edx
   41371:	83 e2 3f             	and    $0x3f,%edx
   41374:	29 c2                	sub    %eax,%edx
   41376:	89 d0                	mov    %edx,%eax
   41378:	83 c0 0c             	add    $0xc,%eax
   4137b:	01 c8                	add    %ecx,%eax
   4137d:	48 98                	cltq
   4137f:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41383:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   4138a:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4138b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4138f:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41396:	0f 8e fb fe ff ff    	jle    41297 <memshow_physical+0x2d>
    }
}
   4139c:	90                   	nop
   4139d:	90                   	nop
   4139e:	c9                   	leave
   4139f:	c3                   	ret

00000000000413a0 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   413a0:	55                   	push   %rbp
   413a1:	48 89 e5             	mov    %rsp,%rbp
   413a4:	48 83 ec 40          	sub    $0x40,%rsp
   413a8:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   413ac:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   413b0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   413b4:	25 ff 0f 00 00       	and    $0xfff,%eax
   413b9:	48 85 c0             	test   %rax,%rax
   413bc:	74 14                	je     413d2 <memshow_virtual+0x32>
   413be:	ba b0 50 04 00       	mov    $0x450b0,%edx
   413c3:	be c6 02 00 00       	mov    $0x2c6,%esi
   413c8:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   413cd:	e8 53 12 00 00       	call   42625 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   413d2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   413d6:	48 89 c1             	mov    %rax,%rcx
   413d9:	ba dd 50 04 00       	mov    $0x450dd,%edx
   413de:	be 00 0f 00 00       	mov    $0xf00,%esi
   413e3:	bf 3a 03 00 00       	mov    $0x33a,%edi
   413e8:	b8 00 00 00 00       	mov    $0x0,%eax
   413ed:	e8 2d 37 00 00       	call   44b1f <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   413f2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   413f9:	00 
   413fa:	e9 80 01 00 00       	jmp    4157f <memshow_virtual+0x1df>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   413ff:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41403:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41407:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4140b:	48 89 ce             	mov    %rcx,%rsi
   4140e:	48 89 c7             	mov    %rax,%rdi
   41411:	e8 d1 18 00 00       	call   42ce7 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41416:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41419:	85 c0                	test   %eax,%eax
   4141b:	79 0b                	jns    41428 <memshow_virtual+0x88>
            color = ' ';
   4141d:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41423:	e9 d7 00 00 00       	jmp    414ff <memshow_virtual+0x15f>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41428:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4142c:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41432:	76 14                	jbe    41448 <memshow_virtual+0xa8>
   41434:	ba fa 50 04 00       	mov    $0x450fa,%edx
   41439:	be cf 02 00 00       	mov    $0x2cf,%esi
   4143e:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   41443:	e8 dd 11 00 00       	call   42625 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41448:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4144b:	48 98                	cltq
   4144d:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41454:	00 
   41455:	0f be c0             	movsbl %al,%eax
   41458:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   4145b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4145e:	48 98                	cltq
   41460:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41467:	00 
   41468:	84 c0                	test   %al,%al
   4146a:	75 07                	jne    41473 <memshow_virtual+0xd3>
                owner = PO_FREE;
   4146c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41473:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41476:	83 c0 02             	add    $0x2,%eax
   41479:	48 98                	cltq
   4147b:	0f b7 84 00 c0 4c 04 	movzwl 0x44cc0(%rax,%rax,1),%eax
   41482:	00 
   41483:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41487:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4148a:	48 98                	cltq
   4148c:	83 e0 04             	and    $0x4,%eax
   4148f:	48 85 c0             	test   %rax,%rax
   41492:	74 27                	je     414bb <memshow_virtual+0x11b>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41494:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41498:	c1 e0 04             	shl    $0x4,%eax
   4149b:	66 25 00 f0          	and    $0xf000,%ax
   4149f:	89 c2                	mov    %eax,%edx
   414a1:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414a5:	c1 f8 04             	sar    $0x4,%eax
   414a8:	66 25 00 0f          	and    $0xf00,%ax
   414ac:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   414ae:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414b2:	0f b6 c0             	movzbl %al,%eax
   414b5:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   414b7:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   414bb:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414be:	48 98                	cltq
   414c0:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   414c7:	00 
   414c8:	3c 01                	cmp    $0x1,%al
   414ca:	7e 33                	jle    414ff <memshow_virtual+0x15f>
   414cc:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   414d1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414d5:	74 28                	je     414ff <memshow_virtual+0x15f>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   414d7:	b8 53 00 00 00       	mov    $0x53,%eax
   414dc:	89 c2                	mov    %eax,%edx
   414de:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414e2:	66 25 00 f0          	and    $0xf000,%ax
   414e6:	09 d0                	or     %edx,%eax
   414e8:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   414ec:	8b 45 e0             	mov    -0x20(%rbp),%eax
   414ef:	48 98                	cltq
   414f1:	83 e0 04             	and    $0x4,%eax
   414f4:	48 85 c0             	test   %rax,%rax
   414f7:	75 06                	jne    414ff <memshow_virtual+0x15f>
                    color = color | 0x0F00;
   414f9:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
        color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   414ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41503:	48 c1 e8 0c          	shr    $0xc,%rax
   41507:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   4150a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4150d:	83 e0 3f             	and    $0x3f,%eax
   41510:	85 c0                	test   %eax,%eax
   41512:	75 34                	jne    41548 <memshow_virtual+0x1a8>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41514:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41517:	c1 e8 06             	shr    $0x6,%eax
   4151a:	89 c2                	mov    %eax,%edx
   4151c:	89 d0                	mov    %edx,%eax
   4151e:	c1 e0 02             	shl    $0x2,%eax
   41521:	01 d0                	add    %edx,%eax
   41523:	c1 e0 04             	shl    $0x4,%eax
   41526:	05 73 03 00 00       	add    $0x373,%eax
   4152b:	89 c7                	mov    %eax,%edi
   4152d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41531:	48 89 c1             	mov    %rax,%rcx
   41534:	ba a8 50 04 00       	mov    $0x450a8,%edx
   41539:	be 00 0f 00 00       	mov    $0xf00,%esi
   4153e:	b8 00 00 00 00       	mov    $0x0,%eax
   41543:	e8 d7 35 00 00       	call   44b1f <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41548:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4154b:	c1 e8 06             	shr    $0x6,%eax
   4154e:	89 c2                	mov    %eax,%edx
   41550:	89 d0                	mov    %edx,%eax
   41552:	c1 e0 02             	shl    $0x2,%eax
   41555:	01 d0                	add    %edx,%eax
   41557:	c1 e0 04             	shl    $0x4,%eax
   4155a:	89 c2                	mov    %eax,%edx
   4155c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4155f:	83 e0 3f             	and    $0x3f,%eax
   41562:	01 d0                	add    %edx,%eax
   41564:	05 7c 03 00 00       	add    $0x37c,%eax
   41569:	89 c2                	mov    %eax,%edx
   4156b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4156f:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41576:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41577:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4157e:	00 
   4157f:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41586:	00 
   41587:	0f 86 72 fe ff ff    	jbe    413ff <memshow_virtual+0x5f>
    }
}
   4158d:	90                   	nop
   4158e:	90                   	nop
   4158f:	c9                   	leave
   41590:	c3                   	ret

0000000000041591 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41591:	55                   	push   %rbp
   41592:	48 89 e5             	mov    %rsp,%rbp
   41595:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41599:	8b 05 85 dd 00 00    	mov    0xdd85(%rip),%eax        # 4f324 <last_ticks.1>
   4159f:	85 c0                	test   %eax,%eax
   415a1:	74 13                	je     415b6 <memshow_virtual_animate+0x25>
   415a3:	8b 15 77 dd 00 00    	mov    0xdd77(%rip),%edx        # 4f320 <ticks>
   415a9:	8b 05 75 dd 00 00    	mov    0xdd75(%rip),%eax        # 4f324 <last_ticks.1>
   415af:	29 c2                	sub    %eax,%edx
   415b1:	83 fa 31             	cmp    $0x31,%edx
   415b4:	76 2c                	jbe    415e2 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   415b6:	8b 05 64 dd 00 00    	mov    0xdd64(%rip),%eax        # 4f320 <ticks>
   415bc:	89 05 62 dd 00 00    	mov    %eax,0xdd62(%rip)        # 4f324 <last_ticks.1>
        ++showing;
   415c2:	8b 05 3c 4a 00 00    	mov    0x4a3c(%rip),%eax        # 46004 <showing.0>
   415c8:	83 c0 01             	add    $0x1,%eax
   415cb:	89 05 33 4a 00 00    	mov    %eax,0x4a33(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   415d1:	eb 0f                	jmp    415e2 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   415d3:	8b 05 2b 4a 00 00    	mov    0x4a2b(%rip),%eax        # 46004 <showing.0>
   415d9:	83 c0 01             	add    $0x1,%eax
   415dc:	89 05 22 4a 00 00    	mov    %eax,0x4a22(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   415e2:	8b 05 1c 4a 00 00    	mov    0x4a1c(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   415e8:	83 f8 20             	cmp    $0x20,%eax
   415eb:	7f 34                	jg     41621 <memshow_virtual_animate+0x90>
   415ed:	8b 15 11 4a 00 00    	mov    0x4a11(%rip),%edx        # 46004 <showing.0>
   415f3:	89 d0                	mov    %edx,%eax
   415f5:	c1 f8 1f             	sar    $0x1f,%eax
   415f8:	c1 e8 1c             	shr    $0x1c,%eax
   415fb:	01 c2                	add    %eax,%edx
   415fd:	83 e2 0f             	and    $0xf,%edx
   41600:	29 c2                	sub    %eax,%edx
   41602:	89 d0                	mov    %edx,%eax
   41604:	48 63 d0             	movslq %eax,%rdx
   41607:	48 89 d0             	mov    %rdx,%rax
   4160a:	48 c1 e0 04          	shl    $0x4,%rax
   4160e:	48 29 d0             	sub    %rdx,%rax
   41611:	48 c1 e0 04          	shl    $0x4,%rax
   41615:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   4161b:	8b 00                	mov    (%rax),%eax
   4161d:	85 c0                	test   %eax,%eax
   4161f:	74 b2                	je     415d3 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41621:	8b 15 dd 49 00 00    	mov    0x49dd(%rip),%edx        # 46004 <showing.0>
   41627:	89 d0                	mov    %edx,%eax
   41629:	c1 f8 1f             	sar    $0x1f,%eax
   4162c:	c1 e8 1c             	shr    $0x1c,%eax
   4162f:	01 c2                	add    %eax,%edx
   41631:	83 e2 0f             	and    $0xf,%edx
   41634:	29 c2                	sub    %eax,%edx
   41636:	89 d0                	mov    %edx,%eax
   41638:	89 05 c6 49 00 00    	mov    %eax,0x49c6(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   4163e:	8b 05 c0 49 00 00    	mov    0x49c0(%rip),%eax        # 46004 <showing.0>
   41644:	48 63 d0             	movslq %eax,%rdx
   41647:	48 89 d0             	mov    %rdx,%rax
   4164a:	48 c1 e0 04          	shl    $0x4,%rax
   4164e:	48 29 d0             	sub    %rdx,%rax
   41651:	48 c1 e0 04          	shl    $0x4,%rax
   41655:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   4165b:	8b 00                	mov    (%rax),%eax
   4165d:	85 c0                	test   %eax,%eax
   4165f:	74 76                	je     416d7 <memshow_virtual_animate+0x146>
   41661:	8b 05 9d 49 00 00    	mov    0x499d(%rip),%eax        # 46004 <showing.0>
   41667:	48 63 d0             	movslq %eax,%rdx
   4166a:	48 89 d0             	mov    %rdx,%rax
   4166d:	48 c1 e0 04          	shl    $0x4,%rax
   41671:	48 29 d0             	sub    %rdx,%rax
   41674:	48 c1 e0 04          	shl    $0x4,%rax
   41678:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   4167e:	0f b6 00             	movzbl (%rax),%eax
   41681:	84 c0                	test   %al,%al
   41683:	74 52                	je     416d7 <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41685:	8b 15 79 49 00 00    	mov    0x4979(%rip),%edx        # 46004 <showing.0>
   4168b:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4168f:	89 d1                	mov    %edx,%ecx
   41691:	ba 14 51 04 00       	mov    $0x45114,%edx
   41696:	be 04 00 00 00       	mov    $0x4,%esi
   4169b:	48 89 c7             	mov    %rax,%rdi
   4169e:	b8 00 00 00 00       	mov    $0x0,%eax
   416a3:	e8 83 35 00 00       	call   44c2b <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   416a8:	8b 05 56 49 00 00    	mov    0x4956(%rip),%eax        # 46004 <showing.0>
   416ae:	48 63 d0             	movslq %eax,%rdx
   416b1:	48 89 d0             	mov    %rdx,%rax
   416b4:	48 c1 e0 04          	shl    $0x4,%rax
   416b8:	48 29 d0             	sub    %rdx,%rax
   416bb:	48 c1 e0 04          	shl    $0x4,%rax
   416bf:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   416c5:	48 8b 00             	mov    (%rax),%rax
   416c8:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   416cc:	48 89 d6             	mov    %rdx,%rsi
   416cf:	48 89 c7             	mov    %rax,%rdi
   416d2:	e8 c9 fc ff ff       	call   413a0 <memshow_virtual>
    }
}
   416d7:	90                   	nop
   416d8:	c9                   	leave
   416d9:	c3                   	ret

00000000000416da <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   416da:	55                   	push   %rbp
   416db:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   416de:	e8 4f 01 00 00       	call   41832 <segments_init>
    interrupt_init();
   416e3:	e8 d0 03 00 00       	call   41ab8 <interrupt_init>
    virtual_memory_init();
   416e8:	e8 f3 0f 00 00       	call   426e0 <virtual_memory_init>
}
   416ed:	90                   	nop
   416ee:	5d                   	pop    %rbp
   416ef:	c3                   	ret

00000000000416f0 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   416f0:	55                   	push   %rbp
   416f1:	48 89 e5             	mov    %rsp,%rbp
   416f4:	48 83 ec 18          	sub    $0x18,%rsp
   416f8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   416fc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41700:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41703:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41706:	48 98                	cltq
   41708:	48 c1 e0 2d          	shl    $0x2d,%rax
   4170c:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41710:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41717:	90 00 00 
   4171a:	48 09 c2             	or     %rax,%rdx
    *segment = type
   4171d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41721:	48 89 10             	mov    %rdx,(%rax)
}
   41724:	90                   	nop
   41725:	c9                   	leave
   41726:	c3                   	ret

0000000000041727 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41727:	55                   	push   %rbp
   41728:	48 89 e5             	mov    %rsp,%rbp
   4172b:	48 83 ec 28          	sub    $0x28,%rsp
   4172f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41733:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41737:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4173a:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4173e:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41742:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41746:	48 c1 e0 10          	shl    $0x10,%rax
   4174a:	48 89 c2             	mov    %rax,%rdx
   4174d:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41754:	00 00 00 
   41757:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4175a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4175e:	48 c1 e0 20          	shl    $0x20,%rax
   41762:	48 89 c1             	mov    %rax,%rcx
   41765:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4176c:	00 00 ff 
   4176f:	48 21 c8             	and    %rcx,%rax
   41772:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41775:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41779:	48 83 e8 01          	sub    $0x1,%rax
   4177d:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41780:	48 09 d0             	or     %rdx,%rax
        | type
   41783:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41787:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4178a:	48 63 d2             	movslq %edx,%rdx
   4178d:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41791:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41794:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4179b:	80 00 00 
   4179e:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   417a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417a5:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   417a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417ac:	48 83 c0 08          	add    $0x8,%rax
   417b0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   417b4:	48 c1 ea 20          	shr    $0x20,%rdx
   417b8:	48 89 10             	mov    %rdx,(%rax)
}
   417bb:	90                   	nop
   417bc:	c9                   	leave
   417bd:	c3                   	ret

00000000000417be <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   417be:	55                   	push   %rbp
   417bf:	48 89 e5             	mov    %rsp,%rbp
   417c2:	48 83 ec 20          	sub    $0x20,%rsp
   417c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   417ca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   417ce:	89 55 ec             	mov    %edx,-0x14(%rbp)
   417d1:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   417d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417d9:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   417dc:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   417e0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   417e3:	48 63 d2             	movslq %edx,%rdx
   417e6:	48 c1 e2 2d          	shl    $0x2d,%rdx
   417ea:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   417ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417f1:	48 c1 e0 20          	shl    $0x20,%rax
   417f5:	48 89 c1             	mov    %rax,%rcx
   417f8:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   417ff:	00 ff ff 
   41802:	48 21 c8             	and    %rcx,%rax
   41805:	48 09 c2             	or     %rax,%rdx
   41808:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   4180f:	80 00 00 
   41812:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41815:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41819:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   4181c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41820:	48 c1 e8 20          	shr    $0x20,%rax
   41824:	48 89 c2             	mov    %rax,%rdx
   41827:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4182b:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   4182f:	90                   	nop
   41830:	c9                   	leave
   41831:	c3                   	ret

0000000000041832 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41832:	55                   	push   %rbp
   41833:	48 89 e5             	mov    %rsp,%rbp
   41836:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4183a:	48 c7 05 fb da 00 00 	movq   $0x0,0xdafb(%rip)        # 4f340 <segments>
   41841:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41845:	ba 00 00 00 00       	mov    $0x0,%edx
   4184a:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41851:	08 20 00 
   41854:	48 89 c6             	mov    %rax,%rsi
   41857:	bf 48 f3 04 00       	mov    $0x4f348,%edi
   4185c:	e8 8f fe ff ff       	call   416f0 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41861:	ba 03 00 00 00       	mov    $0x3,%edx
   41866:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4186d:	08 20 00 
   41870:	48 89 c6             	mov    %rax,%rsi
   41873:	bf 50 f3 04 00       	mov    $0x4f350,%edi
   41878:	e8 73 fe ff ff       	call   416f0 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4187d:	ba 00 00 00 00       	mov    $0x0,%edx
   41882:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41889:	02 00 00 
   4188c:	48 89 c6             	mov    %rax,%rsi
   4188f:	bf 58 f3 04 00       	mov    $0x4f358,%edi
   41894:	e8 57 fe ff ff       	call   416f0 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41899:	ba 03 00 00 00       	mov    $0x3,%edx
   4189e:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   418a5:	02 00 00 
   418a8:	48 89 c6             	mov    %rax,%rsi
   418ab:	bf 60 f3 04 00       	mov    $0x4f360,%edi
   418b0:	e8 3b fe ff ff       	call   416f0 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   418b5:	b8 80 03 05 00       	mov    $0x50380,%eax
   418ba:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   418c0:	48 89 c1             	mov    %rax,%rcx
   418c3:	ba 00 00 00 00       	mov    $0x0,%edx
   418c8:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   418cf:	09 00 00 
   418d2:	48 89 c6             	mov    %rax,%rsi
   418d5:	bf 68 f3 04 00       	mov    $0x4f368,%edi
   418da:	e8 48 fe ff ff       	call   41727 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   418df:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   418e5:	b8 40 f3 04 00       	mov    $0x4f340,%eax
   418ea:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   418ee:	ba 60 00 00 00       	mov    $0x60,%edx
   418f3:	be 00 00 00 00       	mov    $0x0,%esi
   418f8:	bf 80 03 05 00       	mov    $0x50380,%edi
   418fd:	e8 66 24 00 00       	call   43d68 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41902:	48 c7 05 77 ea 00 00 	movq   $0x80000,0xea77(%rip)        # 50384 <kernel_task_descriptor+0x4>
   41909:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4190d:	ba 00 10 00 00       	mov    $0x1000,%edx
   41912:	be 00 00 00 00       	mov    $0x0,%esi
   41917:	bf 80 f3 04 00       	mov    $0x4f380,%edi
   4191c:	e8 47 24 00 00       	call   43d68 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41921:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41928:	eb 30                	jmp    4195a <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   4192a:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4192f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41932:	48 c1 e0 04          	shl    $0x4,%rax
   41936:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   4193c:	48 89 d1             	mov    %rdx,%rcx
   4193f:	ba 00 00 00 00       	mov    $0x0,%edx
   41944:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4194b:	0e 00 00 
   4194e:	48 89 c7             	mov    %rax,%rdi
   41951:	e8 68 fe ff ff       	call   417be <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41956:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4195a:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41961:	76 c7                	jbe    4192a <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41963:	b8 36 00 04 00       	mov    $0x40036,%eax
   41968:	48 89 c1             	mov    %rax,%rcx
   4196b:	ba 00 00 00 00       	mov    $0x0,%edx
   41970:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41977:	0e 00 00 
   4197a:	48 89 c6             	mov    %rax,%rsi
   4197d:	bf 80 f5 04 00       	mov    $0x4f580,%edi
   41982:	e8 37 fe ff ff       	call   417be <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41987:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   4198c:	48 89 c1             	mov    %rax,%rcx
   4198f:	ba 00 00 00 00       	mov    $0x0,%edx
   41994:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4199b:	0e 00 00 
   4199e:	48 89 c6             	mov    %rax,%rsi
   419a1:	bf 50 f4 04 00       	mov    $0x4f450,%edi
   419a6:	e8 13 fe ff ff       	call   417be <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   419ab:	b8 32 00 04 00       	mov    $0x40032,%eax
   419b0:	48 89 c1             	mov    %rax,%rcx
   419b3:	ba 00 00 00 00       	mov    $0x0,%edx
   419b8:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   419bf:	0e 00 00 
   419c2:	48 89 c6             	mov    %rax,%rsi
   419c5:	bf 60 f4 04 00       	mov    $0x4f460,%edi
   419ca:	e8 ef fd ff ff       	call   417be <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   419cf:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   419d6:	eb 3e                	jmp    41a16 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   419d8:	8b 45 f8             	mov    -0x8(%rbp),%eax
   419db:	83 e8 30             	sub    $0x30,%eax
   419de:	89 c0                	mov    %eax,%eax
   419e0:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   419e7:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   419e8:	48 89 c2             	mov    %rax,%rdx
   419eb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   419ee:	48 c1 e0 04          	shl    $0x4,%rax
   419f2:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   419f8:	48 89 d1             	mov    %rdx,%rcx
   419fb:	ba 03 00 00 00       	mov    $0x3,%edx
   41a00:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a07:	0e 00 00 
   41a0a:	48 89 c7             	mov    %rax,%rdi
   41a0d:	e8 ac fd ff ff       	call   417be <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41a12:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41a16:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41a1a:	76 bc                	jbe    419d8 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41a1c:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41a22:	b8 80 f3 04 00       	mov    $0x4f380,%eax
   41a27:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41a2b:	b8 28 00 00 00       	mov    $0x28,%eax
   41a30:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41a34:	0f 00 d8             	ltr    %ax
   41a37:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41a3b:	0f 20 c0             	mov    %cr0,%rax
   41a3e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41a42:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41a46:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41a49:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41a50:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41a53:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41a56:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a59:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41a5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41a61:	0f 22 c0             	mov    %rax,%cr0
}
   41a64:	90                   	nop
    lcr0(cr0);
}
   41a65:	90                   	nop
   41a66:	c9                   	leave
   41a67:	c3                   	ret

0000000000041a68 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41a68:	55                   	push   %rbp
   41a69:	48 89 e5             	mov    %rsp,%rbp
   41a6c:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41a70:	0f b7 05 69 e9 00 00 	movzwl 0xe969(%rip),%eax        # 503e0 <interrupts_enabled>
   41a77:	f7 d0                	not    %eax
   41a79:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41a7d:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a81:	0f b6 c0             	movzbl %al,%eax
   41a84:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41a8b:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a8e:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41a92:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41a95:	ee                   	out    %al,(%dx)
}
   41a96:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41a97:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a9b:	66 c1 e8 08          	shr    $0x8,%ax
   41a9f:	0f b6 c0             	movzbl %al,%eax
   41aa2:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41aa9:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aac:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41ab0:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41ab3:	ee                   	out    %al,(%dx)
}
   41ab4:	90                   	nop
}
   41ab5:	90                   	nop
   41ab6:	c9                   	leave
   41ab7:	c3                   	ret

0000000000041ab8 <interrupt_init>:

void interrupt_init(void) {
   41ab8:	55                   	push   %rbp
   41ab9:	48 89 e5             	mov    %rsp,%rbp
   41abc:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41ac0:	66 c7 05 17 e9 00 00 	movw   $0x0,0xe917(%rip)        # 503e0 <interrupts_enabled>
   41ac7:	00 00 
    interrupt_mask();
   41ac9:	e8 9a ff ff ff       	call   41a68 <interrupt_mask>
   41ace:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41ad5:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ad9:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41add:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41ae0:	ee                   	out    %al,(%dx)
}
   41ae1:	90                   	nop
   41ae2:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41ae9:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aed:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41af1:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41af4:	ee                   	out    %al,(%dx)
}
   41af5:	90                   	nop
   41af6:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41afd:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b01:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41b05:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41b08:	ee                   	out    %al,(%dx)
}
   41b09:	90                   	nop
   41b0a:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41b11:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b15:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41b19:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41b1c:	ee                   	out    %al,(%dx)
}
   41b1d:	90                   	nop
   41b1e:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41b25:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b29:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41b2d:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41b30:	ee                   	out    %al,(%dx)
}
   41b31:	90                   	nop
   41b32:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41b39:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b3d:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41b41:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41b44:	ee                   	out    %al,(%dx)
}
   41b45:	90                   	nop
   41b46:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41b4d:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b51:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41b55:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41b58:	ee                   	out    %al,(%dx)
}
   41b59:	90                   	nop
   41b5a:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41b61:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b65:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41b69:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41b6c:	ee                   	out    %al,(%dx)
}
   41b6d:	90                   	nop
   41b6e:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41b75:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b79:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41b7d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41b80:	ee                   	out    %al,(%dx)
}
   41b81:	90                   	nop
   41b82:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41b89:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b8d:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b91:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b94:	ee                   	out    %al,(%dx)
}
   41b95:	90                   	nop
   41b96:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41b9d:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ba1:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ba5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ba8:	ee                   	out    %al,(%dx)
}
   41ba9:	90                   	nop
   41baa:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41bb1:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bb5:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41bb9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41bbc:	ee                   	out    %al,(%dx)
}
   41bbd:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41bbe:	e8 a5 fe ff ff       	call   41a68 <interrupt_mask>
}
   41bc3:	90                   	nop
   41bc4:	c9                   	leave
   41bc5:	c3                   	ret

0000000000041bc6 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41bc6:	55                   	push   %rbp
   41bc7:	48 89 e5             	mov    %rsp,%rbp
   41bca:	48 83 ec 28          	sub    $0x28,%rsp
   41bce:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41bd1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41bd5:	0f 8e 9e 00 00 00    	jle    41c79 <timer_init+0xb3>
   41bdb:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41be2:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41be6:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41bea:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41bed:	ee                   	out    %al,(%dx)
}
   41bee:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41bef:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41bf2:	89 c2                	mov    %eax,%edx
   41bf4:	c1 ea 1f             	shr    $0x1f,%edx
   41bf7:	01 d0                	add    %edx,%eax
   41bf9:	d1 f8                	sar    %eax
   41bfb:	05 de 34 12 00       	add    $0x1234de,%eax
   41c00:	99                   	cltd
   41c01:	f7 7d dc             	idivl  -0x24(%rbp)
   41c04:	89 c2                	mov    %eax,%edx
   41c06:	89 d0                	mov    %edx,%eax
   41c08:	c1 f8 1f             	sar    $0x1f,%eax
   41c0b:	c1 e8 18             	shr    $0x18,%eax
   41c0e:	01 c2                	add    %eax,%edx
   41c10:	0f b6 d2             	movzbl %dl,%edx
   41c13:	29 c2                	sub    %eax,%edx
   41c15:	89 d0                	mov    %edx,%eax
   41c17:	0f b6 c0             	movzbl %al,%eax
   41c1a:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41c21:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c24:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c28:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c2b:	ee                   	out    %al,(%dx)
}
   41c2c:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41c2d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c30:	89 c2                	mov    %eax,%edx
   41c32:	c1 ea 1f             	shr    $0x1f,%edx
   41c35:	01 d0                	add    %edx,%eax
   41c37:	d1 f8                	sar    %eax
   41c39:	05 de 34 12 00       	add    $0x1234de,%eax
   41c3e:	99                   	cltd
   41c3f:	f7 7d dc             	idivl  -0x24(%rbp)
   41c42:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41c48:	85 c0                	test   %eax,%eax
   41c4a:	0f 48 c2             	cmovs  %edx,%eax
   41c4d:	c1 f8 08             	sar    $0x8,%eax
   41c50:	0f b6 c0             	movzbl %al,%eax
   41c53:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41c5a:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c5d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c61:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c64:	ee                   	out    %al,(%dx)
}
   41c65:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41c66:	0f b7 05 73 e7 00 00 	movzwl 0xe773(%rip),%eax        # 503e0 <interrupts_enabled>
   41c6d:	83 c8 01             	or     $0x1,%eax
   41c70:	66 89 05 69 e7 00 00 	mov    %ax,0xe769(%rip)        # 503e0 <interrupts_enabled>
   41c77:	eb 11                	jmp    41c8a <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41c79:	0f b7 05 60 e7 00 00 	movzwl 0xe760(%rip),%eax        # 503e0 <interrupts_enabled>
   41c80:	83 e0 fe             	and    $0xfffffffe,%eax
   41c83:	66 89 05 56 e7 00 00 	mov    %ax,0xe756(%rip)        # 503e0 <interrupts_enabled>
    }
    interrupt_mask();
   41c8a:	e8 d9 fd ff ff       	call   41a68 <interrupt_mask>
}
   41c8f:	90                   	nop
   41c90:	c9                   	leave
   41c91:	c3                   	ret

0000000000041c92 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41c92:	55                   	push   %rbp
   41c93:	48 89 e5             	mov    %rsp,%rbp
   41c96:	48 83 ec 08          	sub    $0x8,%rsp
   41c9a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41c9e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41ca3:	74 14                	je     41cb9 <physical_memory_isreserved+0x27>
   41ca5:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41cac:	00 
   41cad:	76 11                	jbe    41cc0 <physical_memory_isreserved+0x2e>
   41caf:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41cb6:	00 
   41cb7:	77 07                	ja     41cc0 <physical_memory_isreserved+0x2e>
   41cb9:	b8 01 00 00 00       	mov    $0x1,%eax
   41cbe:	eb 05                	jmp    41cc5 <physical_memory_isreserved+0x33>
   41cc0:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41cc5:	c9                   	leave
   41cc6:	c3                   	ret

0000000000041cc7 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41cc7:	55                   	push   %rbp
   41cc8:	48 89 e5             	mov    %rsp,%rbp
   41ccb:	48 83 ec 10          	sub    $0x10,%rsp
   41ccf:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41cd2:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41cd5:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41cd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cdb:	c1 e0 10             	shl    $0x10,%eax
   41cde:	89 c2                	mov    %eax,%edx
   41ce0:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ce3:	c1 e0 0b             	shl    $0xb,%eax
   41ce6:	09 c2                	or     %eax,%edx
   41ce8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ceb:	c1 e0 08             	shl    $0x8,%eax
   41cee:	09 d0                	or     %edx,%eax
}
   41cf0:	c9                   	leave
   41cf1:	c3                   	ret

0000000000041cf2 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41cf2:	55                   	push   %rbp
   41cf3:	48 89 e5             	mov    %rsp,%rbp
   41cf6:	48 83 ec 18          	sub    $0x18,%rsp
   41cfa:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41cfd:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41d00:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41d03:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41d06:	09 d0                	or     %edx,%eax
   41d08:	0d 00 00 00 80       	or     $0x80000000,%eax
   41d0d:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41d14:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41d17:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d1a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d1d:	ef                   	out    %eax,(%dx)
}
   41d1e:	90                   	nop
   41d1f:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41d26:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d29:	89 c2                	mov    %eax,%edx
   41d2b:	ed                   	in     (%dx),%eax
   41d2c:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41d2f:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41d32:	c9                   	leave
   41d33:	c3                   	ret

0000000000041d34 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41d34:	55                   	push   %rbp
   41d35:	48 89 e5             	mov    %rsp,%rbp
   41d38:	48 83 ec 28          	sub    $0x28,%rsp
   41d3c:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41d3f:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41d42:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41d49:	eb 73                	jmp    41dbe <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41d4b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41d52:	eb 60                	jmp    41db4 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41d54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41d5b:	eb 4a                	jmp    41da7 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41d5d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d60:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41d63:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d66:	89 ce                	mov    %ecx,%esi
   41d68:	89 c7                	mov    %eax,%edi
   41d6a:	e8 58 ff ff ff       	call   41cc7 <pci_make_configaddr>
   41d6f:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41d72:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d75:	be 00 00 00 00       	mov    $0x0,%esi
   41d7a:	89 c7                	mov    %eax,%edi
   41d7c:	e8 71 ff ff ff       	call   41cf2 <pci_config_readl>
   41d81:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41d84:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41d87:	c1 e0 10             	shl    $0x10,%eax
   41d8a:	0b 45 dc             	or     -0x24(%rbp),%eax
   41d8d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41d90:	75 05                	jne    41d97 <pci_find_device+0x63>
                    return configaddr;
   41d92:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d95:	eb 35                	jmp    41dcc <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41d97:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41d9b:	75 06                	jne    41da3 <pci_find_device+0x6f>
   41d9d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41da1:	74 0c                	je     41daf <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41da3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41da7:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41dab:	75 b0                	jne    41d5d <pci_find_device+0x29>
   41dad:	eb 01                	jmp    41db0 <pci_find_device+0x7c>
                    break;
   41daf:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41db0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41db4:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41db8:	75 9a                	jne    41d54 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41dba:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41dbe:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41dc5:	75 84                	jne    41d4b <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41dc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41dcc:	c9                   	leave
   41dcd:	c3                   	ret

0000000000041dce <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41dce:	55                   	push   %rbp
   41dcf:	48 89 e5             	mov    %rsp,%rbp
   41dd2:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41dd6:	be 13 71 00 00       	mov    $0x7113,%esi
   41ddb:	bf 86 80 00 00       	mov    $0x8086,%edi
   41de0:	e8 4f ff ff ff       	call   41d34 <pci_find_device>
   41de5:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41de8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41dec:	78 30                	js     41e1e <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41dee:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41df1:	be 40 00 00 00       	mov    $0x40,%esi
   41df6:	89 c7                	mov    %eax,%edi
   41df8:	e8 f5 fe ff ff       	call   41cf2 <pci_config_readl>
   41dfd:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41e02:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41e05:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41e08:	83 c0 04             	add    $0x4,%eax
   41e0b:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41e0e:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41e14:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41e18:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e1b:	66 ef                	out    %ax,(%dx)
}
   41e1d:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41e1e:	ba 20 51 04 00       	mov    $0x45120,%edx
   41e23:	be 00 c0 00 00       	mov    $0xc000,%esi
   41e28:	bf 80 07 00 00       	mov    $0x780,%edi
   41e2d:	b8 00 00 00 00       	mov    $0x0,%eax
   41e32:	e8 e8 2c 00 00       	call   44b1f <console_printf>
 spinloop: goto spinloop;
   41e37:	eb fe                	jmp    41e37 <poweroff+0x69>

0000000000041e39 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41e39:	55                   	push   %rbp
   41e3a:	48 89 e5             	mov    %rsp,%rbp
   41e3d:	48 83 ec 10          	sub    $0x10,%rsp
   41e41:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41e48:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e4c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e50:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e53:	ee                   	out    %al,(%dx)
}
   41e54:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41e55:	eb fe                	jmp    41e55 <reboot+0x1c>

0000000000041e57 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41e57:	55                   	push   %rbp
   41e58:	48 89 e5             	mov    %rsp,%rbp
   41e5b:	48 83 ec 10          	sub    $0x10,%rsp
   41e5f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e63:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41e66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e6a:	48 83 c0 18          	add    $0x18,%rax
   41e6e:	ba c0 00 00 00       	mov    $0xc0,%edx
   41e73:	be 00 00 00 00       	mov    $0x0,%esi
   41e78:	48 89 c7             	mov    %rax,%rdi
   41e7b:	e8 e8 1e 00 00       	call   43d68 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41e80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e84:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41e8b:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41e8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e91:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41e98:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41e9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ea0:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41ea7:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41eab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41eaf:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41eb6:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41eb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ebc:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41ec3:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41ec7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41eca:	83 e0 01             	and    $0x1,%eax
   41ecd:	85 c0                	test   %eax,%eax
   41ecf:	74 1c                	je     41eed <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41ed1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ed5:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41edc:	80 cc 30             	or     $0x30,%ah
   41edf:	48 89 c2             	mov    %rax,%rdx
   41ee2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ee6:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41eed:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ef0:	83 e0 02             	and    $0x2,%eax
   41ef3:	85 c0                	test   %eax,%eax
   41ef5:	74 1c                	je     41f13 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41ef7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41efb:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41f02:	80 e4 fd             	and    $0xfd,%ah
   41f05:	48 89 c2             	mov    %rax,%rdx
   41f08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f0c:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41f13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f17:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41f1e:	90                   	nop
   41f1f:	c9                   	leave
   41f20:	c3                   	ret

0000000000041f21 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41f21:	55                   	push   %rbp
   41f22:	48 89 e5             	mov    %rsp,%rbp
   41f25:	48 83 ec 28          	sub    $0x28,%rsp
   41f29:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41f2c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41f30:	78 09                	js     41f3b <console_show_cursor+0x1a>
   41f32:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41f39:	7e 07                	jle    41f42 <console_show_cursor+0x21>
        cpos = 0;
   41f3b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41f42:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41f49:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f4d:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41f51:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41f54:	ee                   	out    %al,(%dx)
}
   41f55:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41f56:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f59:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41f5f:	85 c0                	test   %eax,%eax
   41f61:	0f 48 c2             	cmovs  %edx,%eax
   41f64:	c1 f8 08             	sar    $0x8,%eax
   41f67:	0f b6 c0             	movzbl %al,%eax
   41f6a:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41f71:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f74:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41f78:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f7b:	ee                   	out    %al,(%dx)
}
   41f7c:	90                   	nop
   41f7d:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41f84:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f88:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41f8c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f8f:	ee                   	out    %al,(%dx)
}
   41f90:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41f91:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41f94:	89 d0                	mov    %edx,%eax
   41f96:	c1 f8 1f             	sar    $0x1f,%eax
   41f99:	c1 e8 18             	shr    $0x18,%eax
   41f9c:	01 c2                	add    %eax,%edx
   41f9e:	0f b6 d2             	movzbl %dl,%edx
   41fa1:	29 c2                	sub    %eax,%edx
   41fa3:	89 d0                	mov    %edx,%eax
   41fa5:	0f b6 c0             	movzbl %al,%eax
   41fa8:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41faf:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fb2:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fb6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41fb9:	ee                   	out    %al,(%dx)
}
   41fba:	90                   	nop
}
   41fbb:	90                   	nop
   41fbc:	c9                   	leave
   41fbd:	c3                   	ret

0000000000041fbe <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41fbe:	55                   	push   %rbp
   41fbf:	48 89 e5             	mov    %rsp,%rbp
   41fc2:	48 83 ec 20          	sub    $0x20,%rsp
   41fc6:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41fcd:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fd0:	89 c2                	mov    %eax,%edx
   41fd2:	ec                   	in     (%dx),%al
   41fd3:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41fd6:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41fda:	0f b6 c0             	movzbl %al,%eax
   41fdd:	83 e0 01             	and    $0x1,%eax
   41fe0:	85 c0                	test   %eax,%eax
   41fe2:	75 0a                	jne    41fee <keyboard_readc+0x30>
        return -1;
   41fe4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41fe9:	e9 e7 01 00 00       	jmp    421d5 <keyboard_readc+0x217>
   41fee:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41ff5:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41ff8:	89 c2                	mov    %eax,%edx
   41ffa:	ec                   	in     (%dx),%al
   41ffb:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41ffe:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42002:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42005:	0f b6 05 d6 e3 00 00 	movzbl 0xe3d6(%rip),%eax        # 503e2 <last_escape.2>
   4200c:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   4200f:	c6 05 cc e3 00 00 00 	movb   $0x0,0xe3cc(%rip)        # 503e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42016:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4201a:	75 11                	jne    4202d <keyboard_readc+0x6f>
        last_escape = 0x80;
   4201c:	c6 05 bf e3 00 00 80 	movb   $0x80,0xe3bf(%rip)        # 503e2 <last_escape.2>
        return 0;
   42023:	b8 00 00 00 00       	mov    $0x0,%eax
   42028:	e9 a8 01 00 00       	jmp    421d5 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4202d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42031:	84 c0                	test   %al,%al
   42033:	79 60                	jns    42095 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42035:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42039:	83 e0 7f             	and    $0x7f,%eax
   4203c:	89 c2                	mov    %eax,%edx
   4203e:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42042:	09 d0                	or     %edx,%eax
   42044:	48 98                	cltq
   42046:	0f b6 80 40 51 04 00 	movzbl 0x45140(%rax),%eax
   4204d:	0f b6 c0             	movzbl %al,%eax
   42050:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42053:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   4205a:	7e 2f                	jle    4208b <keyboard_readc+0xcd>
   4205c:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42063:	7f 26                	jg     4208b <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42065:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42068:	2d fa 00 00 00       	sub    $0xfa,%eax
   4206d:	ba 01 00 00 00       	mov    $0x1,%edx
   42072:	89 c1                	mov    %eax,%ecx
   42074:	d3 e2                	shl    %cl,%edx
   42076:	89 d0                	mov    %edx,%eax
   42078:	f7 d0                	not    %eax
   4207a:	89 c2                	mov    %eax,%edx
   4207c:	0f b6 05 60 e3 00 00 	movzbl 0xe360(%rip),%eax        # 503e3 <modifiers.1>
   42083:	21 d0                	and    %edx,%eax
   42085:	88 05 58 e3 00 00    	mov    %al,0xe358(%rip)        # 503e3 <modifiers.1>
        }
        return 0;
   4208b:	b8 00 00 00 00       	mov    $0x0,%eax
   42090:	e9 40 01 00 00       	jmp    421d5 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   42095:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42099:	0a 45 fa             	or     -0x6(%rbp),%al
   4209c:	0f b6 c0             	movzbl %al,%eax
   4209f:	48 98                	cltq
   420a1:	0f b6 80 40 51 04 00 	movzbl 0x45140(%rax),%eax
   420a8:	0f b6 c0             	movzbl %al,%eax
   420ab:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   420ae:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   420b2:	7e 57                	jle    4210b <keyboard_readc+0x14d>
   420b4:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   420b8:	7f 51                	jg     4210b <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   420ba:	0f b6 05 22 e3 00 00 	movzbl 0xe322(%rip),%eax        # 503e3 <modifiers.1>
   420c1:	0f b6 c0             	movzbl %al,%eax
   420c4:	83 e0 02             	and    $0x2,%eax
   420c7:	85 c0                	test   %eax,%eax
   420c9:	74 09                	je     420d4 <keyboard_readc+0x116>
            ch -= 0x60;
   420cb:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   420cf:	e9 fd 00 00 00       	jmp    421d1 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   420d4:	0f b6 05 08 e3 00 00 	movzbl 0xe308(%rip),%eax        # 503e3 <modifiers.1>
   420db:	0f b6 c0             	movzbl %al,%eax
   420de:	83 e0 01             	and    $0x1,%eax
   420e1:	85 c0                	test   %eax,%eax
   420e3:	0f 94 c2             	sete   %dl
   420e6:	0f b6 05 f6 e2 00 00 	movzbl 0xe2f6(%rip),%eax        # 503e3 <modifiers.1>
   420ed:	0f b6 c0             	movzbl %al,%eax
   420f0:	83 e0 08             	and    $0x8,%eax
   420f3:	85 c0                	test   %eax,%eax
   420f5:	0f 94 c0             	sete   %al
   420f8:	31 d0                	xor    %edx,%eax
   420fa:	84 c0                	test   %al,%al
   420fc:	0f 84 cf 00 00 00    	je     421d1 <keyboard_readc+0x213>
            ch -= 0x20;
   42102:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42106:	e9 c6 00 00 00       	jmp    421d1 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4210b:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42112:	7e 30                	jle    42144 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42114:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42117:	2d fa 00 00 00       	sub    $0xfa,%eax
   4211c:	ba 01 00 00 00       	mov    $0x1,%edx
   42121:	89 c1                	mov    %eax,%ecx
   42123:	d3 e2                	shl    %cl,%edx
   42125:	89 d0                	mov    %edx,%eax
   42127:	89 c2                	mov    %eax,%edx
   42129:	0f b6 05 b3 e2 00 00 	movzbl 0xe2b3(%rip),%eax        # 503e3 <modifiers.1>
   42130:	31 d0                	xor    %edx,%eax
   42132:	88 05 ab e2 00 00    	mov    %al,0xe2ab(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   42138:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4213f:	e9 8e 00 00 00       	jmp    421d2 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42144:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4214b:	7e 2d                	jle    4217a <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4214d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42150:	2d fa 00 00 00       	sub    $0xfa,%eax
   42155:	ba 01 00 00 00       	mov    $0x1,%edx
   4215a:	89 c1                	mov    %eax,%ecx
   4215c:	d3 e2                	shl    %cl,%edx
   4215e:	89 d0                	mov    %edx,%eax
   42160:	89 c2                	mov    %eax,%edx
   42162:	0f b6 05 7a e2 00 00 	movzbl 0xe27a(%rip),%eax        # 503e3 <modifiers.1>
   42169:	09 d0                	or     %edx,%eax
   4216b:	88 05 72 e2 00 00    	mov    %al,0xe272(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   42171:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42178:	eb 58                	jmp    421d2 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4217a:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4217e:	7e 31                	jle    421b1 <keyboard_readc+0x1f3>
   42180:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42187:	7f 28                	jg     421b1 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42189:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4218c:	8d 50 80             	lea    -0x80(%rax),%edx
   4218f:	0f b6 05 4d e2 00 00 	movzbl 0xe24d(%rip),%eax        # 503e3 <modifiers.1>
   42196:	0f b6 c0             	movzbl %al,%eax
   42199:	83 e0 03             	and    $0x3,%eax
   4219c:	48 98                	cltq
   4219e:	48 63 d2             	movslq %edx,%rdx
   421a1:	0f b6 84 90 40 52 04 	movzbl 0x45240(%rax,%rdx,4),%eax
   421a8:	00 
   421a9:	0f b6 c0             	movzbl %al,%eax
   421ac:	89 45 fc             	mov    %eax,-0x4(%rbp)
   421af:	eb 21                	jmp    421d2 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   421b1:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   421b5:	7f 1b                	jg     421d2 <keyboard_readc+0x214>
   421b7:	0f b6 05 25 e2 00 00 	movzbl 0xe225(%rip),%eax        # 503e3 <modifiers.1>
   421be:	0f b6 c0             	movzbl %al,%eax
   421c1:	83 e0 02             	and    $0x2,%eax
   421c4:	85 c0                	test   %eax,%eax
   421c6:	74 0a                	je     421d2 <keyboard_readc+0x214>
        ch = 0;
   421c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421cf:	eb 01                	jmp    421d2 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   421d1:	90                   	nop
    }

    return ch;
   421d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   421d5:	c9                   	leave
   421d6:	c3                   	ret

00000000000421d7 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   421d7:	55                   	push   %rbp
   421d8:	48 89 e5             	mov    %rsp,%rbp
   421db:	48 83 ec 20          	sub    $0x20,%rsp
   421df:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421e6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   421e9:	89 c2                	mov    %eax,%edx
   421eb:	ec                   	in     (%dx),%al
   421ec:	88 45 e3             	mov    %al,-0x1d(%rbp)
   421ef:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   421f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   421f9:	89 c2                	mov    %eax,%edx
   421fb:	ec                   	in     (%dx),%al
   421fc:	88 45 eb             	mov    %al,-0x15(%rbp)
   421ff:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42206:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42209:	89 c2                	mov    %eax,%edx
   4220b:	ec                   	in     (%dx),%al
   4220c:	88 45 f3             	mov    %al,-0xd(%rbp)
   4220f:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42216:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42219:	89 c2                	mov    %eax,%edx
   4221b:	ec                   	in     (%dx),%al
   4221c:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4221f:	90                   	nop
   42220:	c9                   	leave
   42221:	c3                   	ret

0000000000042222 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42222:	55                   	push   %rbp
   42223:	48 89 e5             	mov    %rsp,%rbp
   42226:	48 83 ec 40          	sub    $0x40,%rsp
   4222a:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4222e:	89 f0                	mov    %esi,%eax
   42230:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42233:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42236:	8b 05 a8 e1 00 00    	mov    0xe1a8(%rip),%eax        # 503e4 <initialized.0>
   4223c:	85 c0                	test   %eax,%eax
   4223e:	75 1e                	jne    4225e <parallel_port_putc+0x3c>
   42240:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42247:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4224b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4224f:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42252:	ee                   	out    %al,(%dx)
}
   42253:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42254:	c7 05 86 e1 00 00 01 	movl   $0x1,0xe186(%rip)        # 503e4 <initialized.0>
   4225b:	00 00 00 
    }

    for (int i = 0;
   4225e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42265:	eb 09                	jmp    42270 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42267:	e8 6b ff ff ff       	call   421d7 <delay>
         ++i) {
   4226c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42270:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42277:	7f 18                	jg     42291 <parallel_port_putc+0x6f>
   42279:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42280:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42283:	89 c2                	mov    %eax,%edx
   42285:	ec                   	in     (%dx),%al
   42286:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42289:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4228d:	84 c0                	test   %al,%al
   4228f:	79 d6                	jns    42267 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42291:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42295:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4229c:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4229f:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   422a3:	8b 55 d8             	mov    -0x28(%rbp),%edx
   422a6:	ee                   	out    %al,(%dx)
}
   422a7:	90                   	nop
   422a8:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   422af:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422b3:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   422b7:	8b 55 e0             	mov    -0x20(%rbp),%edx
   422ba:	ee                   	out    %al,(%dx)
}
   422bb:	90                   	nop
   422bc:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   422c3:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422c7:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   422cb:	8b 55 e8             	mov    -0x18(%rbp),%edx
   422ce:	ee                   	out    %al,(%dx)
}
   422cf:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   422d0:	90                   	nop
   422d1:	c9                   	leave
   422d2:	c3                   	ret

00000000000422d3 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   422d3:	55                   	push   %rbp
   422d4:	48 89 e5             	mov    %rsp,%rbp
   422d7:	48 83 ec 20          	sub    $0x20,%rsp
   422db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   422df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   422e3:	48 c7 45 f8 22 22 04 	movq   $0x42222,-0x8(%rbp)
   422ea:	00 
    printer_vprintf(&p, 0, format, val);
   422eb:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   422ef:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   422f3:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   422f7:	be 00 00 00 00       	mov    $0x0,%esi
   422fc:	48 89 c7             	mov    %rax,%rdi
   422ff:	e8 00 1d 00 00       	call   44004 <printer_vprintf>
}
   42304:	90                   	nop
   42305:	c9                   	leave
   42306:	c3                   	ret

0000000000042307 <log_printf>:

void log_printf(const char* format, ...) {
   42307:	55                   	push   %rbp
   42308:	48 89 e5             	mov    %rsp,%rbp
   4230b:	48 83 ec 60          	sub    $0x60,%rsp
   4230f:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42313:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42317:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4231b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4231f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42323:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42327:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4232e:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42332:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42336:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4233a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4233e:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42342:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42346:	48 89 d6             	mov    %rdx,%rsi
   42349:	48 89 c7             	mov    %rax,%rdi
   4234c:	e8 82 ff ff ff       	call   422d3 <log_vprintf>
    va_end(val);
}
   42351:	90                   	nop
   42352:	c9                   	leave
   42353:	c3                   	ret

0000000000042354 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42354:	55                   	push   %rbp
   42355:	48 89 e5             	mov    %rsp,%rbp
   42358:	48 83 ec 40          	sub    $0x40,%rsp
   4235c:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4235f:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42362:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42366:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4236a:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4236e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42372:	48 8b 0a             	mov    (%rdx),%rcx
   42375:	48 89 08             	mov    %rcx,(%rax)
   42378:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4237c:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42380:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42384:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42388:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4238c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42390:	48 89 d6             	mov    %rdx,%rsi
   42393:	48 89 c7             	mov    %rax,%rdi
   42396:	e8 38 ff ff ff       	call   422d3 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4239b:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4239f:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   423a3:	8b 75 d8             	mov    -0x28(%rbp),%esi
   423a6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   423a9:	89 c7                	mov    %eax,%edi
   423ab:	e8 03 27 00 00       	call   44ab3 <console_vprintf>
}
   423b0:	c9                   	leave
   423b1:	c3                   	ret

00000000000423b2 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   423b2:	55                   	push   %rbp
   423b3:	48 89 e5             	mov    %rsp,%rbp
   423b6:	48 83 ec 60          	sub    $0x60,%rsp
   423ba:	89 7d ac             	mov    %edi,-0x54(%rbp)
   423bd:	89 75 a8             	mov    %esi,-0x58(%rbp)
   423c0:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   423c4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   423c8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   423cc:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   423d0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   423d7:	48 8d 45 10          	lea    0x10(%rbp),%rax
   423db:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   423df:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   423e3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   423e7:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   423eb:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   423ef:	8b 75 a8             	mov    -0x58(%rbp),%esi
   423f2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   423f5:	89 c7                	mov    %eax,%edi
   423f7:	e8 58 ff ff ff       	call   42354 <error_vprintf>
   423fc:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   423ff:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42402:	c9                   	leave
   42403:	c3                   	ret

0000000000042404 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42404:	55                   	push   %rbp
   42405:	48 89 e5             	mov    %rsp,%rbp
   42408:	53                   	push   %rbx
   42409:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4240d:	e8 ac fb ff ff       	call   41fbe <keyboard_readc>
   42412:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42415:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42419:	74 1c                	je     42437 <check_keyboard+0x33>
   4241b:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   4241f:	74 16                	je     42437 <check_keyboard+0x33>
   42421:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42425:	74 10                	je     42437 <check_keyboard+0x33>
   42427:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4242b:	74 0a                	je     42437 <check_keyboard+0x33>
   4242d:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42431:	0f 85 e9 00 00 00    	jne    42520 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42437:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4243e:	00 
        memset(pt, 0, PAGESIZE * 3);
   4243f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42443:	ba 00 30 00 00       	mov    $0x3000,%edx
   42448:	be 00 00 00 00       	mov    $0x0,%esi
   4244d:	48 89 c7             	mov    %rax,%rdi
   42450:	e8 13 19 00 00       	call   43d68 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42455:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42459:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42460:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42464:	48 05 00 10 00 00    	add    $0x1000,%rax
   4246a:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42471:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42475:	48 05 00 20 00 00    	add    $0x2000,%rax
   4247b:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42482:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42486:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4248a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4248e:	0f 22 d8             	mov    %rax,%cr3
}
   42491:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42492:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   42499:	48 c7 45 e8 98 52 04 	movq   $0x45298,-0x18(%rbp)
   424a0:	00 
        if (c == 'a') {
   424a1:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   424a5:	75 0a                	jne    424b1 <check_keyboard+0xad>
            argument = "allocator";
   424a7:	48 c7 45 e8 9f 52 04 	movq   $0x4529f,-0x18(%rbp)
   424ae:	00 
   424af:	eb 2e                	jmp    424df <check_keyboard+0xdb>
        } else if (c == 'c') {
   424b1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   424b5:	75 0a                	jne    424c1 <check_keyboard+0xbd>
            argument = "alloctests";
   424b7:	48 c7 45 e8 a9 52 04 	movq   $0x452a9,-0x18(%rbp)
   424be:	00 
   424bf:	eb 1e                	jmp    424df <check_keyboard+0xdb>
        } else if(c == 't'){
   424c1:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   424c5:	75 0a                	jne    424d1 <check_keyboard+0xcd>
            argument = "test";
   424c7:	48 c7 45 e8 b4 52 04 	movq   $0x452b4,-0x18(%rbp)
   424ce:	00 
   424cf:	eb 0e                	jmp    424df <check_keyboard+0xdb>
        }
        else if(c == '2'){
   424d1:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   424d5:	75 08                	jne    424df <check_keyboard+0xdb>
            argument = "test2";
   424d7:	48 c7 45 e8 b9 52 04 	movq   $0x452b9,-0x18(%rbp)
   424de:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   424df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   424e3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   424e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   424ec:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   424f0:	73 14                	jae    42506 <check_keyboard+0x102>
   424f2:	ba bf 52 04 00       	mov    $0x452bf,%edx
   424f7:	be 5c 02 00 00       	mov    $0x25c,%esi
   424fc:	bf db 52 04 00       	mov    $0x452db,%edi
   42501:	e8 1f 01 00 00       	call   42625 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42506:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4250a:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4250d:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42511:	48 89 c3             	mov    %rax,%rbx
   42514:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42519:	e9 e2 da ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   4251e:	eb 11                	jmp    42531 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42520:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42524:	74 06                	je     4252c <check_keyboard+0x128>
   42526:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4252a:	75 05                	jne    42531 <check_keyboard+0x12d>
        poweroff();
   4252c:	e8 9d f8 ff ff       	call   41dce <poweroff>
    }
    return c;
   42531:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42534:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42538:	c9                   	leave
   42539:	c3                   	ret

000000000004253a <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4253a:	55                   	push   %rbp
   4253b:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   4253e:	e8 c1 fe ff ff       	call   42404 <check_keyboard>
   42543:	eb f9                	jmp    4253e <fail+0x4>

0000000000042545 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42545:	55                   	push   %rbp
   42546:	48 89 e5             	mov    %rsp,%rbp
   42549:	48 83 ec 60          	sub    $0x60,%rsp
   4254d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42551:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42555:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42559:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4255d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42561:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42565:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4256c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42570:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42574:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42578:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4257c:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42581:	0f 84 80 00 00 00    	je     42607 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42587:	ba ef 52 04 00       	mov    $0x452ef,%edx
   4258c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42591:	bf 30 07 00 00       	mov    $0x730,%edi
   42596:	b8 00 00 00 00       	mov    $0x0,%eax
   4259b:	e8 12 fe ff ff       	call   423b2 <error_printf>
   425a0:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   425a3:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   425a7:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   425ab:	8b 45 cc             	mov    -0x34(%rbp),%eax
   425ae:	be 00 c0 00 00       	mov    $0xc000,%esi
   425b3:	89 c7                	mov    %eax,%edi
   425b5:	e8 9a fd ff ff       	call   42354 <error_vprintf>
   425ba:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   425bd:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   425c0:	48 63 c1             	movslq %ecx,%rax
   425c3:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   425ca:	48 c1 e8 20          	shr    $0x20,%rax
   425ce:	89 c2                	mov    %eax,%edx
   425d0:	c1 fa 05             	sar    $0x5,%edx
   425d3:	89 c8                	mov    %ecx,%eax
   425d5:	c1 f8 1f             	sar    $0x1f,%eax
   425d8:	29 c2                	sub    %eax,%edx
   425da:	89 d0                	mov    %edx,%eax
   425dc:	c1 e0 02             	shl    $0x2,%eax
   425df:	01 d0                	add    %edx,%eax
   425e1:	c1 e0 04             	shl    $0x4,%eax
   425e4:	29 c1                	sub    %eax,%ecx
   425e6:	89 ca                	mov    %ecx,%edx
   425e8:	85 d2                	test   %edx,%edx
   425ea:	74 34                	je     42620 <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   425ec:	8b 45 cc             	mov    -0x34(%rbp),%eax
   425ef:	ba f7 52 04 00       	mov    $0x452f7,%edx
   425f4:	be 00 c0 00 00       	mov    $0xc000,%esi
   425f9:	89 c7                	mov    %eax,%edi
   425fb:	b8 00 00 00 00       	mov    $0x0,%eax
   42600:	e8 ad fd ff ff       	call   423b2 <error_printf>
   42605:	eb 19                	jmp    42620 <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42607:	ba f9 52 04 00       	mov    $0x452f9,%edx
   4260c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42611:	bf 30 07 00 00       	mov    $0x730,%edi
   42616:	b8 00 00 00 00       	mov    $0x0,%eax
   4261b:	e8 92 fd ff ff       	call   423b2 <error_printf>
    }

    va_end(val);
    fail();
   42620:	e8 15 ff ff ff       	call   4253a <fail>

0000000000042625 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42625:	55                   	push   %rbp
   42626:	48 89 e5             	mov    %rsp,%rbp
   42629:	48 83 ec 20          	sub    $0x20,%rsp
   4262d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42631:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42634:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42638:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4263c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4263f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42643:	48 89 c6             	mov    %rax,%rsi
   42646:	bf ff 52 04 00       	mov    $0x452ff,%edi
   4264b:	b8 00 00 00 00       	mov    $0x0,%eax
   42650:	e8 f0 fe ff ff       	call   42545 <kernel_panic>

0000000000042655 <default_exception>:
}

void default_exception(proc* p){
   42655:	55                   	push   %rbp
   42656:	48 89 e5             	mov    %rsp,%rbp
   42659:	48 83 ec 20          	sub    $0x20,%rsp
   4265d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42661:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42665:	48 83 c0 18          	add    $0x18,%rax
   42669:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   4266d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42671:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42678:	48 89 c6             	mov    %rax,%rsi
   4267b:	bf 1d 53 04 00       	mov    $0x4531d,%edi
   42680:	b8 00 00 00 00       	mov    $0x0,%eax
   42685:	e8 bb fe ff ff       	call   42545 <kernel_panic>

000000000004268a <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4268a:	55                   	push   %rbp
   4268b:	48 89 e5             	mov    %rsp,%rbp
   4268e:	48 83 ec 10          	sub    $0x10,%rsp
   42692:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42696:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42699:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4269d:	78 06                	js     426a5 <pageindex+0x1b>
   4269f:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   426a3:	7e 14                	jle    426b9 <pageindex+0x2f>
   426a5:	ba 38 53 04 00       	mov    $0x45338,%edx
   426aa:	be 1e 00 00 00       	mov    $0x1e,%esi
   426af:	bf 51 53 04 00       	mov    $0x45351,%edi
   426b4:	e8 6c ff ff ff       	call   42625 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   426b9:	b8 03 00 00 00       	mov    $0x3,%eax
   426be:	2b 45 f4             	sub    -0xc(%rbp),%eax
   426c1:	89 c2                	mov    %eax,%edx
   426c3:	89 d0                	mov    %edx,%eax
   426c5:	c1 e0 03             	shl    $0x3,%eax
   426c8:	01 d0                	add    %edx,%eax
   426ca:	83 c0 0c             	add    $0xc,%eax
   426cd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   426d1:	89 c1                	mov    %eax,%ecx
   426d3:	48 d3 ea             	shr    %cl,%rdx
   426d6:	48 89 d0             	mov    %rdx,%rax
   426d9:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   426de:	c9                   	leave
   426df:	c3                   	ret

00000000000426e0 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   426e0:	55                   	push   %rbp
   426e1:	48 89 e5             	mov    %rsp,%rbp
   426e4:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   426e8:	48 c7 05 0d e9 00 00 	movq   $0x52000,0xe90d(%rip)        # 51000 <kernel_pagetable>
   426ef:	00 20 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   426f3:	ba 00 50 00 00       	mov    $0x5000,%edx
   426f8:	be 00 00 00 00       	mov    $0x0,%esi
   426fd:	bf 00 20 05 00       	mov    $0x52000,%edi
   42702:	e8 61 16 00 00       	call   43d68 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42707:	b8 00 30 05 00       	mov    $0x53000,%eax
   4270c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42710:	48 89 05 e9 f8 00 00 	mov    %rax,0xf8e9(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42717:	b8 00 40 05 00       	mov    $0x54000,%eax
   4271c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42720:	48 89 05 d9 08 01 00 	mov    %rax,0x108d9(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42727:	b8 00 50 05 00       	mov    $0x55000,%eax
   4272c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42730:	48 89 05 c9 18 01 00 	mov    %rax,0x118c9(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42737:	b8 00 60 05 00       	mov    $0x56000,%eax
   4273c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42740:	48 89 05 c1 18 01 00 	mov    %rax,0x118c1(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42747:	48 8b 05 b2 e8 00 00 	mov    0xe8b2(%rip),%rax        # 51000 <kernel_pagetable>
   4274e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42754:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42759:	ba 00 00 00 00       	mov    $0x0,%edx
   4275e:	be 00 00 00 00       	mov    $0x0,%esi
   42763:	48 89 c7             	mov    %rax,%rdi
   42766:	e8 b9 01 00 00       	call   42924 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4276b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42772:	00 
   42773:	eb 62                	jmp    427d7 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42775:	48 8b 0d 84 e8 00 00 	mov    0xe884(%rip),%rcx        # 51000 <kernel_pagetable>
   4277c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42780:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42784:	48 89 ce             	mov    %rcx,%rsi
   42787:	48 89 c7             	mov    %rax,%rdi
   4278a:	e8 58 05 00 00       	call   42ce7 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   4278f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42793:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42797:	74 14                	je     427ad <virtual_memory_init+0xcd>
   42799:	ba 65 53 04 00       	mov    $0x45365,%edx
   4279e:	be 2d 00 00 00       	mov    $0x2d,%esi
   427a3:	bf 75 53 04 00       	mov    $0x45375,%edi
   427a8:	e8 78 fe ff ff       	call   42625 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   427ad:	8b 45 f0             	mov    -0x10(%rbp),%eax
   427b0:	48 98                	cltq
   427b2:	83 e0 03             	and    $0x3,%eax
   427b5:	48 83 f8 03          	cmp    $0x3,%rax
   427b9:	74 14                	je     427cf <virtual_memory_init+0xef>
   427bb:	ba 88 53 04 00       	mov    $0x45388,%edx
   427c0:	be 2e 00 00 00       	mov    $0x2e,%esi
   427c5:	bf 75 53 04 00       	mov    $0x45375,%edi
   427ca:	e8 56 fe ff ff       	call   42625 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   427cf:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   427d6:	00 
   427d7:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   427de:	00 
   427df:	76 94                	jbe    42775 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   427e1:	48 8b 05 18 e8 00 00 	mov    0xe818(%rip),%rax        # 51000 <kernel_pagetable>
   427e8:	48 89 c7             	mov    %rax,%rdi
   427eb:	e8 03 00 00 00       	call   427f3 <set_pagetable>
}
   427f0:	90                   	nop
   427f1:	c9                   	leave
   427f2:	c3                   	ret

00000000000427f3 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   427f3:	55                   	push   %rbp
   427f4:	48 89 e5             	mov    %rsp,%rbp
   427f7:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   427fb:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   427ff:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42803:	25 ff 0f 00 00       	and    $0xfff,%eax
   42808:	48 85 c0             	test   %rax,%rax
   4280b:	74 14                	je     42821 <set_pagetable+0x2e>
   4280d:	ba b5 53 04 00       	mov    $0x453b5,%edx
   42812:	be 3d 00 00 00       	mov    $0x3d,%esi
   42817:	bf 75 53 04 00       	mov    $0x45375,%edi
   4281c:	e8 04 fe ff ff       	call   42625 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42821:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42826:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   4282a:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4282e:	48 89 ce             	mov    %rcx,%rsi
   42831:	48 89 c7             	mov    %rax,%rdi
   42834:	e8 ae 04 00 00       	call   42ce7 <virtual_memory_lookup>
   42839:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4283d:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42842:	48 39 d0             	cmp    %rdx,%rax
   42845:	74 14                	je     4285b <set_pagetable+0x68>
   42847:	ba d0 53 04 00       	mov    $0x453d0,%edx
   4284c:	be 3f 00 00 00       	mov    $0x3f,%esi
   42851:	bf 75 53 04 00       	mov    $0x45375,%edi
   42856:	e8 ca fd ff ff       	call   42625 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4285b:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   4285f:	48 8b 0d 9a e7 00 00 	mov    0xe79a(%rip),%rcx        # 51000 <kernel_pagetable>
   42866:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4286a:	48 89 ce             	mov    %rcx,%rsi
   4286d:	48 89 c7             	mov    %rax,%rdi
   42870:	e8 72 04 00 00       	call   42ce7 <virtual_memory_lookup>
   42875:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42879:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4287d:	48 39 c2             	cmp    %rax,%rdx
   42880:	74 14                	je     42896 <set_pagetable+0xa3>
   42882:	ba 38 54 04 00       	mov    $0x45438,%edx
   42887:	be 41 00 00 00       	mov    $0x41,%esi
   4288c:	bf 75 53 04 00       	mov    $0x45375,%edi
   42891:	e8 8f fd ff ff       	call   42625 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42896:	48 8b 05 63 e7 00 00 	mov    0xe763(%rip),%rax        # 51000 <kernel_pagetable>
   4289d:	48 89 c2             	mov    %rax,%rdx
   428a0:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   428a4:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   428a8:	48 89 ce             	mov    %rcx,%rsi
   428ab:	48 89 c7             	mov    %rax,%rdi
   428ae:	e8 34 04 00 00       	call   42ce7 <virtual_memory_lookup>
   428b3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   428b7:	48 8b 15 42 e7 00 00 	mov    0xe742(%rip),%rdx        # 51000 <kernel_pagetable>
   428be:	48 39 d0             	cmp    %rdx,%rax
   428c1:	74 14                	je     428d7 <set_pagetable+0xe4>
   428c3:	ba 98 54 04 00       	mov    $0x45498,%edx
   428c8:	be 43 00 00 00       	mov    $0x43,%esi
   428cd:	bf 75 53 04 00       	mov    $0x45375,%edi
   428d2:	e8 4e fd ff ff       	call   42625 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   428d7:	ba 24 29 04 00       	mov    $0x42924,%edx
   428dc:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   428e0:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   428e4:	48 89 ce             	mov    %rcx,%rsi
   428e7:	48 89 c7             	mov    %rax,%rdi
   428ea:	e8 f8 03 00 00       	call   42ce7 <virtual_memory_lookup>
   428ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428f3:	ba 24 29 04 00       	mov    $0x42924,%edx
   428f8:	48 39 d0             	cmp    %rdx,%rax
   428fb:	74 14                	je     42911 <set_pagetable+0x11e>
   428fd:	ba 00 55 04 00       	mov    $0x45500,%edx
   42902:	be 45 00 00 00       	mov    $0x45,%esi
   42907:	bf 75 53 04 00       	mov    $0x45375,%edi
   4290c:	e8 14 fd ff ff       	call   42625 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42911:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42915:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42919:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4291d:	0f 22 d8             	mov    %rax,%cr3
}
   42920:	90                   	nop
}
   42921:	90                   	nop
   42922:	c9                   	leave
   42923:	c3                   	ret

0000000000042924 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42924:	55                   	push   %rbp
   42925:	48 89 e5             	mov    %rsp,%rbp
   42928:	53                   	push   %rbx
   42929:	48 83 ec 58          	sub    $0x58,%rsp
   4292d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42931:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42935:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42939:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   4293d:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42941:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42945:	25 ff 0f 00 00       	and    $0xfff,%eax
   4294a:	48 85 c0             	test   %rax,%rax
   4294d:	74 14                	je     42963 <virtual_memory_map+0x3f>
   4294f:	ba 66 55 04 00       	mov    $0x45566,%edx
   42954:	be 66 00 00 00       	mov    $0x66,%esi
   42959:	bf 75 53 04 00       	mov    $0x45375,%edi
   4295e:	e8 c2 fc ff ff       	call   42625 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42963:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42967:	25 ff 0f 00 00       	and    $0xfff,%eax
   4296c:	48 85 c0             	test   %rax,%rax
   4296f:	74 14                	je     42985 <virtual_memory_map+0x61>
   42971:	ba 79 55 04 00       	mov    $0x45579,%edx
   42976:	be 67 00 00 00       	mov    $0x67,%esi
   4297b:	bf 75 53 04 00       	mov    $0x45375,%edi
   42980:	e8 a0 fc ff ff       	call   42625 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42985:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42989:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4298d:	48 01 d0             	add    %rdx,%rax
   42990:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42994:	73 24                	jae    429ba <virtual_memory_map+0x96>
   42996:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4299a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4299e:	48 01 d0             	add    %rdx,%rax
   429a1:	48 85 c0             	test   %rax,%rax
   429a4:	74 14                	je     429ba <virtual_memory_map+0x96>
   429a6:	ba 8c 55 04 00       	mov    $0x4558c,%edx
   429ab:	be 68 00 00 00       	mov    $0x68,%esi
   429b0:	bf 75 53 04 00       	mov    $0x45375,%edi
   429b5:	e8 6b fc ff ff       	call   42625 <assert_fail>
    if (perm & PTE_P) {
   429ba:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429bd:	48 98                	cltq
   429bf:	83 e0 01             	and    $0x1,%eax
   429c2:	48 85 c0             	test   %rax,%rax
   429c5:	74 6e                	je     42a35 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   429c7:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   429cb:	25 ff 0f 00 00       	and    $0xfff,%eax
   429d0:	48 85 c0             	test   %rax,%rax
   429d3:	74 14                	je     429e9 <virtual_memory_map+0xc5>
   429d5:	ba aa 55 04 00       	mov    $0x455aa,%edx
   429da:	be 6a 00 00 00       	mov    $0x6a,%esi
   429df:	bf 75 53 04 00       	mov    $0x45375,%edi
   429e4:	e8 3c fc ff ff       	call   42625 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   429e9:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   429ed:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   429f1:	48 01 d0             	add    %rdx,%rax
   429f4:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   429f8:	73 14                	jae    42a0e <virtual_memory_map+0xea>
   429fa:	ba bd 55 04 00       	mov    $0x455bd,%edx
   429ff:	be 6b 00 00 00       	mov    $0x6b,%esi
   42a04:	bf 75 53 04 00       	mov    $0x45375,%edi
   42a09:	e8 17 fc ff ff       	call   42625 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42a0e:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42a12:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a16:	48 01 d0             	add    %rdx,%rax
   42a19:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42a1f:	76 14                	jbe    42a35 <virtual_memory_map+0x111>
   42a21:	ba cb 55 04 00       	mov    $0x455cb,%edx
   42a26:	be 6c 00 00 00       	mov    $0x6c,%esi
   42a2b:	bf 75 53 04 00       	mov    $0x45375,%edi
   42a30:	e8 f0 fb ff ff       	call   42625 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42a35:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42a39:	78 09                	js     42a44 <virtual_memory_map+0x120>
   42a3b:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42a42:	7e 14                	jle    42a58 <virtual_memory_map+0x134>
   42a44:	ba e7 55 04 00       	mov    $0x455e7,%edx
   42a49:	be 6e 00 00 00       	mov    $0x6e,%esi
   42a4e:	bf 75 53 04 00       	mov    $0x45375,%edi
   42a53:	e8 cd fb ff ff       	call   42625 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42a58:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a5c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a61:	48 85 c0             	test   %rax,%rax
   42a64:	74 14                	je     42a7a <virtual_memory_map+0x156>
   42a66:	ba 08 56 04 00       	mov    $0x45608,%edx
   42a6b:	be 6f 00 00 00       	mov    $0x6f,%esi
   42a70:	bf 75 53 04 00       	mov    $0x45375,%edi
   42a75:	e8 ab fb ff ff       	call   42625 <assert_fail>

    int last_index123 = -1;
   42a7a:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42a81:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42a88:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42a89:	e9 e1 00 00 00       	jmp    42b6f <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42a8e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a92:	48 c1 e8 15          	shr    $0x15,%rax
   42a96:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42a99:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a9c:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42a9f:	74 20                	je     42ac1 <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42aa1:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42aa4:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42aa8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42aac:	48 89 ce             	mov    %rcx,%rsi
   42aaf:	48 89 c7             	mov    %rax,%rdi
   42ab2:	e8 ce 00 00 00       	call   42b85 <lookup_l4pagetable>
   42ab7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42abb:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42abe:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42ac1:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ac4:	48 98                	cltq
   42ac6:	83 e0 01             	and    $0x1,%eax
   42ac9:	48 85 c0             	test   %rax,%rax
   42acc:	74 34                	je     42b02 <virtual_memory_map+0x1de>
   42ace:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42ad3:	74 2d                	je     42b02 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42ad5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ad8:	48 63 d8             	movslq %eax,%rbx
   42adb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42adf:	be 03 00 00 00       	mov    $0x3,%esi
   42ae4:	48 89 c7             	mov    %rax,%rdi
   42ae7:	e8 9e fb ff ff       	call   4268a <pageindex>
   42aec:	89 c2                	mov    %eax,%edx
   42aee:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42af2:	48 89 d9             	mov    %rbx,%rcx
   42af5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42af9:	48 63 d2             	movslq %edx,%rdx
   42afc:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42b00:	eb 55                	jmp    42b57 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42b02:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42b07:	74 26                	je     42b2f <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42b09:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42b0d:	be 03 00 00 00       	mov    $0x3,%esi
   42b12:	48 89 c7             	mov    %rax,%rdi
   42b15:	e8 70 fb ff ff       	call   4268a <pageindex>
   42b1a:	89 c2                	mov    %eax,%edx
   42b1c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b1f:	48 63 c8             	movslq %eax,%rcx
   42b22:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42b26:	48 63 d2             	movslq %edx,%rdx
   42b29:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42b2d:	eb 28                	jmp    42b57 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42b2f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b32:	48 98                	cltq
   42b34:	83 e0 01             	and    $0x1,%eax
   42b37:	48 85 c0             	test   %rax,%rax
   42b3a:	74 1b                	je     42b57 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b3c:	be 84 00 00 00       	mov    $0x84,%esi
   42b41:	bf 30 56 04 00       	mov    $0x45630,%edi
   42b46:	b8 00 00 00 00       	mov    $0x0,%eax
   42b4b:	e8 b7 f7 ff ff       	call   42307 <log_printf>
            return -1;
   42b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42b55:	eb 28                	jmp    42b7f <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42b57:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42b5e:	00 
   42b5f:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42b66:	00 
   42b67:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42b6e:	00 
   42b6f:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42b74:	0f 85 14 ff ff ff    	jne    42a8e <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42b7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42b7f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42b83:	c9                   	leave
   42b84:	c3                   	ret

0000000000042b85 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42b85:	55                   	push   %rbp
   42b86:	48 89 e5             	mov    %rsp,%rbp
   42b89:	48 83 ec 40          	sub    $0x40,%rsp
   42b8d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b91:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42b95:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42b98:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b9c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42ba0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42ba7:	e9 2b 01 00 00       	jmp    42cd7 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42bac:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42baf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42bb3:	89 d6                	mov    %edx,%esi
   42bb5:	48 89 c7             	mov    %rax,%rdi
   42bb8:	e8 cd fa ff ff       	call   4268a <pageindex>
   42bbd:	89 c2                	mov    %eax,%edx
   42bbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42bc3:	48 63 d2             	movslq %edx,%rdx
   42bc6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42bca:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42bce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bd2:	83 e0 01             	and    $0x1,%eax
   42bd5:	48 85 c0             	test   %rax,%rax
   42bd8:	75 63                	jne    42c3d <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42bda:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42bdd:	8d 48 02             	lea    0x2(%rax),%ecx
   42be0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42be4:	25 ff 0f 00 00       	and    $0xfff,%eax
   42be9:	48 89 c2             	mov    %rax,%rdx
   42bec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bf0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42bf6:	48 89 c6             	mov    %rax,%rsi
   42bf9:	bf 78 56 04 00       	mov    $0x45678,%edi
   42bfe:	b8 00 00 00 00       	mov    $0x0,%eax
   42c03:	e8 ff f6 ff ff       	call   42307 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42c08:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c0b:	48 98                	cltq
   42c0d:	83 e0 01             	and    $0x1,%eax
   42c10:	48 85 c0             	test   %rax,%rax
   42c13:	75 0a                	jne    42c1f <lookup_l4pagetable+0x9a>
                return NULL;
   42c15:	b8 00 00 00 00       	mov    $0x0,%eax
   42c1a:	e9 c6 00 00 00       	jmp    42ce5 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42c1f:	be a7 00 00 00       	mov    $0xa7,%esi
   42c24:	bf e0 56 04 00       	mov    $0x456e0,%edi
   42c29:	b8 00 00 00 00       	mov    $0x0,%eax
   42c2e:	e8 d4 f6 ff ff       	call   42307 <log_printf>
            return NULL;
   42c33:	b8 00 00 00 00       	mov    $0x0,%eax
   42c38:	e9 a8 00 00 00       	jmp    42ce5 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42c3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c41:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c47:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42c4d:	76 14                	jbe    42c63 <lookup_l4pagetable+0xde>
   42c4f:	ba 28 57 04 00       	mov    $0x45728,%edx
   42c54:	be ac 00 00 00       	mov    $0xac,%esi
   42c59:	bf 75 53 04 00       	mov    $0x45375,%edi
   42c5e:	e8 c2 f9 ff ff       	call   42625 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42c63:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c66:	48 98                	cltq
   42c68:	83 e0 02             	and    $0x2,%eax
   42c6b:	48 85 c0             	test   %rax,%rax
   42c6e:	74 20                	je     42c90 <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42c70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c74:	83 e0 02             	and    $0x2,%eax
   42c77:	48 85 c0             	test   %rax,%rax
   42c7a:	75 14                	jne    42c90 <lookup_l4pagetable+0x10b>
   42c7c:	ba 48 57 04 00       	mov    $0x45748,%edx
   42c81:	be ae 00 00 00       	mov    $0xae,%esi
   42c86:	bf 75 53 04 00       	mov    $0x45375,%edi
   42c8b:	e8 95 f9 ff ff       	call   42625 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42c90:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c93:	48 98                	cltq
   42c95:	83 e0 04             	and    $0x4,%eax
   42c98:	48 85 c0             	test   %rax,%rax
   42c9b:	74 20                	je     42cbd <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42c9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ca1:	83 e0 04             	and    $0x4,%eax
   42ca4:	48 85 c0             	test   %rax,%rax
   42ca7:	75 14                	jne    42cbd <lookup_l4pagetable+0x138>
   42ca9:	ba 53 57 04 00       	mov    $0x45753,%edx
   42cae:	be b1 00 00 00       	mov    $0xb1,%esi
   42cb3:	bf 75 53 04 00       	mov    $0x45375,%edi
   42cb8:	e8 68 f9 ff ff       	call   42625 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42cbd:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42cc4:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42cc5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cc9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ccf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42cd3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42cd7:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42cdb:	0f 8e cb fe ff ff    	jle    42bac <lookup_l4pagetable+0x27>
    }
    return pt;
   42ce1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42ce5:	c9                   	leave
   42ce6:	c3                   	ret

0000000000042ce7 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42ce7:	55                   	push   %rbp
   42ce8:	48 89 e5             	mov    %rsp,%rbp
   42ceb:	48 83 ec 50          	sub    $0x50,%rsp
   42cef:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42cf3:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42cf7:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42cfb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42cff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42d03:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42d0a:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42d0b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42d12:	eb 41                	jmp    42d55 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42d14:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42d17:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d1b:	89 d6                	mov    %edx,%esi
   42d1d:	48 89 c7             	mov    %rax,%rdi
   42d20:	e8 65 f9 ff ff       	call   4268a <pageindex>
   42d25:	89 c2                	mov    %eax,%edx
   42d27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d2b:	48 63 d2             	movslq %edx,%rdx
   42d2e:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42d32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d36:	83 e0 06             	and    $0x6,%eax
   42d39:	48 f7 d0             	not    %rax
   42d3c:	48 21 d0             	and    %rdx,%rax
   42d3f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42d43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d47:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d4d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42d51:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42d55:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42d59:	7f 0c                	jg     42d67 <virtual_memory_lookup+0x80>
   42d5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d5f:	83 e0 01             	and    $0x1,%eax
   42d62:	48 85 c0             	test   %rax,%rax
   42d65:	75 ad                	jne    42d14 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42d67:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42d6e:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42d75:	ff 
   42d76:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42d7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d81:	83 e0 01             	and    $0x1,%eax
   42d84:	48 85 c0             	test   %rax,%rax
   42d87:	74 34                	je     42dbd <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42d89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d8d:	48 c1 e8 0c          	shr    $0xc,%rax
   42d91:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42d94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d98:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d9e:	48 89 c2             	mov    %rax,%rdx
   42da1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42da5:	25 ff 0f 00 00       	and    $0xfff,%eax
   42daa:	48 09 d0             	or     %rdx,%rax
   42dad:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42db1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42db5:	25 ff 0f 00 00       	and    $0xfff,%eax
   42dba:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42dbd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42dc1:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42dc5:	48 89 10             	mov    %rdx,(%rax)
   42dc8:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42dcc:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42dd0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42dd4:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42dd8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ddc:	c9                   	leave
   42ddd:	c3                   	ret

0000000000042dde <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42dde:	55                   	push   %rbp
   42ddf:	48 89 e5             	mov    %rsp,%rbp
   42de2:	48 83 ec 40          	sub    $0x40,%rsp
   42de6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42dea:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42ded:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42df1:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42df8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42dfc:	78 08                	js     42e06 <program_load+0x28>
   42dfe:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42e01:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42e04:	7c 14                	jl     42e1a <program_load+0x3c>
   42e06:	ba 60 57 04 00       	mov    $0x45760,%edx
   42e0b:	be 2e 00 00 00       	mov    $0x2e,%esi
   42e10:	bf 90 57 04 00       	mov    $0x45790,%edi
   42e15:	e8 0b f8 ff ff       	call   42625 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42e1a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42e1d:	48 98                	cltq
   42e1f:	48 c1 e0 04          	shl    $0x4,%rax
   42e23:	48 05 20 60 04 00    	add    $0x46020,%rax
   42e29:	48 8b 00             	mov    (%rax),%rax
   42e2c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42e30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e34:	8b 00                	mov    (%rax),%eax
   42e36:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42e3b:	74 14                	je     42e51 <program_load+0x73>
   42e3d:	ba a2 57 04 00       	mov    $0x457a2,%edx
   42e42:	be 30 00 00 00       	mov    $0x30,%esi
   42e47:	bf 90 57 04 00       	mov    $0x45790,%edi
   42e4c:	e8 d4 f7 ff ff       	call   42625 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42e51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e55:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42e59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e5d:	48 01 d0             	add    %rdx,%rax
   42e60:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42e6b:	e9 94 00 00 00       	jmp    42f04 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42e70:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e73:	48 63 d0             	movslq %eax,%rdx
   42e76:	48 89 d0             	mov    %rdx,%rax
   42e79:	48 c1 e0 03          	shl    $0x3,%rax
   42e7d:	48 29 d0             	sub    %rdx,%rax
   42e80:	48 c1 e0 03          	shl    $0x3,%rax
   42e84:	48 89 c2             	mov    %rax,%rdx
   42e87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e8b:	48 01 d0             	add    %rdx,%rax
   42e8e:	8b 00                	mov    (%rax),%eax
   42e90:	83 f8 01             	cmp    $0x1,%eax
   42e93:	75 6b                	jne    42f00 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42e95:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e98:	48 63 d0             	movslq %eax,%rdx
   42e9b:	48 89 d0             	mov    %rdx,%rax
   42e9e:	48 c1 e0 03          	shl    $0x3,%rax
   42ea2:	48 29 d0             	sub    %rdx,%rax
   42ea5:	48 c1 e0 03          	shl    $0x3,%rax
   42ea9:	48 89 c2             	mov    %rax,%rdx
   42eac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42eb0:	48 01 d0             	add    %rdx,%rax
   42eb3:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42eb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ebb:	48 01 d0             	add    %rdx,%rax
   42ebe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42ec2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42ec5:	48 63 d0             	movslq %eax,%rdx
   42ec8:	48 89 d0             	mov    %rdx,%rax
   42ecb:	48 c1 e0 03          	shl    $0x3,%rax
   42ecf:	48 29 d0             	sub    %rdx,%rax
   42ed2:	48 c1 e0 03          	shl    $0x3,%rax
   42ed6:	48 89 c2             	mov    %rax,%rdx
   42ed9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42edd:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42ee1:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42ee5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42ee9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42eed:	48 89 c7             	mov    %rax,%rdi
   42ef0:	e8 3d 00 00 00       	call   42f32 <program_load_segment>
   42ef5:	85 c0                	test   %eax,%eax
   42ef7:	79 07                	jns    42f00 <program_load+0x122>
                return -1;
   42ef9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42efe:	eb 30                	jmp    42f30 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42f00:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42f04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f08:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42f0c:	0f b7 c0             	movzwl %ax,%eax
   42f0f:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42f12:	0f 8c 58 ff ff ff    	jl     42e70 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42f18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f1c:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42f20:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f24:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42f2b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f30:	c9                   	leave
   42f31:	c3                   	ret

0000000000042f32 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42f32:	55                   	push   %rbp
   42f33:	48 89 e5             	mov    %rsp,%rbp
   42f36:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42f3a:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   42f3e:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   42f42:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   42f46:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42f4a:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   42f4e:	48 8b 40 10          	mov    0x10(%rax),%rax
   42f52:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42f56:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   42f5a:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42f5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f62:	48 01 d0             	add    %rdx,%rax
   42f65:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42f69:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   42f6d:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42f71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f75:	48 01 d0             	add    %rdx,%rax
   42f78:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42f7c:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42f83:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42f8c:	eb 7c                	jmp    4300a <program_load_segment+0xd8>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42f8e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   42f92:	8b 00                	mov    (%rax),%eax
   42f94:	89 c7                	mov    %eax,%edi
   42f96:	e8 9b 01 00 00       	call   43136 <palloc>
   42f9b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42f9f:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   42fa4:	74 2a                	je     42fd0 <program_load_segment+0x9e>
   42fa6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   42faa:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42fb1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42fb5:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42fb9:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42fbf:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42fc4:	48 89 c7             	mov    %rax,%rdi
   42fc7:	e8 58 f9 ff ff       	call   42924 <virtual_memory_map>
   42fcc:	85 c0                	test   %eax,%eax
   42fce:	79 32                	jns    43002 <program_load_segment+0xd0>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42fd0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   42fd4:	8b 00                	mov    (%rax),%eax
   42fd6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42fda:	49 89 d0             	mov    %rdx,%r8
   42fdd:	89 c1                	mov    %eax,%ecx
   42fdf:	ba c0 57 04 00       	mov    $0x457c0,%edx
   42fe4:	be 00 c0 00 00       	mov    $0xc000,%esi
   42fe9:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42fee:	b8 00 00 00 00       	mov    $0x0,%eax
   42ff3:	e8 27 1b 00 00       	call   44b1f <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42ff8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ffd:	e9 32 01 00 00       	jmp    43134 <program_load_segment+0x202>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43002:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43009:	00 
   4300a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4300e:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43012:	0f 82 76 ff ff ff    	jb     42f8e <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43018:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4301c:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43023:	48 89 c7             	mov    %rax,%rdi
   43026:	e8 c8 f7 ff ff       	call   427f3 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   4302b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4302f:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   43033:	48 89 c2             	mov    %rax,%rdx
   43036:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4303a:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4303e:	48 89 ce             	mov    %rcx,%rsi
   43041:	48 89 c7             	mov    %rax,%rdi
   43044:	e8 21 0c 00 00       	call   43c6a <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43049:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4304d:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43051:	48 89 c2             	mov    %rax,%rdx
   43054:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43058:	be 00 00 00 00       	mov    $0x0,%esi
   4305d:	48 89 c7             	mov    %rax,%rdi
   43060:	e8 03 0d 00 00       	call   43d68 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43065:	48 8b 05 94 df 00 00 	mov    0xdf94(%rip),%rax        # 51000 <kernel_pagetable>
   4306c:	48 89 c7             	mov    %rax,%rdi
   4306f:	e8 7f f7 ff ff       	call   427f3 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   43074:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43078:	8b 40 04             	mov    0x4(%rax),%eax
   4307b:	83 e0 02             	and    $0x2,%eax
   4307e:	85 c0                	test   %eax,%eax
   43080:	75 60                	jne    430e2 <program_load_segment+0x1b0>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43082:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43086:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4308a:	eb 4c                	jmp    430d8 <program_load_segment+0x1a6>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   4308c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43090:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   43097:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   4309b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4309f:	48 89 ce             	mov    %rcx,%rsi
   430a2:	48 89 c7             	mov    %rax,%rdi
   430a5:	e8 3d fc ff ff       	call   42ce7 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   430aa:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   430ae:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   430b2:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   430b9:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   430bd:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   430c3:	b9 00 10 00 00       	mov    $0x1000,%ecx
   430c8:	48 89 c7             	mov    %rax,%rdi
   430cb:	e8 54 f8 ff ff       	call   42924 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430d0:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   430d7:	00 
   430d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430dc:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   430e0:	72 aa                	jb     4308c <program_load_segment+0x15a>
    // TODO : Add code here
    // we first have to set up where the
    //initial position of the break pointer
    // it should start

    p->original_break = ROUNDUP(end_mem, PAGESIZE);
   430e2:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   430e9:	00 
   430ea:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   430ee:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430f2:	48 01 d0             	add    %rdx,%rax
   430f5:	48 83 e8 01          	sub    $0x1,%rax
   430f9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   430fd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43101:	ba 00 00 00 00       	mov    $0x0,%edx
   43106:	48 f7 75 d0          	divq   -0x30(%rbp)
   4310a:	48 89 d1             	mov    %rdx,%rcx
   4310d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43111:	48 29 c8             	sub    %rcx,%rax
   43114:	48 89 c2             	mov    %rax,%rdx
   43117:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4311b:	48 89 50 10          	mov    %rdx,0x10(%rax)
    // this will set to the end of text etc..
    p->program_break = p->original_break; 
   4311f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43123:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43127:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4312b:	48 89 50 08          	mov    %rdx,0x8(%rax)
    // this well set current break to 
    return 0;
   4312f:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43134:	c9                   	leave
   43135:	c3                   	ret

0000000000043136 <palloc>:
   43136:	55                   	push   %rbp
   43137:	48 89 e5             	mov    %rsp,%rbp
   4313a:	48 83 ec 20          	sub    $0x20,%rsp
   4313e:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43141:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43148:	00 
   43149:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4314d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43151:	e9 95 00 00 00       	jmp    431eb <palloc+0xb5>
   43156:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4315a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4315e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43165:	00 
   43166:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4316a:	48 c1 e8 0c          	shr    $0xc,%rax
   4316e:	48 98                	cltq
   43170:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   43177:	00 
   43178:	84 c0                	test   %al,%al
   4317a:	75 6f                	jne    431eb <palloc+0xb5>
   4317c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43180:	48 c1 e8 0c          	shr    $0xc,%rax
   43184:	48 98                	cltq
   43186:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4318d:	00 
   4318e:	84 c0                	test   %al,%al
   43190:	75 59                	jne    431eb <palloc+0xb5>
   43192:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43196:	48 c1 e8 0c          	shr    $0xc,%rax
   4319a:	89 c2                	mov    %eax,%edx
   4319c:	48 63 c2             	movslq %edx,%rax
   4319f:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   431a6:	00 
   431a7:	83 c0 01             	add    $0x1,%eax
   431aa:	89 c1                	mov    %eax,%ecx
   431ac:	48 63 c2             	movslq %edx,%rax
   431af:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   431b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431ba:	48 c1 e8 0c          	shr    $0xc,%rax
   431be:	89 c1                	mov    %eax,%ecx
   431c0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   431c3:	89 c2                	mov    %eax,%edx
   431c5:	48 63 c1             	movslq %ecx,%rax
   431c8:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
   431cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431d3:	ba 00 10 00 00       	mov    $0x1000,%edx
   431d8:	be cc 00 00 00       	mov    $0xcc,%esi
   431dd:	48 89 c7             	mov    %rax,%rdi
   431e0:	e8 83 0b 00 00       	call   43d68 <memset>
   431e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431e9:	eb 2c                	jmp    43217 <palloc+0xe1>
   431eb:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   431f2:	00 
   431f3:	0f 86 5d ff ff ff    	jbe    43156 <palloc+0x20>
   431f9:	ba f8 57 04 00       	mov    $0x457f8,%edx
   431fe:	be 00 0c 00 00       	mov    $0xc00,%esi
   43203:	bf 80 07 00 00       	mov    $0x780,%edi
   43208:	b8 00 00 00 00       	mov    $0x0,%eax
   4320d:	e8 0d 19 00 00       	call   44b1f <console_printf>
   43212:	b8 00 00 00 00       	mov    $0x0,%eax
   43217:	c9                   	leave
   43218:	c3                   	ret

0000000000043219 <palloc_target>:
   43219:	55                   	push   %rbp
   4321a:	48 89 e5             	mov    %rsp,%rbp
   4321d:	48 8b 05 dc 3d 01 00 	mov    0x13ddc(%rip),%rax        # 57000 <palloc_target_proc>
   43224:	48 85 c0             	test   %rax,%rax
   43227:	75 14                	jne    4323d <palloc_target+0x24>
   43229:	ba 11 58 04 00       	mov    $0x45811,%edx
   4322e:	be 27 00 00 00       	mov    $0x27,%esi
   43233:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   43238:	e8 e8 f3 ff ff       	call   42625 <assert_fail>
   4323d:	48 8b 05 bc 3d 01 00 	mov    0x13dbc(%rip),%rax        # 57000 <palloc_target_proc>
   43244:	8b 00                	mov    (%rax),%eax
   43246:	89 c7                	mov    %eax,%edi
   43248:	e8 e9 fe ff ff       	call   43136 <palloc>
   4324d:	5d                   	pop    %rbp
   4324e:	c3                   	ret

000000000004324f <process_free>:
   4324f:	55                   	push   %rbp
   43250:	48 89 e5             	mov    %rsp,%rbp
   43253:	48 83 ec 60          	sub    $0x60,%rsp
   43257:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4325a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4325d:	48 63 d0             	movslq %eax,%rdx
   43260:	48 89 d0             	mov    %rdx,%rax
   43263:	48 c1 e0 04          	shl    $0x4,%rax
   43267:	48 29 d0             	sub    %rdx,%rax
   4326a:	48 c1 e0 04          	shl    $0x4,%rax
   4326e:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43274:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   4327a:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43281:	00 
   43282:	e9 ad 00 00 00       	jmp    43334 <process_free+0xe5>
   43287:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4328a:	48 63 d0             	movslq %eax,%rdx
   4328d:	48 89 d0             	mov    %rdx,%rax
   43290:	48 c1 e0 04          	shl    $0x4,%rax
   43294:	48 29 d0             	sub    %rdx,%rax
   43297:	48 c1 e0 04          	shl    $0x4,%rax
   4329b:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   432a1:	48 8b 08             	mov    (%rax),%rcx
   432a4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   432a8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   432ac:	48 89 ce             	mov    %rcx,%rsi
   432af:	48 89 c7             	mov    %rax,%rdi
   432b2:	e8 30 fa ff ff       	call   42ce7 <virtual_memory_lookup>
   432b7:	8b 45 c8             	mov    -0x38(%rbp),%eax
   432ba:	48 98                	cltq
   432bc:	83 e0 01             	and    $0x1,%eax
   432bf:	48 85 c0             	test   %rax,%rax
   432c2:	74 68                	je     4332c <process_free+0xdd>
   432c4:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432c7:	48 63 d0             	movslq %eax,%rdx
   432ca:	0f b6 94 12 21 ef 04 	movzbl 0x4ef21(%rdx,%rdx,1),%edx
   432d1:	00 
   432d2:	83 ea 01             	sub    $0x1,%edx
   432d5:	48 98                	cltq
   432d7:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
   432de:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432e1:	48 98                	cltq
   432e3:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   432ea:	00 
   432eb:	84 c0                	test   %al,%al
   432ed:	75 0f                	jne    432fe <process_free+0xaf>
   432ef:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432f2:	48 98                	cltq
   432f4:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   432fb:	00 
   432fc:	eb 2e                	jmp    4332c <process_free+0xdd>
   432fe:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43301:	48 98                	cltq
   43303:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   4330a:	00 
   4330b:	0f be c0             	movsbl %al,%eax
   4330e:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43311:	75 19                	jne    4332c <process_free+0xdd>
   43313:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43317:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4331a:	48 89 c6             	mov    %rax,%rsi
   4331d:	bf 38 58 04 00       	mov    $0x45838,%edi
   43322:	b8 00 00 00 00       	mov    $0x0,%eax
   43327:	e8 db ef ff ff       	call   42307 <log_printf>
   4332c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43333:	00 
   43334:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4333b:	00 
   4333c:	0f 86 45 ff ff ff    	jbe    43287 <process_free+0x38>
   43342:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43345:	48 63 d0             	movslq %eax,%rdx
   43348:	48 89 d0             	mov    %rdx,%rax
   4334b:	48 c1 e0 04          	shl    $0x4,%rax
   4334f:	48 29 d0             	sub    %rdx,%rax
   43352:	48 c1 e0 04          	shl    $0x4,%rax
   43356:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   4335c:	48 8b 00             	mov    (%rax),%rax
   4335f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43363:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43367:	48 8b 00             	mov    (%rax),%rax
   4336a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43370:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43374:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43378:	48 8b 00             	mov    (%rax),%rax
   4337b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43381:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43385:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43389:	48 8b 00             	mov    (%rax),%rax
   4338c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43392:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43396:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4339a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4339e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   433a4:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   433a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433ac:	48 c1 e8 0c          	shr    $0xc,%rax
   433b0:	48 98                	cltq
   433b2:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   433b9:	00 
   433ba:	3c 01                	cmp    $0x1,%al
   433bc:	74 14                	je     433d2 <process_free+0x183>
   433be:	ba 70 58 04 00       	mov    $0x45870,%edx
   433c3:	be 4f 00 00 00       	mov    $0x4f,%esi
   433c8:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   433cd:	e8 53 f2 ff ff       	call   42625 <assert_fail>
   433d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433d6:	48 c1 e8 0c          	shr    $0xc,%rax
   433da:	48 98                	cltq
   433dc:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   433e3:	00 
   433e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433e8:	48 c1 e8 0c          	shr    $0xc,%rax
   433ec:	48 98                	cltq
   433ee:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   433f5:	00 
   433f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433fa:	48 c1 e8 0c          	shr    $0xc,%rax
   433fe:	48 98                	cltq
   43400:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43407:	00 
   43408:	3c 01                	cmp    $0x1,%al
   4340a:	74 14                	je     43420 <process_free+0x1d1>
   4340c:	ba 98 58 04 00       	mov    $0x45898,%edx
   43411:	be 52 00 00 00       	mov    $0x52,%esi
   43416:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   4341b:	e8 05 f2 ff ff       	call   42625 <assert_fail>
   43420:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43424:	48 c1 e8 0c          	shr    $0xc,%rax
   43428:	48 98                	cltq
   4342a:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43431:	00 
   43432:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43436:	48 c1 e8 0c          	shr    $0xc,%rax
   4343a:	48 98                	cltq
   4343c:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43443:	00 
   43444:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43448:	48 c1 e8 0c          	shr    $0xc,%rax
   4344c:	48 98                	cltq
   4344e:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43455:	00 
   43456:	3c 01                	cmp    $0x1,%al
   43458:	74 14                	je     4346e <process_free+0x21f>
   4345a:	ba c0 58 04 00       	mov    $0x458c0,%edx
   4345f:	be 55 00 00 00       	mov    $0x55,%esi
   43464:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   43469:	e8 b7 f1 ff ff       	call   42625 <assert_fail>
   4346e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43472:	48 c1 e8 0c          	shr    $0xc,%rax
   43476:	48 98                	cltq
   43478:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4347f:	00 
   43480:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43484:	48 c1 e8 0c          	shr    $0xc,%rax
   43488:	48 98                	cltq
   4348a:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43491:	00 
   43492:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43496:	48 c1 e8 0c          	shr    $0xc,%rax
   4349a:	48 98                	cltq
   4349c:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   434a3:	00 
   434a4:	3c 01                	cmp    $0x1,%al
   434a6:	74 14                	je     434bc <process_free+0x26d>
   434a8:	ba e8 58 04 00       	mov    $0x458e8,%edx
   434ad:	be 58 00 00 00       	mov    $0x58,%esi
   434b2:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   434b7:	e8 69 f1 ff ff       	call   42625 <assert_fail>
   434bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434c0:	48 c1 e8 0c          	shr    $0xc,%rax
   434c4:	48 98                	cltq
   434c6:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   434cd:	00 
   434ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434d2:	48 c1 e8 0c          	shr    $0xc,%rax
   434d6:	48 98                	cltq
   434d8:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   434df:	00 
   434e0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434e4:	48 c1 e8 0c          	shr    $0xc,%rax
   434e8:	48 98                	cltq
   434ea:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   434f1:	00 
   434f2:	3c 01                	cmp    $0x1,%al
   434f4:	74 14                	je     4350a <process_free+0x2bb>
   434f6:	ba 10 59 04 00       	mov    $0x45910,%edx
   434fb:	be 5b 00 00 00       	mov    $0x5b,%esi
   43500:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   43505:	e8 1b f1 ff ff       	call   42625 <assert_fail>
   4350a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4350e:	48 c1 e8 0c          	shr    $0xc,%rax
   43512:	48 98                	cltq
   43514:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4351b:	00 
   4351c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43520:	48 c1 e8 0c          	shr    $0xc,%rax
   43524:	48 98                	cltq
   43526:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4352d:	00 
   4352e:	90                   	nop
   4352f:	c9                   	leave
   43530:	c3                   	ret

0000000000043531 <process_config_tables>:
   43531:	55                   	push   %rbp
   43532:	48 89 e5             	mov    %rsp,%rbp
   43535:	48 83 ec 40          	sub    $0x40,%rsp
   43539:	89 7d cc             	mov    %edi,-0x34(%rbp)
   4353c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4353f:	89 c7                	mov    %eax,%edi
   43541:	e8 f0 fb ff ff       	call   43136 <palloc>
   43546:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4354a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4354d:	89 c7                	mov    %eax,%edi
   4354f:	e8 e2 fb ff ff       	call   43136 <palloc>
   43554:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43558:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4355b:	89 c7                	mov    %eax,%edi
   4355d:	e8 d4 fb ff ff       	call   43136 <palloc>
   43562:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43566:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43569:	89 c7                	mov    %eax,%edi
   4356b:	e8 c6 fb ff ff       	call   43136 <palloc>
   43570:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43574:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43577:	89 c7                	mov    %eax,%edi
   43579:	e8 b8 fb ff ff       	call   43136 <palloc>
   4357e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43582:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43587:	74 20                	je     435a9 <process_config_tables+0x78>
   43589:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4358e:	74 19                	je     435a9 <process_config_tables+0x78>
   43590:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43595:	74 12                	je     435a9 <process_config_tables+0x78>
   43597:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4359c:	74 0b                	je     435a9 <process_config_tables+0x78>
   4359e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   435a3:	0f 85 e1 00 00 00    	jne    4368a <process_config_tables+0x159>
   435a9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   435ae:	74 24                	je     435d4 <process_config_tables+0xa3>
   435b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435b4:	48 c1 e8 0c          	shr    $0xc,%rax
   435b8:	48 98                	cltq
   435ba:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   435c1:	00 
   435c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435c6:	48 c1 e8 0c          	shr    $0xc,%rax
   435ca:	48 98                	cltq
   435cc:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   435d3:	00 
   435d4:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   435d9:	74 24                	je     435ff <process_config_tables+0xce>
   435db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435df:	48 c1 e8 0c          	shr    $0xc,%rax
   435e3:	48 98                	cltq
   435e5:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   435ec:	00 
   435ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435f1:	48 c1 e8 0c          	shr    $0xc,%rax
   435f5:	48 98                	cltq
   435f7:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   435fe:	00 
   435ff:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43604:	74 24                	je     4362a <process_config_tables+0xf9>
   43606:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4360a:	48 c1 e8 0c          	shr    $0xc,%rax
   4360e:	48 98                	cltq
   43610:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43617:	00 
   43618:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4361c:	48 c1 e8 0c          	shr    $0xc,%rax
   43620:	48 98                	cltq
   43622:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43629:	00 
   4362a:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4362f:	74 24                	je     43655 <process_config_tables+0x124>
   43631:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43635:	48 c1 e8 0c          	shr    $0xc,%rax
   43639:	48 98                	cltq
   4363b:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43642:	00 
   43643:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43647:	48 c1 e8 0c          	shr    $0xc,%rax
   4364b:	48 98                	cltq
   4364d:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43654:	00 
   43655:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4365a:	74 24                	je     43680 <process_config_tables+0x14f>
   4365c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43660:	48 c1 e8 0c          	shr    $0xc,%rax
   43664:	48 98                	cltq
   43666:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4366d:	00 
   4366e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43672:	48 c1 e8 0c          	shr    $0xc,%rax
   43676:	48 98                	cltq
   43678:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4367f:	00 
   43680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43685:	e9 f3 01 00 00       	jmp    4387d <process_config_tables+0x34c>
   4368a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4368e:	ba 00 10 00 00       	mov    $0x1000,%edx
   43693:	be 00 00 00 00       	mov    $0x0,%esi
   43698:	48 89 c7             	mov    %rax,%rdi
   4369b:	e8 c8 06 00 00       	call   43d68 <memset>
   436a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436a4:	ba 00 10 00 00       	mov    $0x1000,%edx
   436a9:	be 00 00 00 00       	mov    $0x0,%esi
   436ae:	48 89 c7             	mov    %rax,%rdi
   436b1:	e8 b2 06 00 00       	call   43d68 <memset>
   436b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436ba:	ba 00 10 00 00       	mov    $0x1000,%edx
   436bf:	be 00 00 00 00       	mov    $0x0,%esi
   436c4:	48 89 c7             	mov    %rax,%rdi
   436c7:	e8 9c 06 00 00       	call   43d68 <memset>
   436cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   436d0:	ba 00 10 00 00       	mov    $0x1000,%edx
   436d5:	be 00 00 00 00       	mov    $0x0,%esi
   436da:	48 89 c7             	mov    %rax,%rdi
   436dd:	e8 86 06 00 00       	call   43d68 <memset>
   436e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436e6:	ba 00 10 00 00       	mov    $0x1000,%edx
   436eb:	be 00 00 00 00       	mov    $0x0,%esi
   436f0:	48 89 c7             	mov    %rax,%rdi
   436f3:	e8 70 06 00 00       	call   43d68 <memset>
   436f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436fc:	48 83 c8 07          	or     $0x7,%rax
   43700:	48 89 c2             	mov    %rax,%rdx
   43703:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43707:	48 89 10             	mov    %rdx,(%rax)
   4370a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4370e:	48 83 c8 07          	or     $0x7,%rax
   43712:	48 89 c2             	mov    %rax,%rdx
   43715:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43719:	48 89 10             	mov    %rdx,(%rax)
   4371c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43720:	48 83 c8 07          	or     $0x7,%rax
   43724:	48 89 c2             	mov    %rax,%rdx
   43727:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4372b:	48 89 10             	mov    %rdx,(%rax)
   4372e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43732:	48 83 c8 07          	or     $0x7,%rax
   43736:	48 89 c2             	mov    %rax,%rdx
   43739:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4373d:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43741:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43745:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4374b:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   43751:	b9 00 00 10 00       	mov    $0x100000,%ecx
   43756:	ba 00 00 00 00       	mov    $0x0,%edx
   4375b:	be 00 00 00 00       	mov    $0x0,%esi
   43760:	48 89 c7             	mov    %rax,%rdi
   43763:	e8 bc f1 ff ff       	call   42924 <virtual_memory_map>
   43768:	85 c0                	test   %eax,%eax
   4376a:	75 2f                	jne    4379b <process_config_tables+0x26a>
   4376c:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   43771:	be 00 80 0b 00       	mov    $0xb8000,%esi
   43776:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4377a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43780:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43786:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4378b:	48 89 c7             	mov    %rax,%rdi
   4378e:	e8 91 f1 ff ff       	call   42924 <virtual_memory_map>
   43793:	85 c0                	test   %eax,%eax
   43795:	0f 84 bb 00 00 00    	je     43856 <process_config_tables+0x325>
   4379b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4379f:	48 c1 e8 0c          	shr    $0xc,%rax
   437a3:	48 98                	cltq
   437a5:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   437ac:	00 
   437ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437b1:	48 c1 e8 0c          	shr    $0xc,%rax
   437b5:	48 98                	cltq
   437b7:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   437be:	00 
   437bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437c3:	48 c1 e8 0c          	shr    $0xc,%rax
   437c7:	48 98                	cltq
   437c9:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   437d0:	00 
   437d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437d5:	48 c1 e8 0c          	shr    $0xc,%rax
   437d9:	48 98                	cltq
   437db:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   437e2:	00 
   437e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437e7:	48 c1 e8 0c          	shr    $0xc,%rax
   437eb:	48 98                	cltq
   437ed:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   437f4:	00 
   437f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437f9:	48 c1 e8 0c          	shr    $0xc,%rax
   437fd:	48 98                	cltq
   437ff:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43806:	00 
   43807:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4380b:	48 c1 e8 0c          	shr    $0xc,%rax
   4380f:	48 98                	cltq
   43811:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43818:	00 
   43819:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4381d:	48 c1 e8 0c          	shr    $0xc,%rax
   43821:	48 98                	cltq
   43823:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4382a:	00 
   4382b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4382f:	48 c1 e8 0c          	shr    $0xc,%rax
   43833:	48 98                	cltq
   43835:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4383c:	00 
   4383d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43841:	48 c1 e8 0c          	shr    $0xc,%rax
   43845:	48 98                	cltq
   43847:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4384e:	00 
   4384f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43854:	eb 27                	jmp    4387d <process_config_tables+0x34c>
   43856:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43859:	48 63 d0             	movslq %eax,%rdx
   4385c:	48 89 d0             	mov    %rdx,%rax
   4385f:	48 c1 e0 04          	shl    $0x4,%rax
   43863:	48 29 d0             	sub    %rdx,%rax
   43866:	48 c1 e0 04          	shl    $0x4,%rax
   4386a:	48 8d 90 e0 e0 04 00 	lea    0x4e0e0(%rax),%rdx
   43871:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43875:	48 89 02             	mov    %rax,(%rdx)
   43878:	b8 00 00 00 00       	mov    $0x0,%eax
   4387d:	c9                   	leave
   4387e:	c3                   	ret

000000000004387f <process_load>:
   4387f:	55                   	push   %rbp
   43880:	48 89 e5             	mov    %rsp,%rbp
   43883:	48 83 ec 20          	sub    $0x20,%rsp
   43887:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4388b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4388e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43892:	48 89 05 67 37 01 00 	mov    %rax,0x13767(%rip)        # 57000 <palloc_target_proc>
   43899:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   4389c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438a0:	ba 19 32 04 00       	mov    $0x43219,%edx
   438a5:	89 ce                	mov    %ecx,%esi
   438a7:	48 89 c7             	mov    %rax,%rdi
   438aa:	e8 2f f5 ff ff       	call   42dde <program_load>
   438af:	89 45 fc             	mov    %eax,-0x4(%rbp)
   438b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   438b5:	c9                   	leave
   438b6:	c3                   	ret

00000000000438b7 <process_setup_stack>:
   438b7:	55                   	push   %rbp
   438b8:	48 89 e5             	mov    %rsp,%rbp
   438bb:	48 83 ec 20          	sub    $0x20,%rsp
   438bf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   438c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438c7:	8b 00                	mov    (%rax),%eax
   438c9:	89 c7                	mov    %eax,%edi
   438cb:	e8 66 f8 ff ff       	call   43136 <palloc>
   438d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   438d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438d8:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   438df:	00 00 30 00 
   438e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438e7:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   438ee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   438f2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   438f8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   438fe:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43903:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43908:	48 89 c7             	mov    %rax,%rdi
   4390b:	e8 14 f0 ff ff       	call   42924 <virtual_memory_map>
   43910:	90                   	nop
   43911:	c9                   	leave
   43912:	c3                   	ret

0000000000043913 <find_free_pid>:
   43913:	55                   	push   %rbp
   43914:	48 89 e5             	mov    %rsp,%rbp
   43917:	48 83 ec 10          	sub    $0x10,%rsp
   4391b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43922:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43929:	eb 24                	jmp    4394f <find_free_pid+0x3c>
   4392b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4392e:	48 63 d0             	movslq %eax,%rdx
   43931:	48 89 d0             	mov    %rdx,%rax
   43934:	48 c1 e0 04          	shl    $0x4,%rax
   43938:	48 29 d0             	sub    %rdx,%rax
   4393b:	48 c1 e0 04          	shl    $0x4,%rax
   4393f:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43945:	8b 00                	mov    (%rax),%eax
   43947:	85 c0                	test   %eax,%eax
   43949:	74 0c                	je     43957 <find_free_pid+0x44>
   4394b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4394f:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   43953:	7e d6                	jle    4392b <find_free_pid+0x18>
   43955:	eb 01                	jmp    43958 <find_free_pid+0x45>
   43957:	90                   	nop
   43958:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4395c:	74 05                	je     43963 <find_free_pid+0x50>
   4395e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43961:	eb 05                	jmp    43968 <find_free_pid+0x55>
   43963:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43968:	c9                   	leave
   43969:	c3                   	ret

000000000004396a <process_fork>:
   4396a:	55                   	push   %rbp
   4396b:	48 89 e5             	mov    %rsp,%rbp
   4396e:	48 83 ec 40          	sub    $0x40,%rsp
   43972:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43976:	b8 00 00 00 00       	mov    $0x0,%eax
   4397b:	e8 93 ff ff ff       	call   43913 <find_free_pid>
   43980:	89 45 f4             	mov    %eax,-0xc(%rbp)
   43983:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   43987:	75 0a                	jne    43993 <process_fork+0x29>
   43989:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4398e:	e9 67 02 00 00       	jmp    43bfa <process_fork+0x290>
   43993:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43996:	48 63 d0             	movslq %eax,%rdx
   43999:	48 89 d0             	mov    %rdx,%rax
   4399c:	48 c1 e0 04          	shl    $0x4,%rax
   439a0:	48 29 d0             	sub    %rdx,%rax
   439a3:	48 c1 e0 04          	shl    $0x4,%rax
   439a7:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   439ad:	be 00 00 00 00       	mov    $0x0,%esi
   439b2:	48 89 c7             	mov    %rax,%rdi
   439b5:	e8 9d e4 ff ff       	call   41e57 <process_init>
   439ba:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439bd:	89 c7                	mov    %eax,%edi
   439bf:	e8 6d fb ff ff       	call   43531 <process_config_tables>
   439c4:	83 f8 ff             	cmp    $0xffffffff,%eax
   439c7:	75 0a                	jne    439d3 <process_fork+0x69>
   439c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   439ce:	e9 27 02 00 00       	jmp    43bfa <process_fork+0x290>
   439d3:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   439da:	00 
   439db:	e9 79 01 00 00       	jmp    43b59 <process_fork+0x1ef>
   439e0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   439e4:	8b 00                	mov    (%rax),%eax
   439e6:	48 63 d0             	movslq %eax,%rdx
   439e9:	48 89 d0             	mov    %rdx,%rax
   439ec:	48 c1 e0 04          	shl    $0x4,%rax
   439f0:	48 29 d0             	sub    %rdx,%rax
   439f3:	48 c1 e0 04          	shl    $0x4,%rax
   439f7:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   439fd:	48 8b 08             	mov    (%rax),%rcx
   43a00:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43a04:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43a08:	48 89 ce             	mov    %rcx,%rsi
   43a0b:	48 89 c7             	mov    %rax,%rdi
   43a0e:	e8 d4 f2 ff ff       	call   42ce7 <virtual_memory_lookup>
   43a13:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43a16:	48 98                	cltq
   43a18:	83 e0 07             	and    $0x7,%eax
   43a1b:	48 83 f8 07          	cmp    $0x7,%rax
   43a1f:	0f 85 a1 00 00 00    	jne    43ac6 <process_fork+0x15c>
   43a25:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a28:	89 c7                	mov    %eax,%edi
   43a2a:	e8 07 f7 ff ff       	call   43136 <palloc>
   43a2f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43a33:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43a38:	75 14                	jne    43a4e <process_fork+0xe4>
   43a3a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a3d:	89 c7                	mov    %eax,%edi
   43a3f:	e8 0b f8 ff ff       	call   4324f <process_free>
   43a44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a49:	e9 ac 01 00 00       	jmp    43bfa <process_fork+0x290>
   43a4e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a52:	48 89 c1             	mov    %rax,%rcx
   43a55:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a59:	ba 00 10 00 00       	mov    $0x1000,%edx
   43a5e:	48 89 ce             	mov    %rcx,%rsi
   43a61:	48 89 c7             	mov    %rax,%rdi
   43a64:	e8 01 02 00 00       	call   43c6a <memcpy>
   43a69:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   43a6d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a70:	48 63 d0             	movslq %eax,%rdx
   43a73:	48 89 d0             	mov    %rdx,%rax
   43a76:	48 c1 e0 04          	shl    $0x4,%rax
   43a7a:	48 29 d0             	sub    %rdx,%rax
   43a7d:	48 c1 e0 04          	shl    $0x4,%rax
   43a81:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43a87:	48 8b 00             	mov    (%rax),%rax
   43a8a:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43a8e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a94:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43a9a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a9f:	48 89 fa             	mov    %rdi,%rdx
   43aa2:	48 89 c7             	mov    %rax,%rdi
   43aa5:	e8 7a ee ff ff       	call   42924 <virtual_memory_map>
   43aaa:	85 c0                	test   %eax,%eax
   43aac:	0f 84 9f 00 00 00    	je     43b51 <process_fork+0x1e7>
   43ab2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ab5:	89 c7                	mov    %eax,%edi
   43ab7:	e8 93 f7 ff ff       	call   4324f <process_free>
   43abc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43ac1:	e9 34 01 00 00       	jmp    43bfa <process_fork+0x290>
   43ac6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43ac9:	48 98                	cltq
   43acb:	83 e0 05             	and    $0x5,%eax
   43ace:	48 83 f8 05          	cmp    $0x5,%rax
   43ad2:	75 7d                	jne    43b51 <process_fork+0x1e7>
   43ad4:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43ad8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43adb:	48 63 d0             	movslq %eax,%rdx
   43ade:	48 89 d0             	mov    %rdx,%rax
   43ae1:	48 c1 e0 04          	shl    $0x4,%rax
   43ae5:	48 29 d0             	sub    %rdx,%rax
   43ae8:	48 c1 e0 04          	shl    $0x4,%rax
   43aec:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43af2:	48 8b 00             	mov    (%rax),%rax
   43af5:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43af9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43aff:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43b05:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43b0a:	48 89 fa             	mov    %rdi,%rdx
   43b0d:	48 89 c7             	mov    %rax,%rdi
   43b10:	e8 0f ee ff ff       	call   42924 <virtual_memory_map>
   43b15:	85 c0                	test   %eax,%eax
   43b17:	74 14                	je     43b2d <process_fork+0x1c3>
   43b19:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b1c:	89 c7                	mov    %eax,%edi
   43b1e:	e8 2c f7 ff ff       	call   4324f <process_free>
   43b23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b28:	e9 cd 00 00 00       	jmp    43bfa <process_fork+0x290>
   43b2d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b31:	48 c1 e8 0c          	shr    $0xc,%rax
   43b35:	89 c2                	mov    %eax,%edx
   43b37:	48 63 c2             	movslq %edx,%rax
   43b3a:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43b41:	00 
   43b42:	83 c0 01             	add    $0x1,%eax
   43b45:	89 c1                	mov    %eax,%ecx
   43b47:	48 63 c2             	movslq %edx,%rax
   43b4a:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   43b51:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43b58:	00 
   43b59:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43b60:	00 
   43b61:	0f 86 79 fe ff ff    	jbe    439e0 <process_fork+0x76>
   43b67:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43b6b:	8b 08                	mov    (%rax),%ecx
   43b6d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b70:	48 63 d0             	movslq %eax,%rdx
   43b73:	48 89 d0             	mov    %rdx,%rax
   43b76:	48 c1 e0 04          	shl    $0x4,%rax
   43b7a:	48 29 d0             	sub    %rdx,%rax
   43b7d:	48 c1 e0 04          	shl    $0x4,%rax
   43b81:	48 8d b0 10 e0 04 00 	lea    0x4e010(%rax),%rsi
   43b88:	48 63 d1             	movslq %ecx,%rdx
   43b8b:	48 89 d0             	mov    %rdx,%rax
   43b8e:	48 c1 e0 04          	shl    $0x4,%rax
   43b92:	48 29 d0             	sub    %rdx,%rax
   43b95:	48 c1 e0 04          	shl    $0x4,%rax
   43b99:	48 8d 90 10 e0 04 00 	lea    0x4e010(%rax),%rdx
   43ba0:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43ba4:	48 83 c2 08          	add    $0x8,%rdx
   43ba8:	b9 18 00 00 00       	mov    $0x18,%ecx
   43bad:	48 89 c7             	mov    %rax,%rdi
   43bb0:	48 89 d6             	mov    %rdx,%rsi
   43bb3:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43bb6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43bb9:	48 63 d0             	movslq %eax,%rdx
   43bbc:	48 89 d0             	mov    %rdx,%rax
   43bbf:	48 c1 e0 04          	shl    $0x4,%rax
   43bc3:	48 29 d0             	sub    %rdx,%rax
   43bc6:	48 c1 e0 04          	shl    $0x4,%rax
   43bca:	48 05 18 e0 04 00    	add    $0x4e018,%rax
   43bd0:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43bd7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43bda:	48 63 d0             	movslq %eax,%rdx
   43bdd:	48 89 d0             	mov    %rdx,%rax
   43be0:	48 c1 e0 04          	shl    $0x4,%rax
   43be4:	48 29 d0             	sub    %rdx,%rax
   43be7:	48 c1 e0 04          	shl    $0x4,%rax
   43beb:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43bf1:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43bf7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43bfa:	c9                   	leave
   43bfb:	c3                   	ret

0000000000043bfc <process_page_alloc>:
   43bfc:	55                   	push   %rbp
   43bfd:	48 89 e5             	mov    %rsp,%rbp
   43c00:	48 83 ec 20          	sub    $0x20,%rsp
   43c04:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c08:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c0c:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43c13:	00 
   43c14:	77 07                	ja     43c1d <process_page_alloc+0x21>
   43c16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c1b:	eb 4b                	jmp    43c68 <process_page_alloc+0x6c>
   43c1d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c21:	8b 00                	mov    (%rax),%eax
   43c23:	89 c7                	mov    %eax,%edi
   43c25:	e8 0c f5 ff ff       	call   43136 <palloc>
   43c2a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c2e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43c33:	74 2e                	je     43c63 <process_page_alloc+0x67>
   43c35:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c3d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43c44:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43c48:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43c4e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43c54:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43c59:	48 89 c7             	mov    %rax,%rdi
   43c5c:	e8 c3 ec ff ff       	call   42924 <virtual_memory_map>
   43c61:	eb 05                	jmp    43c68 <process_page_alloc+0x6c>
   43c63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c68:	c9                   	leave
   43c69:	c3                   	ret

0000000000043c6a <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43c6a:	55                   	push   %rbp
   43c6b:	48 89 e5             	mov    %rsp,%rbp
   43c6e:	48 83 ec 28          	sub    $0x28,%rsp
   43c72:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c76:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c7a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43c7e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c82:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43c86:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c8a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43c8e:	eb 1c                	jmp    43cac <memcpy+0x42>
        *d = *s;
   43c90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c94:	0f b6 10             	movzbl (%rax),%edx
   43c97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c9b:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43c9d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43ca2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43ca7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43cac:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43cb1:	75 dd                	jne    43c90 <memcpy+0x26>
    }
    return dst;
   43cb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43cb7:	c9                   	leave
   43cb8:	c3                   	ret

0000000000043cb9 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43cb9:	55                   	push   %rbp
   43cba:	48 89 e5             	mov    %rsp,%rbp
   43cbd:	48 83 ec 28          	sub    $0x28,%rsp
   43cc1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cc5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43cc9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43ccd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43cd1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43cd5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cd9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ce1:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43ce5:	73 6a                	jae    43d51 <memmove+0x98>
   43ce7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43ceb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cef:	48 01 d0             	add    %rdx,%rax
   43cf2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43cf6:	73 59                	jae    43d51 <memmove+0x98>
        s += n, d += n;
   43cf8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cfc:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43d00:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d04:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43d08:	eb 17                	jmp    43d21 <memmove+0x68>
            *--d = *--s;
   43d0a:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43d0f:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43d14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d18:	0f b6 10             	movzbl (%rax),%edx
   43d1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d1f:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43d21:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d25:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43d29:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43d2d:	48 85 c0             	test   %rax,%rax
   43d30:	75 d8                	jne    43d0a <memmove+0x51>
    if (s < d && s + n > d) {
   43d32:	eb 2e                	jmp    43d62 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43d34:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43d38:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43d3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43d40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d44:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d48:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43d4c:	0f b6 12             	movzbl (%rdx),%edx
   43d4f:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43d51:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d55:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43d59:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43d5d:	48 85 c0             	test   %rax,%rax
   43d60:	75 d2                	jne    43d34 <memmove+0x7b>
        }
    }
    return dst;
   43d62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d66:	c9                   	leave
   43d67:	c3                   	ret

0000000000043d68 <memset>:

void* memset(void* v, int c, size_t n) {
   43d68:	55                   	push   %rbp
   43d69:	48 89 e5             	mov    %rsp,%rbp
   43d6c:	48 83 ec 28          	sub    $0x28,%rsp
   43d70:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d74:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43d77:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43d7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43d83:	eb 15                	jmp    43d9a <memset+0x32>
        *p = c;
   43d85:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43d88:	89 c2                	mov    %eax,%edx
   43d8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d8e:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43d90:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43d95:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43d9a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43d9f:	75 e4                	jne    43d85 <memset+0x1d>
    }
    return v;
   43da1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43da5:	c9                   	leave
   43da6:	c3                   	ret

0000000000043da7 <strlen>:

size_t strlen(const char* s) {
   43da7:	55                   	push   %rbp
   43da8:	48 89 e5             	mov    %rsp,%rbp
   43dab:	48 83 ec 18          	sub    $0x18,%rsp
   43daf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43db3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43dba:	00 
   43dbb:	eb 0a                	jmp    43dc7 <strlen+0x20>
        ++n;
   43dbd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43dc2:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43dc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43dcb:	0f b6 00             	movzbl (%rax),%eax
   43dce:	84 c0                	test   %al,%al
   43dd0:	75 eb                	jne    43dbd <strlen+0x16>
    }
    return n;
   43dd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43dd6:	c9                   	leave
   43dd7:	c3                   	ret

0000000000043dd8 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43dd8:	55                   	push   %rbp
   43dd9:	48 89 e5             	mov    %rsp,%rbp
   43ddc:	48 83 ec 20          	sub    $0x20,%rsp
   43de0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43de4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43de8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43def:	00 
   43df0:	eb 0a                	jmp    43dfc <strnlen+0x24>
        ++n;
   43df2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43df7:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43dfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e00:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43e04:	74 0b                	je     43e11 <strnlen+0x39>
   43e06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e0a:	0f b6 00             	movzbl (%rax),%eax
   43e0d:	84 c0                	test   %al,%al
   43e0f:	75 e1                	jne    43df2 <strnlen+0x1a>
    }
    return n;
   43e11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43e15:	c9                   	leave
   43e16:	c3                   	ret

0000000000043e17 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43e17:	55                   	push   %rbp
   43e18:	48 89 e5             	mov    %rsp,%rbp
   43e1b:	48 83 ec 20          	sub    $0x20,%rsp
   43e1f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43e23:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43e27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e2b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43e2f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43e33:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43e37:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43e3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e3f:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43e43:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43e47:	0f b6 12             	movzbl (%rdx),%edx
   43e4a:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43e4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e50:	48 83 e8 01          	sub    $0x1,%rax
   43e54:	0f b6 00             	movzbl (%rax),%eax
   43e57:	84 c0                	test   %al,%al
   43e59:	75 d4                	jne    43e2f <strcpy+0x18>
    return dst;
   43e5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43e5f:	c9                   	leave
   43e60:	c3                   	ret

0000000000043e61 <strcmp>:

int strcmp(const char* a, const char* b) {
   43e61:	55                   	push   %rbp
   43e62:	48 89 e5             	mov    %rsp,%rbp
   43e65:	48 83 ec 10          	sub    $0x10,%rsp
   43e69:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43e6d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43e71:	eb 0a                	jmp    43e7d <strcmp+0x1c>
        ++a, ++b;
   43e73:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43e78:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43e7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e81:	0f b6 00             	movzbl (%rax),%eax
   43e84:	84 c0                	test   %al,%al
   43e86:	74 1d                	je     43ea5 <strcmp+0x44>
   43e88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e8c:	0f b6 00             	movzbl (%rax),%eax
   43e8f:	84 c0                	test   %al,%al
   43e91:	74 12                	je     43ea5 <strcmp+0x44>
   43e93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e97:	0f b6 10             	movzbl (%rax),%edx
   43e9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e9e:	0f b6 00             	movzbl (%rax),%eax
   43ea1:	38 c2                	cmp    %al,%dl
   43ea3:	74 ce                	je     43e73 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43ea5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ea9:	0f b6 00             	movzbl (%rax),%eax
   43eac:	89 c2                	mov    %eax,%edx
   43eae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43eb2:	0f b6 00             	movzbl (%rax),%eax
   43eb5:	38 d0                	cmp    %dl,%al
   43eb7:	0f 92 c0             	setb   %al
   43eba:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43ebd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ec1:	0f b6 00             	movzbl (%rax),%eax
   43ec4:	89 c1                	mov    %eax,%ecx
   43ec6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43eca:	0f b6 00             	movzbl (%rax),%eax
   43ecd:	38 c1                	cmp    %al,%cl
   43ecf:	0f 92 c0             	setb   %al
   43ed2:	0f b6 c0             	movzbl %al,%eax
   43ed5:	29 c2                	sub    %eax,%edx
   43ed7:	89 d0                	mov    %edx,%eax
}
   43ed9:	c9                   	leave
   43eda:	c3                   	ret

0000000000043edb <strchr>:

char* strchr(const char* s, int c) {
   43edb:	55                   	push   %rbp
   43edc:	48 89 e5             	mov    %rsp,%rbp
   43edf:	48 83 ec 10          	sub    $0x10,%rsp
   43ee3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43ee7:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43eea:	eb 05                	jmp    43ef1 <strchr+0x16>
        ++s;
   43eec:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43ef1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ef5:	0f b6 00             	movzbl (%rax),%eax
   43ef8:	84 c0                	test   %al,%al
   43efa:	74 0e                	je     43f0a <strchr+0x2f>
   43efc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f00:	0f b6 00             	movzbl (%rax),%eax
   43f03:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43f06:	38 d0                	cmp    %dl,%al
   43f08:	75 e2                	jne    43eec <strchr+0x11>
    }
    if (*s == (char) c) {
   43f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f0e:	0f b6 00             	movzbl (%rax),%eax
   43f11:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43f14:	38 d0                	cmp    %dl,%al
   43f16:	75 06                	jne    43f1e <strchr+0x43>
        return (char*) s;
   43f18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f1c:	eb 05                	jmp    43f23 <strchr+0x48>
    } else {
        return NULL;
   43f1e:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43f23:	c9                   	leave
   43f24:	c3                   	ret

0000000000043f25 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43f25:	55                   	push   %rbp
   43f26:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43f29:	8b 05 d9 30 01 00    	mov    0x130d9(%rip),%eax        # 57008 <rand_seed_set>
   43f2f:	85 c0                	test   %eax,%eax
   43f31:	75 0a                	jne    43f3d <rand+0x18>
        srand(819234718U);
   43f33:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43f38:	e8 24 00 00 00       	call   43f61 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43f3d:	8b 05 c9 30 01 00    	mov    0x130c9(%rip),%eax        # 5700c <rand_seed>
   43f43:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43f49:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43f4e:	89 05 b8 30 01 00    	mov    %eax,0x130b8(%rip)        # 5700c <rand_seed>
    return rand_seed & RAND_MAX;
   43f54:	8b 05 b2 30 01 00    	mov    0x130b2(%rip),%eax        # 5700c <rand_seed>
   43f5a:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43f5f:	5d                   	pop    %rbp
   43f60:	c3                   	ret

0000000000043f61 <srand>:

void srand(unsigned seed) {
   43f61:	55                   	push   %rbp
   43f62:	48 89 e5             	mov    %rsp,%rbp
   43f65:	48 83 ec 08          	sub    $0x8,%rsp
   43f69:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43f6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43f6f:	89 05 97 30 01 00    	mov    %eax,0x13097(%rip)        # 5700c <rand_seed>
    rand_seed_set = 1;
   43f75:	c7 05 89 30 01 00 01 	movl   $0x1,0x13089(%rip)        # 57008 <rand_seed_set>
   43f7c:	00 00 00 
}
   43f7f:	90                   	nop
   43f80:	c9                   	leave
   43f81:	c3                   	ret

0000000000043f82 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43f82:	55                   	push   %rbp
   43f83:	48 89 e5             	mov    %rsp,%rbp
   43f86:	48 83 ec 28          	sub    $0x28,%rsp
   43f8a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43f8e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43f92:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43f95:	48 c7 45 f8 20 5b 04 	movq   $0x45b20,-0x8(%rbp)
   43f9c:	00 
    if (base < 0) {
   43f9d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43fa1:	79 0b                	jns    43fae <fill_numbuf+0x2c>
        digits = lower_digits;
   43fa3:	48 c7 45 f8 40 5b 04 	movq   $0x45b40,-0x8(%rbp)
   43faa:	00 
        base = -base;
   43fab:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43fae:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43fb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fb7:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43fba:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43fbd:	48 63 c8             	movslq %eax,%rcx
   43fc0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43fc4:	ba 00 00 00 00       	mov    $0x0,%edx
   43fc9:	48 f7 f1             	div    %rcx
   43fcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fd0:	48 01 d0             	add    %rdx,%rax
   43fd3:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43fd8:	0f b6 10             	movzbl (%rax),%edx
   43fdb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fdf:	88 10                	mov    %dl,(%rax)
        val /= base;
   43fe1:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43fe4:	48 63 f0             	movslq %eax,%rsi
   43fe7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43feb:	ba 00 00 00 00       	mov    $0x0,%edx
   43ff0:	48 f7 f6             	div    %rsi
   43ff3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43ff7:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43ffc:	75 bc                	jne    43fba <fill_numbuf+0x38>
    return numbuf_end;
   43ffe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   44002:	c9                   	leave
   44003:	c3                   	ret

0000000000044004 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   44004:	55                   	push   %rbp
   44005:	48 89 e5             	mov    %rsp,%rbp
   44008:	53                   	push   %rbx
   44009:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   44010:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   44017:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   4401d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44024:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   4402b:	e9 8a 09 00 00       	jmp    449ba <printer_vprintf+0x9b6>
        if (*format != '%') {
   44030:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44037:	0f b6 00             	movzbl (%rax),%eax
   4403a:	3c 25                	cmp    $0x25,%al
   4403c:	74 31                	je     4406f <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   4403e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44045:	4c 8b 00             	mov    (%rax),%r8
   44048:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4404f:	0f b6 00             	movzbl (%rax),%eax
   44052:	0f b6 c8             	movzbl %al,%ecx
   44055:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4405b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44062:	89 ce                	mov    %ecx,%esi
   44064:	48 89 c7             	mov    %rax,%rdi
   44067:	41 ff d0             	call   *%r8
            continue;
   4406a:	e9 43 09 00 00       	jmp    449b2 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   4406f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   44076:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4407d:	01 
   4407e:	eb 44                	jmp    440c4 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   44080:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44087:	0f b6 00             	movzbl (%rax),%eax
   4408a:	0f be c0             	movsbl %al,%eax
   4408d:	89 c6                	mov    %eax,%esi
   4408f:	bf 40 59 04 00       	mov    $0x45940,%edi
   44094:	e8 42 fe ff ff       	call   43edb <strchr>
   44099:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   4409d:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   440a2:	74 30                	je     440d4 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   440a4:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   440a8:	48 2d 40 59 04 00    	sub    $0x45940,%rax
   440ae:	ba 01 00 00 00       	mov    $0x1,%edx
   440b3:	89 c1                	mov    %eax,%ecx
   440b5:	d3 e2                	shl    %cl,%edx
   440b7:	89 d0                	mov    %edx,%eax
   440b9:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   440bc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   440c3:	01 
   440c4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440cb:	0f b6 00             	movzbl (%rax),%eax
   440ce:	84 c0                	test   %al,%al
   440d0:	75 ae                	jne    44080 <printer_vprintf+0x7c>
   440d2:	eb 01                	jmp    440d5 <printer_vprintf+0xd1>
            } else {
                break;
   440d4:	90                   	nop
            }
        }

        // process width
        int width = -1;
   440d5:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   440dc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440e3:	0f b6 00             	movzbl (%rax),%eax
   440e6:	3c 30                	cmp    $0x30,%al
   440e8:	7e 67                	jle    44151 <printer_vprintf+0x14d>
   440ea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440f1:	0f b6 00             	movzbl (%rax),%eax
   440f4:	3c 39                	cmp    $0x39,%al
   440f6:	7f 59                	jg     44151 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   440f8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   440ff:	eb 2e                	jmp    4412f <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   44101:	8b 55 e8             	mov    -0x18(%rbp),%edx
   44104:	89 d0                	mov    %edx,%eax
   44106:	c1 e0 02             	shl    $0x2,%eax
   44109:	01 d0                	add    %edx,%eax
   4410b:	01 c0                	add    %eax,%eax
   4410d:	89 c1                	mov    %eax,%ecx
   4410f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44116:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4411a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44121:	0f b6 00             	movzbl (%rax),%eax
   44124:	0f be c0             	movsbl %al,%eax
   44127:	01 c8                	add    %ecx,%eax
   44129:	83 e8 30             	sub    $0x30,%eax
   4412c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4412f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44136:	0f b6 00             	movzbl (%rax),%eax
   44139:	3c 2f                	cmp    $0x2f,%al
   4413b:	0f 8e 85 00 00 00    	jle    441c6 <printer_vprintf+0x1c2>
   44141:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44148:	0f b6 00             	movzbl (%rax),%eax
   4414b:	3c 39                	cmp    $0x39,%al
   4414d:	7e b2                	jle    44101 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   4414f:	eb 75                	jmp    441c6 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   44151:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44158:	0f b6 00             	movzbl (%rax),%eax
   4415b:	3c 2a                	cmp    $0x2a,%al
   4415d:	75 68                	jne    441c7 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   4415f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44166:	8b 00                	mov    (%rax),%eax
   44168:	83 f8 2f             	cmp    $0x2f,%eax
   4416b:	77 30                	ja     4419d <printer_vprintf+0x199>
   4416d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44174:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44178:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4417f:	8b 00                	mov    (%rax),%eax
   44181:	89 c0                	mov    %eax,%eax
   44183:	48 01 d0             	add    %rdx,%rax
   44186:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4418d:	8b 12                	mov    (%rdx),%edx
   4418f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44192:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44199:	89 0a                	mov    %ecx,(%rdx)
   4419b:	eb 1a                	jmp    441b7 <printer_vprintf+0x1b3>
   4419d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441a4:	48 8b 40 08          	mov    0x8(%rax),%rax
   441a8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441ac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441b3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441b7:	8b 00                	mov    (%rax),%eax
   441b9:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   441bc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441c3:	01 
   441c4:	eb 01                	jmp    441c7 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   441c6:	90                   	nop
        }

        // process precision
        int precision = -1;
   441c7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   441ce:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441d5:	0f b6 00             	movzbl (%rax),%eax
   441d8:	3c 2e                	cmp    $0x2e,%al
   441da:	0f 85 00 01 00 00    	jne    442e0 <printer_vprintf+0x2dc>
            ++format;
   441e0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441e7:	01 
            if (*format >= '0' && *format <= '9') {
   441e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441ef:	0f b6 00             	movzbl (%rax),%eax
   441f2:	3c 2f                	cmp    $0x2f,%al
   441f4:	7e 67                	jle    4425d <printer_vprintf+0x259>
   441f6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441fd:	0f b6 00             	movzbl (%rax),%eax
   44200:	3c 39                	cmp    $0x39,%al
   44202:	7f 59                	jg     4425d <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44204:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   4420b:	eb 2e                	jmp    4423b <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   4420d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   44210:	89 d0                	mov    %edx,%eax
   44212:	c1 e0 02             	shl    $0x2,%eax
   44215:	01 d0                	add    %edx,%eax
   44217:	01 c0                	add    %eax,%eax
   44219:	89 c1                	mov    %eax,%ecx
   4421b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44222:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44226:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4422d:	0f b6 00             	movzbl (%rax),%eax
   44230:	0f be c0             	movsbl %al,%eax
   44233:	01 c8                	add    %ecx,%eax
   44235:	83 e8 30             	sub    $0x30,%eax
   44238:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4423b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44242:	0f b6 00             	movzbl (%rax),%eax
   44245:	3c 2f                	cmp    $0x2f,%al
   44247:	0f 8e 85 00 00 00    	jle    442d2 <printer_vprintf+0x2ce>
   4424d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44254:	0f b6 00             	movzbl (%rax),%eax
   44257:	3c 39                	cmp    $0x39,%al
   44259:	7e b2                	jle    4420d <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   4425b:	eb 75                	jmp    442d2 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   4425d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44264:	0f b6 00             	movzbl (%rax),%eax
   44267:	3c 2a                	cmp    $0x2a,%al
   44269:	75 68                	jne    442d3 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   4426b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44272:	8b 00                	mov    (%rax),%eax
   44274:	83 f8 2f             	cmp    $0x2f,%eax
   44277:	77 30                	ja     442a9 <printer_vprintf+0x2a5>
   44279:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44280:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44284:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4428b:	8b 00                	mov    (%rax),%eax
   4428d:	89 c0                	mov    %eax,%eax
   4428f:	48 01 d0             	add    %rdx,%rax
   44292:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44299:	8b 12                	mov    (%rdx),%edx
   4429b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4429e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442a5:	89 0a                	mov    %ecx,(%rdx)
   442a7:	eb 1a                	jmp    442c3 <printer_vprintf+0x2bf>
   442a9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442b0:	48 8b 40 08          	mov    0x8(%rax),%rax
   442b4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442b8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442bf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442c3:	8b 00                	mov    (%rax),%eax
   442c5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   442c8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   442cf:	01 
   442d0:	eb 01                	jmp    442d3 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   442d2:	90                   	nop
            }
            if (precision < 0) {
   442d3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   442d7:	79 07                	jns    442e0 <printer_vprintf+0x2dc>
                precision = 0;
   442d9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   442e0:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   442e7:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   442ee:	00 
        int length = 0;
   442ef:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   442f6:	48 c7 45 c8 46 59 04 	movq   $0x45946,-0x38(%rbp)
   442fd:	00 
    again:
        switch (*format) {
   442fe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44305:	0f b6 00             	movzbl (%rax),%eax
   44308:	0f be c0             	movsbl %al,%eax
   4430b:	83 e8 43             	sub    $0x43,%eax
   4430e:	83 f8 37             	cmp    $0x37,%eax
   44311:	0f 87 9f 03 00 00    	ja     446b6 <printer_vprintf+0x6b2>
   44317:	89 c0                	mov    %eax,%eax
   44319:	48 8b 04 c5 58 59 04 	mov    0x45958(,%rax,8),%rax
   44320:	00 
   44321:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   44323:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   4432a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44331:	01 
            goto again;
   44332:	eb ca                	jmp    442fe <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   44334:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44338:	74 5d                	je     44397 <printer_vprintf+0x393>
   4433a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44341:	8b 00                	mov    (%rax),%eax
   44343:	83 f8 2f             	cmp    $0x2f,%eax
   44346:	77 30                	ja     44378 <printer_vprintf+0x374>
   44348:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4434f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44353:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4435a:	8b 00                	mov    (%rax),%eax
   4435c:	89 c0                	mov    %eax,%eax
   4435e:	48 01 d0             	add    %rdx,%rax
   44361:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44368:	8b 12                	mov    (%rdx),%edx
   4436a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4436d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44374:	89 0a                	mov    %ecx,(%rdx)
   44376:	eb 1a                	jmp    44392 <printer_vprintf+0x38e>
   44378:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4437f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44383:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44387:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4438e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44392:	48 8b 00             	mov    (%rax),%rax
   44395:	eb 5c                	jmp    443f3 <printer_vprintf+0x3ef>
   44397:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4439e:	8b 00                	mov    (%rax),%eax
   443a0:	83 f8 2f             	cmp    $0x2f,%eax
   443a3:	77 30                	ja     443d5 <printer_vprintf+0x3d1>
   443a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ac:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443b7:	8b 00                	mov    (%rax),%eax
   443b9:	89 c0                	mov    %eax,%eax
   443bb:	48 01 d0             	add    %rdx,%rax
   443be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443c5:	8b 12                	mov    (%rdx),%edx
   443c7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443d1:	89 0a                	mov    %ecx,(%rdx)
   443d3:	eb 1a                	jmp    443ef <printer_vprintf+0x3eb>
   443d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443dc:	48 8b 40 08          	mov    0x8(%rax),%rax
   443e0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443e4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443eb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443ef:	8b 00                	mov    (%rax),%eax
   443f1:	48 98                	cltq
   443f3:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   443f7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   443fb:	48 c1 f8 38          	sar    $0x38,%rax
   443ff:	25 80 00 00 00       	and    $0x80,%eax
   44404:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   44407:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   4440b:	74 09                	je     44416 <printer_vprintf+0x412>
   4440d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44411:	48 f7 d8             	neg    %rax
   44414:	eb 04                	jmp    4441a <printer_vprintf+0x416>
   44416:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4441a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   4441e:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44421:	83 c8 60             	or     $0x60,%eax
   44424:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44427:	e9 cf 02 00 00       	jmp    446fb <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4442c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44430:	74 5d                	je     4448f <printer_vprintf+0x48b>
   44432:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44439:	8b 00                	mov    (%rax),%eax
   4443b:	83 f8 2f             	cmp    $0x2f,%eax
   4443e:	77 30                	ja     44470 <printer_vprintf+0x46c>
   44440:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44447:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4444b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44452:	8b 00                	mov    (%rax),%eax
   44454:	89 c0                	mov    %eax,%eax
   44456:	48 01 d0             	add    %rdx,%rax
   44459:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44460:	8b 12                	mov    (%rdx),%edx
   44462:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44465:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4446c:	89 0a                	mov    %ecx,(%rdx)
   4446e:	eb 1a                	jmp    4448a <printer_vprintf+0x486>
   44470:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44477:	48 8b 40 08          	mov    0x8(%rax),%rax
   4447b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4447f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44486:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4448a:	48 8b 00             	mov    (%rax),%rax
   4448d:	eb 5c                	jmp    444eb <printer_vprintf+0x4e7>
   4448f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44496:	8b 00                	mov    (%rax),%eax
   44498:	83 f8 2f             	cmp    $0x2f,%eax
   4449b:	77 30                	ja     444cd <printer_vprintf+0x4c9>
   4449d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444a4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444af:	8b 00                	mov    (%rax),%eax
   444b1:	89 c0                	mov    %eax,%eax
   444b3:	48 01 d0             	add    %rdx,%rax
   444b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444bd:	8b 12                	mov    (%rdx),%edx
   444bf:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444c2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444c9:	89 0a                	mov    %ecx,(%rdx)
   444cb:	eb 1a                	jmp    444e7 <printer_vprintf+0x4e3>
   444cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444d4:	48 8b 40 08          	mov    0x8(%rax),%rax
   444d8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444e3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444e7:	8b 00                	mov    (%rax),%eax
   444e9:	89 c0                	mov    %eax,%eax
   444eb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   444ef:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   444f3:	e9 03 02 00 00       	jmp    446fb <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   444f8:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   444ff:	e9 28 ff ff ff       	jmp    4442c <printer_vprintf+0x428>
        case 'X':
            base = 16;
   44504:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   4450b:	e9 1c ff ff ff       	jmp    4442c <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44510:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44517:	8b 00                	mov    (%rax),%eax
   44519:	83 f8 2f             	cmp    $0x2f,%eax
   4451c:	77 30                	ja     4454e <printer_vprintf+0x54a>
   4451e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44525:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44529:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44530:	8b 00                	mov    (%rax),%eax
   44532:	89 c0                	mov    %eax,%eax
   44534:	48 01 d0             	add    %rdx,%rax
   44537:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4453e:	8b 12                	mov    (%rdx),%edx
   44540:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44543:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4454a:	89 0a                	mov    %ecx,(%rdx)
   4454c:	eb 1a                	jmp    44568 <printer_vprintf+0x564>
   4454e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44555:	48 8b 40 08          	mov    0x8(%rax),%rax
   44559:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4455d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44564:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44568:	48 8b 00             	mov    (%rax),%rax
   4456b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   4456f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   44576:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   4457d:	e9 79 01 00 00       	jmp    446fb <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   44582:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44589:	8b 00                	mov    (%rax),%eax
   4458b:	83 f8 2f             	cmp    $0x2f,%eax
   4458e:	77 30                	ja     445c0 <printer_vprintf+0x5bc>
   44590:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44597:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4459b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445a2:	8b 00                	mov    (%rax),%eax
   445a4:	89 c0                	mov    %eax,%eax
   445a6:	48 01 d0             	add    %rdx,%rax
   445a9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445b0:	8b 12                	mov    (%rdx),%edx
   445b2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445b5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445bc:	89 0a                	mov    %ecx,(%rdx)
   445be:	eb 1a                	jmp    445da <printer_vprintf+0x5d6>
   445c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445c7:	48 8b 40 08          	mov    0x8(%rax),%rax
   445cb:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445d6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445da:	48 8b 00             	mov    (%rax),%rax
   445dd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   445e1:	e9 15 01 00 00       	jmp    446fb <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   445e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445ed:	8b 00                	mov    (%rax),%eax
   445ef:	83 f8 2f             	cmp    $0x2f,%eax
   445f2:	77 30                	ja     44624 <printer_vprintf+0x620>
   445f4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445fb:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445ff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44606:	8b 00                	mov    (%rax),%eax
   44608:	89 c0                	mov    %eax,%eax
   4460a:	48 01 d0             	add    %rdx,%rax
   4460d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44614:	8b 12                	mov    (%rdx),%edx
   44616:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44619:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44620:	89 0a                	mov    %ecx,(%rdx)
   44622:	eb 1a                	jmp    4463e <printer_vprintf+0x63a>
   44624:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4462b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4462f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44633:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4463a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4463e:	8b 00                	mov    (%rax),%eax
   44640:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44646:	e9 67 03 00 00       	jmp    449b2 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   4464b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4464f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44653:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4465a:	8b 00                	mov    (%rax),%eax
   4465c:	83 f8 2f             	cmp    $0x2f,%eax
   4465f:	77 30                	ja     44691 <printer_vprintf+0x68d>
   44661:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44668:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4466c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44673:	8b 00                	mov    (%rax),%eax
   44675:	89 c0                	mov    %eax,%eax
   44677:	48 01 d0             	add    %rdx,%rax
   4467a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44681:	8b 12                	mov    (%rdx),%edx
   44683:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44686:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4468d:	89 0a                	mov    %ecx,(%rdx)
   4468f:	eb 1a                	jmp    446ab <printer_vprintf+0x6a7>
   44691:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44698:	48 8b 40 08          	mov    0x8(%rax),%rax
   4469c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   446a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446a7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   446ab:	8b 00                	mov    (%rax),%eax
   446ad:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   446b0:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   446b4:	eb 45                	jmp    446fb <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   446b6:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   446ba:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   446be:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   446c5:	0f b6 00             	movzbl (%rax),%eax
   446c8:	84 c0                	test   %al,%al
   446ca:	74 0c                	je     446d8 <printer_vprintf+0x6d4>
   446cc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   446d3:	0f b6 00             	movzbl (%rax),%eax
   446d6:	eb 05                	jmp    446dd <printer_vprintf+0x6d9>
   446d8:	b8 25 00 00 00       	mov    $0x25,%eax
   446dd:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   446e0:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   446e4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   446eb:	0f b6 00             	movzbl (%rax),%eax
   446ee:	84 c0                	test   %al,%al
   446f0:	75 08                	jne    446fa <printer_vprintf+0x6f6>
                format--;
   446f2:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   446f9:	01 
            }
            break;
   446fa:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   446fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446fe:	83 e0 20             	and    $0x20,%eax
   44701:	85 c0                	test   %eax,%eax
   44703:	74 1e                	je     44723 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44705:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44709:	48 83 c0 18          	add    $0x18,%rax
   4470d:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44710:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44714:	48 89 ce             	mov    %rcx,%rsi
   44717:	48 89 c7             	mov    %rax,%rdi
   4471a:	e8 63 f8 ff ff       	call   43f82 <fill_numbuf>
   4471f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44723:	48 c7 45 c0 46 59 04 	movq   $0x45946,-0x40(%rbp)
   4472a:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   4472b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4472e:	83 e0 20             	and    $0x20,%eax
   44731:	85 c0                	test   %eax,%eax
   44733:	74 48                	je     4477d <printer_vprintf+0x779>
   44735:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44738:	83 e0 40             	and    $0x40,%eax
   4473b:	85 c0                	test   %eax,%eax
   4473d:	74 3e                	je     4477d <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   4473f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44742:	25 80 00 00 00       	and    $0x80,%eax
   44747:	85 c0                	test   %eax,%eax
   44749:	74 0a                	je     44755 <printer_vprintf+0x751>
                prefix = "-";
   4474b:	48 c7 45 c0 47 59 04 	movq   $0x45947,-0x40(%rbp)
   44752:	00 
            if (flags & FLAG_NEGATIVE) {
   44753:	eb 73                	jmp    447c8 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44755:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44758:	83 e0 10             	and    $0x10,%eax
   4475b:	85 c0                	test   %eax,%eax
   4475d:	74 0a                	je     44769 <printer_vprintf+0x765>
                prefix = "+";
   4475f:	48 c7 45 c0 49 59 04 	movq   $0x45949,-0x40(%rbp)
   44766:	00 
            if (flags & FLAG_NEGATIVE) {
   44767:	eb 5f                	jmp    447c8 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44769:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4476c:	83 e0 08             	and    $0x8,%eax
   4476f:	85 c0                	test   %eax,%eax
   44771:	74 55                	je     447c8 <printer_vprintf+0x7c4>
                prefix = " ";
   44773:	48 c7 45 c0 4b 59 04 	movq   $0x4594b,-0x40(%rbp)
   4477a:	00 
            if (flags & FLAG_NEGATIVE) {
   4477b:	eb 4b                	jmp    447c8 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   4477d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44780:	83 e0 20             	and    $0x20,%eax
   44783:	85 c0                	test   %eax,%eax
   44785:	74 42                	je     447c9 <printer_vprintf+0x7c5>
   44787:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4478a:	83 e0 01             	and    $0x1,%eax
   4478d:	85 c0                	test   %eax,%eax
   4478f:	74 38                	je     447c9 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   44791:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44795:	74 06                	je     4479d <printer_vprintf+0x799>
   44797:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4479b:	75 2c                	jne    447c9 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   4479d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   447a2:	75 0c                	jne    447b0 <printer_vprintf+0x7ac>
   447a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447a7:	25 00 01 00 00       	and    $0x100,%eax
   447ac:	85 c0                	test   %eax,%eax
   447ae:	74 19                	je     447c9 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   447b0:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   447b4:	75 07                	jne    447bd <printer_vprintf+0x7b9>
   447b6:	b8 4d 59 04 00       	mov    $0x4594d,%eax
   447bb:	eb 05                	jmp    447c2 <printer_vprintf+0x7be>
   447bd:	b8 50 59 04 00       	mov    $0x45950,%eax
   447c2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   447c6:	eb 01                	jmp    447c9 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   447c8:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   447c9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   447cd:	78 24                	js     447f3 <printer_vprintf+0x7ef>
   447cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447d2:	83 e0 20             	and    $0x20,%eax
   447d5:	85 c0                	test   %eax,%eax
   447d7:	75 1a                	jne    447f3 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   447d9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   447dc:	48 63 d0             	movslq %eax,%rdx
   447df:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   447e3:	48 89 d6             	mov    %rdx,%rsi
   447e6:	48 89 c7             	mov    %rax,%rdi
   447e9:	e8 ea f5 ff ff       	call   43dd8 <strnlen>
   447ee:	89 45 bc             	mov    %eax,-0x44(%rbp)
   447f1:	eb 0f                	jmp    44802 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   447f3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   447f7:	48 89 c7             	mov    %rax,%rdi
   447fa:	e8 a8 f5 ff ff       	call   43da7 <strlen>
   447ff:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44802:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44805:	83 e0 20             	and    $0x20,%eax
   44808:	85 c0                	test   %eax,%eax
   4480a:	74 20                	je     4482c <printer_vprintf+0x828>
   4480c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44810:	78 1a                	js     4482c <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   44812:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44815:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44818:	7e 08                	jle    44822 <printer_vprintf+0x81e>
   4481a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4481d:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44820:	eb 05                	jmp    44827 <printer_vprintf+0x823>
   44822:	b8 00 00 00 00       	mov    $0x0,%eax
   44827:	89 45 b8             	mov    %eax,-0x48(%rbp)
   4482a:	eb 5c                	jmp    44888 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   4482c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4482f:	83 e0 20             	and    $0x20,%eax
   44832:	85 c0                	test   %eax,%eax
   44834:	74 4b                	je     44881 <printer_vprintf+0x87d>
   44836:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44839:	83 e0 02             	and    $0x2,%eax
   4483c:	85 c0                	test   %eax,%eax
   4483e:	74 41                	je     44881 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44840:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44843:	83 e0 04             	and    $0x4,%eax
   44846:	85 c0                	test   %eax,%eax
   44848:	75 37                	jne    44881 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   4484a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4484e:	48 89 c7             	mov    %rax,%rdi
   44851:	e8 51 f5 ff ff       	call   43da7 <strlen>
   44856:	89 c2                	mov    %eax,%edx
   44858:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4485b:	01 d0                	add    %edx,%eax
   4485d:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44860:	7e 1f                	jle    44881 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   44862:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44865:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44868:	89 c3                	mov    %eax,%ebx
   4486a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4486e:	48 89 c7             	mov    %rax,%rdi
   44871:	e8 31 f5 ff ff       	call   43da7 <strlen>
   44876:	89 c2                	mov    %eax,%edx
   44878:	89 d8                	mov    %ebx,%eax
   4487a:	29 d0                	sub    %edx,%eax
   4487c:	89 45 b8             	mov    %eax,-0x48(%rbp)
   4487f:	eb 07                	jmp    44888 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   44881:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44888:	8b 55 bc             	mov    -0x44(%rbp),%edx
   4488b:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4488e:	01 d0                	add    %edx,%eax
   44890:	48 63 d8             	movslq %eax,%rbx
   44893:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44897:	48 89 c7             	mov    %rax,%rdi
   4489a:	e8 08 f5 ff ff       	call   43da7 <strlen>
   4489f:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   448a3:	8b 45 e8             	mov    -0x18(%rbp),%eax
   448a6:	29 d0                	sub    %edx,%eax
   448a8:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   448ab:	eb 25                	jmp    448d2 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   448ad:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448b4:	48 8b 08             	mov    (%rax),%rcx
   448b7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448bd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448c4:	be 20 00 00 00       	mov    $0x20,%esi
   448c9:	48 89 c7             	mov    %rax,%rdi
   448cc:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   448ce:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   448d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448d5:	83 e0 04             	and    $0x4,%eax
   448d8:	85 c0                	test   %eax,%eax
   448da:	75 36                	jne    44912 <printer_vprintf+0x90e>
   448dc:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   448e0:	7f cb                	jg     448ad <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   448e2:	eb 2e                	jmp    44912 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   448e4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448eb:	4c 8b 00             	mov    (%rax),%r8
   448ee:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   448f2:	0f b6 00             	movzbl (%rax),%eax
   448f5:	0f b6 c8             	movzbl %al,%ecx
   448f8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448fe:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44905:	89 ce                	mov    %ecx,%esi
   44907:	48 89 c7             	mov    %rax,%rdi
   4490a:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   4490d:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44912:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44916:	0f b6 00             	movzbl (%rax),%eax
   44919:	84 c0                	test   %al,%al
   4491b:	75 c7                	jne    448e4 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   4491d:	eb 25                	jmp    44944 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   4491f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44926:	48 8b 08             	mov    (%rax),%rcx
   44929:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4492f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44936:	be 30 00 00 00       	mov    $0x30,%esi
   4493b:	48 89 c7             	mov    %rax,%rdi
   4493e:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44940:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44944:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44948:	7f d5                	jg     4491f <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   4494a:	eb 32                	jmp    4497e <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   4494c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44953:	4c 8b 00             	mov    (%rax),%r8
   44956:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4495a:	0f b6 00             	movzbl (%rax),%eax
   4495d:	0f b6 c8             	movzbl %al,%ecx
   44960:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44966:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4496d:	89 ce                	mov    %ecx,%esi
   4496f:	48 89 c7             	mov    %rax,%rdi
   44972:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   44975:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   4497a:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   4497e:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44982:	7f c8                	jg     4494c <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   44984:	eb 25                	jmp    449ab <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   44986:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4498d:	48 8b 08             	mov    (%rax),%rcx
   44990:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44996:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4499d:	be 20 00 00 00       	mov    $0x20,%esi
   449a2:	48 89 c7             	mov    %rax,%rdi
   449a5:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   449a7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   449ab:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   449af:	7f d5                	jg     44986 <printer_vprintf+0x982>
        }
    done: ;
   449b1:	90                   	nop
    for (; *format; ++format) {
   449b2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   449b9:	01 
   449ba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   449c1:	0f b6 00             	movzbl (%rax),%eax
   449c4:	84 c0                	test   %al,%al
   449c6:	0f 85 64 f6 ff ff    	jne    44030 <printer_vprintf+0x2c>
    }
}
   449cc:	90                   	nop
   449cd:	90                   	nop
   449ce:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   449d2:	c9                   	leave
   449d3:	c3                   	ret

00000000000449d4 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   449d4:	55                   	push   %rbp
   449d5:	48 89 e5             	mov    %rsp,%rbp
   449d8:	48 83 ec 20          	sub    $0x20,%rsp
   449dc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   449e0:	89 f0                	mov    %esi,%eax
   449e2:	89 55 e0             	mov    %edx,-0x20(%rbp)
   449e5:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   449e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   449ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   449f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449f4:	48 8b 40 08          	mov    0x8(%rax),%rax
   449f8:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   449fd:	48 39 d0             	cmp    %rdx,%rax
   44a00:	72 0c                	jb     44a0e <console_putc+0x3a>
        cp->cursor = console;
   44a02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a06:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   44a0d:	00 
    }
    if (c == '\n') {
   44a0e:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44a12:	75 78                	jne    44a8c <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   44a14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a18:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a1c:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44a22:	48 d1 f8             	sar    %rax
   44a25:	48 89 c1             	mov    %rax,%rcx
   44a28:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44a2f:	66 66 66 
   44a32:	48 89 c8             	mov    %rcx,%rax
   44a35:	48 f7 ea             	imul   %rdx
   44a38:	48 c1 fa 05          	sar    $0x5,%rdx
   44a3c:	48 89 c8             	mov    %rcx,%rax
   44a3f:	48 c1 f8 3f          	sar    $0x3f,%rax
   44a43:	48 29 c2             	sub    %rax,%rdx
   44a46:	48 89 d0             	mov    %rdx,%rax
   44a49:	48 c1 e0 02          	shl    $0x2,%rax
   44a4d:	48 01 d0             	add    %rdx,%rax
   44a50:	48 c1 e0 04          	shl    $0x4,%rax
   44a54:	48 29 c1             	sub    %rax,%rcx
   44a57:	48 89 ca             	mov    %rcx,%rdx
   44a5a:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44a5d:	eb 25                	jmp    44a84 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   44a5f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44a62:	83 c8 20             	or     $0x20,%eax
   44a65:	89 c6                	mov    %eax,%esi
   44a67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a6b:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a6f:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44a73:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44a77:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a7b:	89 f2                	mov    %esi,%edx
   44a7d:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44a80:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44a84:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44a88:	75 d5                	jne    44a5f <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44a8a:	eb 24                	jmp    44ab0 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44a8c:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   44a90:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44a93:	09 d0                	or     %edx,%eax
   44a95:	89 c6                	mov    %eax,%esi
   44a97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a9b:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a9f:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44aa3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44aa7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44aab:	89 f2                	mov    %esi,%edx
   44aad:	66 89 10             	mov    %dx,(%rax)
}
   44ab0:	90                   	nop
   44ab1:	c9                   	leave
   44ab2:	c3                   	ret

0000000000044ab3 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44ab3:	55                   	push   %rbp
   44ab4:	48 89 e5             	mov    %rsp,%rbp
   44ab7:	48 83 ec 30          	sub    $0x30,%rsp
   44abb:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44abe:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44ac1:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44ac5:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44ac9:	48 c7 45 f0 d4 49 04 	movq   $0x449d4,-0x10(%rbp)
   44ad0:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44ad1:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44ad5:	78 09                	js     44ae0 <console_vprintf+0x2d>
   44ad7:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44ade:	7e 07                	jle    44ae7 <console_vprintf+0x34>
        cpos = 0;
   44ae0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44ae7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44aea:	48 98                	cltq
   44aec:	48 01 c0             	add    %rax,%rax
   44aef:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44af5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44af9:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44afd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44b01:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44b04:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44b08:	48 89 c7             	mov    %rax,%rdi
   44b0b:	e8 f4 f4 ff ff       	call   44004 <printer_vprintf>
    return cp.cursor - console;
   44b10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b14:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44b1a:	48 d1 f8             	sar    %rax
}
   44b1d:	c9                   	leave
   44b1e:	c3                   	ret

0000000000044b1f <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44b1f:	55                   	push   %rbp
   44b20:	48 89 e5             	mov    %rsp,%rbp
   44b23:	48 83 ec 60          	sub    $0x60,%rsp
   44b27:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44b2a:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44b2d:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44b31:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44b35:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44b39:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44b3d:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44b44:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44b48:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44b4c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44b50:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44b54:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44b58:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44b5c:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44b5f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44b62:	89 c7                	mov    %eax,%edi
   44b64:	e8 4a ff ff ff       	call   44ab3 <console_vprintf>
   44b69:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44b6c:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44b6f:	c9                   	leave
   44b70:	c3                   	ret

0000000000044b71 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44b71:	55                   	push   %rbp
   44b72:	48 89 e5             	mov    %rsp,%rbp
   44b75:	48 83 ec 20          	sub    $0x20,%rsp
   44b79:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44b7d:	89 f0                	mov    %esi,%eax
   44b7f:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44b82:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44b85:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44b89:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44b8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b91:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44b95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b99:	48 8b 40 10          	mov    0x10(%rax),%rax
   44b9d:	48 39 c2             	cmp    %rax,%rdx
   44ba0:	73 1a                	jae    44bbc <string_putc+0x4b>
        *sp->s++ = c;
   44ba2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44ba6:	48 8b 40 08          	mov    0x8(%rax),%rax
   44baa:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44bae:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44bb2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44bb6:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44bba:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44bbc:	90                   	nop
   44bbd:	c9                   	leave
   44bbe:	c3                   	ret

0000000000044bbf <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44bbf:	55                   	push   %rbp
   44bc0:	48 89 e5             	mov    %rsp,%rbp
   44bc3:	48 83 ec 40          	sub    $0x40,%rsp
   44bc7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44bcb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44bcf:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44bd3:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44bd7:	48 c7 45 e8 71 4b 04 	movq   $0x44b71,-0x18(%rbp)
   44bde:	00 
    sp.s = s;
   44bdf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44be3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44be7:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44bec:	74 33                	je     44c21 <vsnprintf+0x62>
        sp.end = s + size - 1;
   44bee:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44bf2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44bf6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44bfa:	48 01 d0             	add    %rdx,%rax
   44bfd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44c01:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44c05:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44c09:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44c0d:	be 00 00 00 00       	mov    $0x0,%esi
   44c12:	48 89 c7             	mov    %rax,%rdi
   44c15:	e8 ea f3 ff ff       	call   44004 <printer_vprintf>
        *sp.s = 0;
   44c1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44c1e:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44c21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44c25:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44c29:	c9                   	leave
   44c2a:	c3                   	ret

0000000000044c2b <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44c2b:	55                   	push   %rbp
   44c2c:	48 89 e5             	mov    %rsp,%rbp
   44c2f:	48 83 ec 70          	sub    $0x70,%rsp
   44c33:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44c37:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44c3b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44c3f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44c43:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44c47:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44c4b:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44c52:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44c56:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44c5a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44c5e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44c62:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44c66:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44c6a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44c6e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44c72:	48 89 c7             	mov    %rax,%rdi
   44c75:	e8 45 ff ff ff       	call   44bbf <vsnprintf>
   44c7a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44c7d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44c80:	c9                   	leave
   44c81:	c3                   	ret

0000000000044c82 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44c82:	55                   	push   %rbp
   44c83:	48 89 e5             	mov    %rsp,%rbp
   44c86:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44c91:	eb 13                	jmp    44ca6 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44c93:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44c96:	48 98                	cltq
   44c98:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44c9f:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44ca2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44ca6:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44cad:	7e e4                	jle    44c93 <console_clear+0x11>
    }
    cursorpos = 0;
   44caf:	c7 05 43 43 07 00 00 	movl   $0x0,0x74343(%rip)        # b8ffc <cursorpos>
   44cb6:	00 00 00 
}
   44cb9:	90                   	nop
   44cba:	c9                   	leave
   44cbb:	c3                   	ret
