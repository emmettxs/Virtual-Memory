
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 56                	push   %r14
  2c0006:	41 55                	push   %r13
  2c0008:	41 54                	push   %r12
  2c000a:	53                   	push   %rbx
  2c000b:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c000f:	cd 31                	int    $0x31
  2c0011:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0014:	89 c7                	mov    %eax,%edi
  2c0016:	e8 97 09 00 00       	call   2c09b2 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 1a 03 00 00       	call   2c033f <malloc>
  2c0025:	48 89 c7             	mov    %rax,%rdi
  2c0028:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c002d:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0030:	48 83 c2 01          	add    $0x1,%rdx
  2c0034:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c0038:	75 f3                	jne    2c002d <process_main+0x2d>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003a:	be 50 00 00 00       	mov    $0x50,%esi
  2c003f:	e8 63 04 00 00       	call   2c04a7 <realloc>
  2c0044:	49 89 c5             	mov    %rax,%r13
  2c0047:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c004c:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0051:	75 64                	jne    2c00b7 <process_main+0xb7>
    for(int i = 0 ; i < 10 ; i++){
  2c0053:	48 83 c0 01          	add    $0x1,%rax
  2c0057:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005b:	75 ef                	jne    2c004c <process_main+0x4c>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c005d:	be 04 00 00 00       	mov    $0x4,%esi
  2c0062:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0067:	e8 d9 03 00 00       	call   2c0445 <calloc>
  2c006c:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c006f:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0073:	8b 18                	mov    (%rax),%ebx
  2c0075:	85 db                	test   %ebx,%ebx
  2c0077:	75 52                	jne    2c00cb <process_main+0xcb>
    for(int i = 0 ; i < 30; i++){
  2c0079:	48 83 c0 04          	add    $0x4,%rax
  2c007d:	48 39 d0             	cmp    %rdx,%rax
  2c0080:	75 f1                	jne    2c0073 <process_main+0x73>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0082:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c0086:	e8 e3 04 00 00       	call   2c056e <heap_info>
  2c008b:	85 c0                	test   %eax,%eax
  2c008d:	75 64                	jne    2c00f3 <process_main+0xf3>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c008f:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0092:	83 fa 01             	cmp    $0x1,%edx
  2c0095:	7e 70                	jle    2c0107 <process_main+0x107>
  2c0097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009b:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c009e:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00a3:	48 8b 30             	mov    (%rax),%rsi
  2c00a6:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00aa:	7d 33                	jge    2c00df <process_main+0xdf>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00ac:	48 83 c0 08          	add    $0x8,%rax
  2c00b0:	48 39 d0             	cmp    %rdx,%rax
  2c00b3:	75 ee                	jne    2c00a3 <process_main+0xa3>
  2c00b5:	eb 50                	jmp    2c0107 <process_main+0x107>
	assert(array[i] == i);
  2c00b7:	ba 10 17 2c 00       	mov    $0x2c1710,%edx
  2c00bc:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c1:	bf 1e 17 2c 00       	mov    $0x2c171e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 34 17 2c 00       	mov    $0x2c1734,%edx
  2c00d0:	be 21 00 00 00       	mov    $0x21,%esi
  2c00d5:	bf 1e 17 2c 00       	mov    $0x2c171e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 58 17 2c 00       	mov    $0x2c1758,%edx
  2c00e4:	be 28 00 00 00       	mov    $0x28,%esi
  2c00e9:	bf 1e 17 2c 00       	mov    $0x2c171e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be 43 17 2c 00       	mov    $0x2c1743,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 07 02 00 00       	call   2c0316 <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 ff 01 00 00       	call   2c0316 <free>

    uint64_t total_time = 0;
  2c0117:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c011d:	0f 31                	rdtsc
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c011f:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0123:	89 c0                	mov    %eax,%eax
  2c0125:	48 09 c2             	or     %rax,%rdx
  2c0128:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c012b:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0130:	e8 0a 02 00 00       	call   2c033f <malloc>
  2c0135:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c0138:	0f 31                	rdtsc
	var = ((uint64_t)hi << 32) | lo;
  2c013a:	48 c1 e2 20          	shl    $0x20,%rdx
  2c013e:	89 c0                	mov    %eax,%eax
  2c0140:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c0143:	4c 29 f2             	sub    %r14,%rdx
  2c0146:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c0149:	48 85 c9             	test   %rcx,%rcx
  2c014c:	74 08                	je     2c0156 <process_main+0x156>
	    break;
	total_pages++;
  2c014e:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c0151:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0154:	eb c7                	jmp    2c011d <process_main+0x11d>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0156:	48 63 db             	movslq %ebx,%rbx
  2c0159:	4c 89 e8             	mov    %r13,%rax
  2c015c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0161:	48 f7 f3             	div    %rbx
  2c0164:	48 89 c1             	mov    %rax,%rcx
  2c0167:	4c 89 ea             	mov    %r13,%rdx
  2c016a:	be 88 17 2c 00       	mov    $0x2c1788,%esi
  2c016f:	44 89 e7             	mov    %r12d,%edi
  2c0172:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0177:	e8 04 00 00 00       	call   2c0180 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c017c:	cd 32                	int    $0x32

    // After running out of memory
    while (1) {
  2c017e:	eb fc                	jmp    2c017c <process_main+0x17c>

00000000002c0180 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c0180:	55                   	push   %rbp
  2c0181:	48 89 e5             	mov    %rsp,%rbp
  2c0184:	48 83 ec 50          	sub    $0x50,%rsp
  2c0188:	49 89 f2             	mov    %rsi,%r10
  2c018b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c018f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0193:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0197:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c019b:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c01a0:	85 ff                	test   %edi,%edi
  2c01a2:	78 2e                	js     2c01d2 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c01a4:	48 63 ff             	movslq %edi,%rdi
  2c01a7:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c01ae:	cc cc cc 
  2c01b1:	48 89 f8             	mov    %rdi,%rax
  2c01b4:	48 f7 e2             	mul    %rdx
  2c01b7:	48 89 d0             	mov    %rdx,%rax
  2c01ba:	48 c1 e8 02          	shr    $0x2,%rax
  2c01be:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c01c2:	48 01 c2             	add    %rax,%rdx
  2c01c5:	48 29 d7             	sub    %rdx,%rdi
  2c01c8:	0f b6 b7 ed 17 2c 00 	movzbl 0x2c17ed(%rdi),%esi
  2c01cf:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c01d2:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c01d9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c01dd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c01e1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c01e5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c01e9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c01ed:	4c 89 d2             	mov    %r10,%rdx
  2c01f0:	8b 3d 06 8e df ff    	mov    -0x2071fa(%rip),%edi        # b8ffc <cursorpos>
  2c01f6:	e8 09 13 00 00       	call   2c1504 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c01fb:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c0200:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0205:	0f 4d c2             	cmovge %edx,%eax
  2c0208:	89 05 ee 8d df ff    	mov    %eax,-0x207212(%rip)        # b8ffc <cursorpos>
    }
}
  2c020e:	c9                   	leave
  2c020f:	c3                   	ret

00000000002c0210 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c0210:	55                   	push   %rbp
  2c0211:	48 89 e5             	mov    %rsp,%rbp
  2c0214:	53                   	push   %rbx
  2c0215:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c021c:	48 89 fb             	mov    %rdi,%rbx
  2c021f:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c0223:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c0227:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c022b:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c022f:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c0233:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c023a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c023e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c0242:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c0246:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c024a:	ba 07 00 00 00       	mov    $0x7,%edx
  2c024f:	be b8 17 2c 00       	mov    $0x2c17b8,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 5b 04 00 00       	call   2c06bb <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 98 13 00 00       	call   2c1610 <vsnprintf>
  2c0278:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c027b:	85 d2                	test   %edx,%edx
  2c027d:	7e 0f                	jle    2c028e <kernel_panic+0x7e>
  2c027f:	83 c0 06             	add    $0x6,%eax
  2c0282:	48 98                	cltq
  2c0284:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c028b:	0a 
  2c028c:	75 2a                	jne    2c02b8 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c028e:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c0295:	48 89 d9             	mov    %rbx,%rcx
  2c0298:	ba c0 17 2c 00       	mov    $0x2c17c0,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 bf 12 00 00       	call   2c1570 <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  2c02b1:	48 89 df             	mov    %rbx,%rdi
  2c02b4:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  2c02b6:	eb fe                	jmp    2c02b6 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c02b8:	48 63 c2             	movslq %edx,%rax
  2c02bb:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c02c1:	0f 94 c2             	sete   %dl
  2c02c4:	0f b6 d2             	movzbl %dl,%edx
  2c02c7:	48 29 d0             	sub    %rdx,%rax
  2c02ca:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c02d1:	ff 
  2c02d2:	be 53 17 2c 00       	mov    $0x2c1753,%esi
  2c02d7:	e8 8c 05 00 00       	call   2c0868 <strcpy>
  2c02dc:	eb b0                	jmp    2c028e <kernel_panic+0x7e>

00000000002c02de <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c02de:	55                   	push   %rbp
  2c02df:	48 89 e5             	mov    %rsp,%rbp
  2c02e2:	48 89 f9             	mov    %rdi,%rcx
  2c02e5:	41 89 f0             	mov    %esi,%r8d
  2c02e8:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c02eb:	ba c8 17 2c 00       	mov    $0x2c17c8,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 6c 12 00 00       	call   2c1570 <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0304:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0309:	cd 30                	int    $0x30
 loop: goto loop;
  2c030b:	eb fe                	jmp    2c030b <assert_fail+0x2d>

00000000002c030d <align>:
// this creates the first node of the linked list
node *head = NULL;

// Function to align sizes to the nearest multiple of 8
size_t align(size_t size) {
    return (size + ALIGNMENT - 1) & ~(ALIGNMENT - 1);
  2c030d:	48 8d 47 07          	lea    0x7(%rdi),%rax
  2c0311:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  2c0315:	c3                   	ret

00000000002c0316 <free>:

// finished
void free(void *ptr) {
    // if the pointer is null already return NULL
    if (ptr == NULL)
  2c0316:	48 85 ff             	test   %rdi,%rdi
  2c0319:	74 1b                	je     2c0336 <free+0x20>
    {
        // will do nothing and just reeturn
        return;
    }
    //creates a new node to loop through thel inked list
    node * current = head;
  2c031b:	48 8b 05 de 1c 00 00 	mov    0x1cde(%rip),%rax        # 2c2000 <head>
    // while loop to loop through the lsit
    while (current != NULL)
  2c0322:	48 85 c0             	test   %rax,%rax
  2c0325:	74 0f                	je     2c0336 <free+0x20>
    {   
        // checks if that current pt_data is equal to requested pointer
        // if it is then
        if (current->pt_data == ptr)
  2c0327:	48 39 78 20          	cmp    %rdi,0x20(%rax)
  2c032b:	74 0a                	je     2c0337 <free+0x21>
            // sets the current to free -- this means sets to 1
            // current = 1 so that node is free
            current->free = 1;
            break;
        }
        current = current->next;
  2c032d:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (current != NULL)
  2c0331:	48 85 c0             	test   %rax,%rax
  2c0334:	75 f1                	jne    2c0327 <free+0x11>
    }

    // this will break out and just return
    return;

}
  2c0336:	c3                   	ret
            current->free = 1;
  2c0337:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
            break;
  2c033e:	c3                   	ret

00000000002c033f <malloc>:


// finished
void *malloc(uint64_t numbytes) {
    // if the number of bytes is 0 then return NULL
    if (numbytes == 0) {
  2c033f:	48 85 ff             	test   %rdi,%rdi
  2c0342:	0f 84 eb 00 00 00    	je     2c0433 <malloc+0xf4>
    return (size + ALIGNMENT - 1) & ~(ALIGNMENT - 1);
  2c0348:	48 8d 57 07          	lea    0x7(%rdi),%rdx
  2c034c:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx

    // this will align number of bytes
    numbytes = align(numbytes);

    // this is the total size
    uint64_t total_size = numbytes + NODE_SIZE;
  2c0350:	48 8d 7a 28          	lea    0x28(%rdx),%rdi

    // this checks if numbytes is greater than the max amount of energy
    if (numbytes > (0xffffffffffffffff - (uint64_t) NODE_SIZE))
  2c0354:	48 83 fa d7          	cmp    $0xffffffffffffffd7,%rdx
  2c0358:	0f 87 db 00 00 00    	ja     2c0439 <malloc+0xfa>
        return NULL;
    }

    // this will first create a node equal to head
    // allows for while loop
    node *current = head;
  2c035e:	48 8b 05 9b 1c 00 00 	mov    0x1c9b(%rip),%rax        # 2c2000 <head>

    // this will store the block found
    node *found = NULL;

    // searches for a free or suitable block
    while (current != NULL) {
  2c0365:	48 85 c0             	test   %rax,%rax
  2c0368:	75 62                	jne    2c03cc <malloc+0x8d>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c036a:	cd 3a                	int    $0x3a
  2c036c:	48 89 05 95 1c 00 00 	mov    %rax,0x1c95(%rip)        # 2c2008 <result.0>

    // heap expansion
    // create a node for expanding the heap
    node *expanded = sbrk(total_size);
    // if sbrk did not work then return NULL
    if (expanded == (void *)-1) {
  2c0373:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c0377:	0f 84 c2 00 00 00    	je     2c043f <malloc+0x100>
        return NULL;
    }

    // if expanded node assigns the size to numbytes
    // expanded size = num bytes
    expanded->size = numbytes;
  2c037d:	89 10                	mov    %edx,(%rax)
    // makes the node not free
    expanded->free = 0;
  2c037f:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    // expanded pt_data is equal to size of expanded + metadata
    expanded->pt_data = (char*)expanded + NODE_SIZE;
  2c0386:	48 8d 50 28          	lea    0x28(%rax),%rdx
  2c038a:	48 89 50 20          	mov    %rdx,0x20(%rax)
    // sets to end NULL since last node
    expanded->next = NULL;
  2c038e:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  2c0395:	00 
    // if no list has been created then make first
    // make first node in linked list
    if (head == NULL)
  2c0396:	48 8b 15 63 1c 00 00 	mov    0x1c63(%rip),%rdx        # 2c2000 <head>
  2c039d:	48 89 50 08          	mov    %rdx,0x8(%rax)
    {
        expanded->prev = head;
    }

    // if no list has been created then make first
    if (head == NULL) {
  2c03a1:	48 85 d2             	test   %rdx,%rdx
  2c03a4:	0f 84 80 00 00 00    	je     2c042a <malloc+0xeb>
        head = expanded;
    } else {
        // if list exists then have to find the last one
        node *last = head;
        // this while loop finds the last one
        while (last->next != NULL) {
  2c03aa:	48 89 d1             	mov    %rdx,%rcx
  2c03ad:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  2c03b1:	48 85 d2             	test   %rdx,%rdx
  2c03b4:	75 f4                	jne    2c03aa <malloc+0x6b>
            last = last->next;
        }
        last->next = expanded;
  2c03b6:	48 89 41 10          	mov    %rax,0x10(%rcx)
        expanded->prev = last;
  2c03ba:	48 89 48 08          	mov    %rcx,0x8(%rax)
    }

    // returns the node point data
    return expanded->pt_data;
  2c03be:	48 8b 40 20          	mov    0x20(%rax),%rax
  2c03c2:	c3                   	ret
        current = current->next;
  2c03c3:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (current != NULL) {
  2c03c7:	48 85 c0             	test   %rax,%rax
  2c03ca:	74 9e                	je     2c036a <malloc+0x2b>
        if (current->free == 1 && (uint64_t) current->size >= total_size) {
  2c03cc:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  2c03d0:	75 f1                	jne    2c03c3 <malloc+0x84>
  2c03d2:	48 63 08             	movslq (%rax),%rcx
  2c03d5:	48 39 f9             	cmp    %rdi,%rcx
  2c03d8:	72 e9                	jb     2c03c3 <malloc+0x84>
        if (found->size - total_size >= NODE_SIZE) {
  2c03da:	8b 30                	mov    (%rax),%esi
  2c03dc:	48 63 ce             	movslq %esi,%rcx
  2c03df:	48 29 f9             	sub    %rdi,%rcx
  2c03e2:	48 83 f9 27          	cmp    $0x27,%rcx
  2c03e6:	76 36                	jbe    2c041e <malloc+0xdf>
            node *new_node = (node *)((char *)found + total_size);
  2c03e8:	48 8d 0c 38          	lea    (%rax,%rdi,1),%rcx
            new_node->size = found->size - total_size;
  2c03ec:	29 fe                	sub    %edi,%esi
  2c03ee:	89 31                	mov    %esi,(%rcx)
            new_node->prev = found;
  2c03f0:	48 89 41 08          	mov    %rax,0x8(%rcx)
            new_node->free = 1;
  2c03f4:	c7 41 18 01 00 00 00 	movl   $0x1,0x18(%rcx)
            new_node->next = found->next;
  2c03fb:	48 8b 70 10          	mov    0x10(%rax),%rsi
  2c03ff:	48 89 71 10          	mov    %rsi,0x10(%rcx)
            new_node->pt_data = (char *)new_node + NODE_SIZE;
  2c0403:	48 8d 71 28          	lea    0x28(%rcx),%rsi
  2c0407:	48 89 71 20          	mov    %rsi,0x20(%rcx)
            if (found->next != NULL) {
  2c040b:	48 8b 70 10          	mov    0x10(%rax),%rsi
  2c040f:	48 85 f6             	test   %rsi,%rsi
  2c0412:	74 04                	je     2c0418 <malloc+0xd9>
                found->next->prev = new_node;
  2c0414:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
            found->next = new_node;
  2c0418:	48 89 48 10          	mov    %rcx,0x10(%rax)
            found->size = numbytes;
  2c041c:	89 10                	mov    %edx,(%rax)
        found->free = 0;
  2c041e:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        return found->pt_data;
  2c0425:	48 8b 40 20          	mov    0x20(%rax),%rax
  2c0429:	c3                   	ret
        head = expanded;
  2c042a:	48 89 05 cf 1b 00 00 	mov    %rax,0x1bcf(%rip)        # 2c2000 <head>
  2c0431:	eb 8b                	jmp    2c03be <malloc+0x7f>
        return NULL;
  2c0433:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0438:	c3                   	ret
        return NULL;
  2c0439:	b8 00 00 00 00       	mov    $0x0,%eax
  2c043e:	c3                   	ret
        return NULL;
  2c043f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c0444:	c3                   	ret

00000000002c0445 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  2c0445:	55                   	push   %rbp
  2c0446:	48 89 e5             	mov    %rsp,%rbp
  2c0449:	41 54                	push   %r12
  2c044b:	53                   	push   %rbx
    // edge case if num or sz is equal to 0, then calloc returns NULL
    //sz or num == 0
    // size or num is 0
    if (num == 0 || sz == 0)
  2c044c:	48 85 ff             	test   %rdi,%rdi
  2c044f:	74 4e                	je     2c049f <calloc+0x5a>
  2c0451:	48 85 f6             	test   %rsi,%rsi
  2c0454:	74 49                	je     2c049f <calloc+0x5a>
    // creates pointer
    void* pointer = NULL;
    // this checks if the number of bytes allocated is greater than total space available
    // checks max - node size divided by size
    // the second parts tells how many nums you can possibly have
    if (num > (0xffffffffffffffff - NODE_SIZE)/sz)
  2c0456:	48 c7 c0 d7 ff ff ff 	mov    $0xffffffffffffffd7,%rax
  2c045d:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0462:	48 f7 f6             	div    %rsi
    {
        return NULL;
  2c0465:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if (num > (0xffffffffffffffff - NODE_SIZE)/sz)
  2c046b:	48 39 f8             	cmp    %rdi,%rax
  2c046e:	72 27                	jb     2c0497 <calloc+0x52>
    uint64_t total = num * sz;
  2c0470:	48 89 fb             	mov    %rdi,%rbx
  2c0473:	48 0f af de          	imul   %rsi,%rbx
    }
    else
    {
        // malloc a certain total
        pointer = malloc(total);
  2c0477:	48 89 df             	mov    %rbx,%rdi
  2c047a:	e8 c0 fe ff ff       	call   2c033f <malloc>
  2c047f:	49 89 c4             	mov    %rax,%r12
        //this if the pointer is empty
        // this goes in if the pointer is NULL
        if (pointer != NULL){
  2c0482:	48 85 c0             	test   %rax,%rax
  2c0485:	74 10                	je     2c0497 <calloc+0x52>
            // this sets pointer to be 0 for total size if null pointer
            memset(pointer, 0, total);
  2c0487:	48 89 da             	mov    %rbx,%rdx
  2c048a:	be 00 00 00 00       	mov    $0x0,%esi
  2c048f:	48 89 c7             	mov    %rax,%rdi
  2c0492:	e8 22 03 00 00       	call   2c07b9 <memset>
        }
    }
    
    return pointer;
}
  2c0497:	4c 89 e0             	mov    %r12,%rax
  2c049a:	5b                   	pop    %rbx
  2c049b:	41 5c                	pop    %r12
  2c049d:	5d                   	pop    %rbp
  2c049e:	c3                   	ret
        return NULL;
  2c049f:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c04a5:	eb f0                	jmp    2c0497 <calloc+0x52>

00000000002c04a7 <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  2c04a7:	55                   	push   %rbp
  2c04a8:	48 89 e5             	mov    %rsp,%rbp
  2c04ab:	41 54                	push   %r12
  2c04ad:	53                   	push   %rbx
  2c04ae:	48 89 fb             	mov    %rdi,%rbx
    // this checks if size is 0
    // if size is 0 then returns null
    if (sz == 0)
  2c04b1:	48 85 f6             	test   %rsi,%rsi
  2c04b4:	75 25                	jne    2c04db <realloc+0x34>
    {
        // if ptr not null then free ptr
        if (ptr != NULL)
  2c04b6:	48 85 ff             	test   %rdi,%rdi
  2c04b9:	75 13                	jne    2c04ce <realloc+0x27>
    // this checks if the ptr is null
    // if pointer is NULL then call malloc
    if (ptr == NULL)
    {
        // if it is then just returns the malloc
        return malloc(sz);
  2c04bb:	48 89 f7             	mov    %rsi,%rdi
  2c04be:	e8 7c fe ff ff       	call   2c033f <malloc>
  2c04c3:	49 89 c4             	mov    %rax,%r12
    

    // returns the new location
    return new_node;

}
  2c04c6:	4c 89 e0             	mov    %r12,%rax
  2c04c9:	5b                   	pop    %rbx
  2c04ca:	41 5c                	pop    %r12
  2c04cc:	5d                   	pop    %rbp
  2c04cd:	c3                   	ret
            free(ptr);
  2c04ce:	e8 43 fe ff ff       	call   2c0316 <free>
            return NULL;
  2c04d3:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c04d9:	eb eb                	jmp    2c04c6 <realloc+0x1f>
    if (ptr == NULL)
  2c04db:	48 85 ff             	test   %rdi,%rdi
  2c04de:	74 db                	je     2c04bb <realloc+0x14>
    if (sz < (uint64_t) header->size)
  2c04e0:	48 63 87 c0 f9 ff ff 	movslq -0x640(%rdi),%rax
        return ptr;
  2c04e7:	49 89 fc             	mov    %rdi,%r12
    if (sz < (uint64_t) header->size)
  2c04ea:	48 39 c6             	cmp    %rax,%rsi
  2c04ed:	72 d7                	jb     2c04c6 <realloc+0x1f>
        if (sz > (0xffffffffffffffff - (uint64_t) NODE_SIZE))
  2c04ef:	48 83 fe d7          	cmp    $0xffffffffffffffd7,%rsi
  2c04f3:	77 31                	ja     2c0526 <realloc+0x7f>
  2c04f5:	48 39 f0             	cmp    %rsi,%rax
  2c04f8:	74 2c                	je     2c0526 <realloc+0x7f>
        new_node = malloc(sz);
  2c04fa:	48 89 f7             	mov    %rsi,%rdi
  2c04fd:	e8 3d fe ff ff       	call   2c033f <malloc>
  2c0502:	49 89 c4             	mov    %rax,%r12
        if (new_node == NULL)
  2c0505:	48 85 c0             	test   %rax,%rax
  2c0508:	74 bc                	je     2c04c6 <realloc+0x1f>
        memcpy(new_node, ptr, header->size);
  2c050a:	48 63 93 c0 f9 ff ff 	movslq -0x640(%rbx),%rdx
  2c0511:	48 89 de             	mov    %rbx,%rsi
  2c0514:	48 89 c7             	mov    %rax,%rdi
  2c0517:	e8 9f 01 00 00       	call   2c06bb <memcpy>
        free(ptr);
  2c051c:	48 89 df             	mov    %rbx,%rdi
  2c051f:	e8 f2 fd ff ff       	call   2c0316 <free>
  2c0524:	eb a0                	jmp    2c04c6 <realloc+0x1f>
            return NULL;
  2c0526:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c052c:	eb 98                	jmp    2c04c6 <realloc+0x1f>

00000000002c052e <defrag>:

// finished
void defrag() {
    // creates a node to loop through the linked list
    node *current = head;
  2c052e:	48 8b 05 cb 1a 00 00 	mov    0x1acb(%rip),%rax        # 2c2000 <head>
    
    while (current != NULL && current->next != NULL) {
  2c0535:	48 85 c0             	test   %rax,%rax
  2c0538:	75 08                	jne    2c0542 <defrag+0x14>
  2c053a:	c3                   	ret
            // this is needed for the doubly linked list
            // that means something after next
            if (next->next != NULL) {
                // sets the previous one to it before
                // sets the next next previous to be the current one
                next->next->prev = current;
  2c053b:	48 89 41 08          	mov    %rax,0x8(%rcx)
    while (current != NULL && current->next != NULL) {
  2c053f:	48 89 d0             	mov    %rdx,%rax
  2c0542:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0546:	48 85 d2             	test   %rdx,%rdx
  2c0549:	74 22                	je     2c056d <defrag+0x3f>
        if (current->free == 1 && current->next->free == 1) {
  2c054b:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  2c054f:	75 ee                	jne    2c053f <defrag+0x11>
  2c0551:	83 7a 18 01          	cmpl   $0x1,0x18(%rdx)
  2c0555:	75 e8                	jne    2c053f <defrag+0x11>
            current->size += next->size;  
  2c0557:	8b 0a                	mov    (%rdx),%ecx
  2c0559:	01 08                	add    %ecx,(%rax)
            current->next = next->next;
  2c055b:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  2c055f:	48 89 48 10          	mov    %rcx,0x10(%rax)
            if (next->next != NULL) {
  2c0563:	48 89 c2             	mov    %rax,%rdx
  2c0566:	48 85 c9             	test   %rcx,%rcx
  2c0569:	75 d0                	jne    2c053b <defrag+0xd>
  2c056b:	eb d2                	jmp    2c053f <defrag+0x11>
        } else {
            //that means just move on
            current = current->next;
        }
    }
}
  2c056d:	c3                   	ret

00000000002c056e <heap_info>:

int heap_info(heap_info_struct *info) {
  2c056e:	55                   	push   %rbp
  2c056f:	48 89 e5             	mov    %rsp,%rbp
  2c0572:	41 55                	push   %r13
  2c0574:	41 54                	push   %r12
  2c0576:	53                   	push   %rbx
  2c0577:	48 83 ec 08          	sub    $0x8,%rsp
  2c057b:	48 89 fb             	mov    %rdi,%rbx

    long * size_array = NULL;
    // allocates for array
    void **ptr_array = NULL;
    // Traverse the list to gather data
    node *current = head;
  2c057e:	48 8b 05 7b 1a 00 00 	mov    0x1a7b(%rip),%rax        # 2c2000 <head>

    while (current != NULL) {
  2c0585:	48 85 c0             	test   %rax,%rax
  2c0588:	0f 84 f9 00 00 00    	je     2c0687 <heap_info+0x119>
    int largest_free_chunk = 0;
  2c058e:	b9 00 00 00 00       	mov    $0x0,%ecx
    int total_free_space = 0;
  2c0593:	be 00 00 00 00       	mov    $0x0,%esi
    int num_allocs = 0;
  2c0598:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c059e:	eb 0d                	jmp    2c05ad <heap_info+0x3f>
                largest_free_chunk = current->size;
            }
        } else if (current->free == 0) {
            // this counts for how much allocations has been made
            // or non free nodes
            num_allocs++;
  2c05a0:	41 83 c4 01          	add    $0x1,%r12d
        }
        current = current->next;
  2c05a4:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (current != NULL) {
  2c05a8:	48 85 c0             	test   %rax,%rax
  2c05ab:	74 11                	je     2c05be <heap_info+0x50>
        if (current->free) {
  2c05ad:	83 78 18 00          	cmpl   $0x0,0x18(%rax)
  2c05b1:	74 ed                	je     2c05a0 <heap_info+0x32>
            total_free_space += current->size;
  2c05b3:	8b 10                	mov    (%rax),%edx
  2c05b5:	01 d6                	add    %edx,%esi
            if (current->size > largest_free_chunk) {
  2c05b7:	39 d1                	cmp    %edx,%ecx
  2c05b9:	0f 4c ca             	cmovl  %edx,%ecx
  2c05bc:	eb e6                	jmp    2c05a4 <heap_info+0x36>
    }

    // This will set the fields for the heap-info struct
    // this will set the fields for heap-info struct
    
    info->free_space = total_free_space;
  2c05be:	89 73 18             	mov    %esi,0x18(%rbx)
    info->largest_free_chunk = largest_free_chunk;
  2c05c1:	89 4b 1c             	mov    %ecx,0x1c(%rbx)

    // if there are no allocations then arrays are null
    if (num_allocs == 0)
  2c05c4:	45 85 e4             	test   %r12d,%r12d
  2c05c7:	0f 84 c8 00 00 00    	je     2c0695 <heap_info+0x127>
    //info->num_allocs = num_allocs;

    // after this while loop, you have largest free chunk, free space and num_allocs

    // allocates space for the array
    info->size_array = (long *)malloc((uint64_t) num_allocs * sizeof(long *));
  2c05cd:	4d 63 ec             	movslq %r12d,%r13
  2c05d0:	49 c1 e5 03          	shl    $0x3,%r13
  2c05d4:	4c 89 ef             	mov    %r13,%rdi
  2c05d7:	e8 63 fd ff ff       	call   2c033f <malloc>
  2c05dc:	48 89 43 08          	mov    %rax,0x8(%rbx)
    // allocates for array
    info->ptr_array = malloc(num_allocs * sizeof(uintptr_t));
  2c05e0:	4c 89 ef             	mov    %r13,%rdi
  2c05e3:	e8 57 fd ff ff       	call   2c033f <malloc>
  2c05e8:	48 89 43 10          	mov    %rax,0x10(%rbx)

    // if cannot malloc space correctly
    // returns -1
    if (info->ptr_array == NULL || info->size_array == NULL)
  2c05ec:	48 85 c0             	test   %rax,%rax
  2c05ef:	74 7a                	je     2c066b <heap_info+0xfd>
  2c05f1:	48 83 7b 08 00       	cmpq   $0x0,0x8(%rbx)
  2c05f6:	74 7a                	je     2c0672 <heap_info+0x104>
        current = current->next;
    }

    // This will sort the arrays based on descending order
    // this is for buble sort
    for (int i = 0; i < num_allocs - 1; i++) {
  2c05f8:	41 83 fc 01          	cmp    $0x1,%r12d
  2c05fc:	7e 7b                	jle    2c0679 <heap_info+0x10b>
  2c05fe:	45 89 e2             	mov    %r12d,%r10d
  2c0601:	eb 53                	jmp    2c0656 <heap_info+0xe8>
        for (int j = 0; j < num_allocs - i - 1; j++) {
  2c0603:	4c 39 c0             	cmp    %r8,%rax
  2c0606:	74 44                	je     2c064c <heap_info+0xde>
            // this compares the size array between current and the next one
            if (info->size_array[j] < info->size_array[j + 1]) {
  2c0608:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  2c060c:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
  2c0610:	48 8b 0e             	mov    (%rsi),%rcx
  2c0613:	48 89 c7             	mov    %rax,%rdi
  2c0616:	48 83 c0 08          	add    $0x8,%rax
  2c061a:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
  2c061e:	48 39 d1             	cmp    %rdx,%rcx
  2c0621:	7d e0                	jge    2c0603 <heap_info+0x95>

                long temp_size = info->size_array[j];
                void *temp_ptr = info->ptr_array[j];
  2c0623:	4c 8b 4b 10          	mov    0x10(%rbx),%r9
  2c0627:	4d 8b 0c 39          	mov    (%r9,%rdi,1),%r9
                // this will flip the next and other one next to each other
                info->size_array[j] = info->size_array[j + 1];
  2c062b:	48 89 16             	mov    %rdx,(%rsi)
                info->ptr_array[j] = info->ptr_array[j + 1];
  2c062e:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c0632:	48 8b 34 02          	mov    (%rdx,%rax,1),%rsi
  2c0636:	48 89 34 3a          	mov    %rsi,(%rdx,%rdi,1)
                // this will also change ptr_array
                info->size_array[j + 1] = temp_size;
  2c063a:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  2c063e:	48 89 0c 02          	mov    %rcx,(%rdx,%rax,1)
                info->ptr_array[j + 1] = temp_ptr;
  2c0642:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  2c0646:	4c 89 0c 02          	mov    %r9,(%rdx,%rax,1)
  2c064a:	eb b7                	jmp    2c0603 <heap_info+0x95>
    for (int i = 0; i < num_allocs - 1; i++) {
  2c064c:	41 83 ea 01          	sub    $0x1,%r10d
  2c0650:	41 83 fa 01          	cmp    $0x1,%r10d
  2c0654:	74 2a                	je     2c0680 <heap_info+0x112>
        for (int j = 0; j < num_allocs - i - 1; j++) {
  2c0656:	41 83 fa 01          	cmp    $0x1,%r10d
  2c065a:	7e 59                	jle    2c06b5 <heap_info+0x147>
  2c065c:	45 8d 42 ff          	lea    -0x1(%r10),%r8d
  2c0660:	49 c1 e0 03          	shl    $0x3,%r8
  2c0664:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0669:	eb 9d                	jmp    2c0608 <heap_info+0x9a>
        return -1;
  2c066b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0670:	eb 38                	jmp    2c06aa <heap_info+0x13c>
  2c0672:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0677:	eb 31                	jmp    2c06aa <heap_info+0x13c>
            }
        }
    }

    // returns a 0 if successful
    return 0; 
  2c0679:	b8 00 00 00 00       	mov    $0x0,%eax
  2c067e:	eb 2a                	jmp    2c06aa <heap_info+0x13c>
  2c0680:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0685:	eb 23                	jmp    2c06aa <heap_info+0x13c>
    info->free_space = total_free_space;
  2c0687:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = largest_free_chunk;
  2c068e:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
        info->size_array = NULL;
  2c0695:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c069c:	00 
        info->ptr_array = NULL;
  2c069d:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  2c06a4:	00 
        return 0;
  2c06a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c06aa:	48 83 c4 08          	add    $0x8,%rsp
  2c06ae:	5b                   	pop    %rbx
  2c06af:	41 5c                	pop    %r12
  2c06b1:	41 5d                	pop    %r13
  2c06b3:	5d                   	pop    %rbp
  2c06b4:	c3                   	ret
    for (int i = 0; i < num_allocs - 1; i++) {
  2c06b5:	41 83 ea 01          	sub    $0x1,%r10d
  2c06b9:	eb 9b                	jmp    2c0656 <heap_info+0xe8>

00000000002c06bb <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c06bb:	55                   	push   %rbp
  2c06bc:	48 89 e5             	mov    %rsp,%rbp
  2c06bf:	48 83 ec 28          	sub    $0x28,%rsp
  2c06c3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c06c7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c06cb:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c06cf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c06d3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c06d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c06db:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c06df:	eb 1c                	jmp    2c06fd <memcpy+0x42>
        *d = *s;
  2c06e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06e5:	0f b6 10             	movzbl (%rax),%edx
  2c06e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c06ec:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c06ee:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c06f3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c06f8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c06fd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0702:	75 dd                	jne    2c06e1 <memcpy+0x26>
    }
    return dst;
  2c0704:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0708:	c9                   	leave
  2c0709:	c3                   	ret

00000000002c070a <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c070a:	55                   	push   %rbp
  2c070b:	48 89 e5             	mov    %rsp,%rbp
  2c070e:	48 83 ec 28          	sub    $0x28,%rsp
  2c0712:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0716:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c071a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c071e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0722:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0726:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c072a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c072e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0732:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0736:	73 6a                	jae    2c07a2 <memmove+0x98>
  2c0738:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c073c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0740:	48 01 d0             	add    %rdx,%rax
  2c0743:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0747:	73 59                	jae    2c07a2 <memmove+0x98>
        s += n, d += n;
  2c0749:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c074d:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0751:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0755:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0759:	eb 17                	jmp    2c0772 <memmove+0x68>
            *--d = *--s;
  2c075b:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0760:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0765:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0769:	0f b6 10             	movzbl (%rax),%edx
  2c076c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0770:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0772:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0776:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c077a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c077e:	48 85 c0             	test   %rax,%rax
  2c0781:	75 d8                	jne    2c075b <memmove+0x51>
    if (s < d && s + n > d) {
  2c0783:	eb 2e                	jmp    2c07b3 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0785:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0789:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c078d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0791:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0795:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0799:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c079d:	0f b6 12             	movzbl (%rdx),%edx
  2c07a0:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c07a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c07a6:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c07aa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c07ae:	48 85 c0             	test   %rax,%rax
  2c07b1:	75 d2                	jne    2c0785 <memmove+0x7b>
        }
    }
    return dst;
  2c07b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c07b7:	c9                   	leave
  2c07b8:	c3                   	ret

00000000002c07b9 <memset>:

void* memset(void* v, int c, size_t n) {
  2c07b9:	55                   	push   %rbp
  2c07ba:	48 89 e5             	mov    %rsp,%rbp
  2c07bd:	48 83 ec 28          	sub    $0x28,%rsp
  2c07c1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c07c5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c07c8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c07cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c07d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c07d4:	eb 15                	jmp    2c07eb <memset+0x32>
        *p = c;
  2c07d6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c07d9:	89 c2                	mov    %eax,%edx
  2c07db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07df:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c07e1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c07e6:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c07eb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c07f0:	75 e4                	jne    2c07d6 <memset+0x1d>
    }
    return v;
  2c07f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c07f6:	c9                   	leave
  2c07f7:	c3                   	ret

00000000002c07f8 <strlen>:

size_t strlen(const char* s) {
  2c07f8:	55                   	push   %rbp
  2c07f9:	48 89 e5             	mov    %rsp,%rbp
  2c07fc:	48 83 ec 18          	sub    $0x18,%rsp
  2c0800:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0804:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c080b:	00 
  2c080c:	eb 0a                	jmp    2c0818 <strlen+0x20>
        ++n;
  2c080e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0813:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0818:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c081c:	0f b6 00             	movzbl (%rax),%eax
  2c081f:	84 c0                	test   %al,%al
  2c0821:	75 eb                	jne    2c080e <strlen+0x16>
    }
    return n;
  2c0823:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0827:	c9                   	leave
  2c0828:	c3                   	ret

00000000002c0829 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0829:	55                   	push   %rbp
  2c082a:	48 89 e5             	mov    %rsp,%rbp
  2c082d:	48 83 ec 20          	sub    $0x20,%rsp
  2c0831:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0835:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0839:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0840:	00 
  2c0841:	eb 0a                	jmp    2c084d <strnlen+0x24>
        ++n;
  2c0843:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0848:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c084d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0851:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0855:	74 0b                	je     2c0862 <strnlen+0x39>
  2c0857:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c085b:	0f b6 00             	movzbl (%rax),%eax
  2c085e:	84 c0                	test   %al,%al
  2c0860:	75 e1                	jne    2c0843 <strnlen+0x1a>
    }
    return n;
  2c0862:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0866:	c9                   	leave
  2c0867:	c3                   	ret

00000000002c0868 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0868:	55                   	push   %rbp
  2c0869:	48 89 e5             	mov    %rsp,%rbp
  2c086c:	48 83 ec 20          	sub    $0x20,%rsp
  2c0870:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0874:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0878:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c087c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0880:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0884:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0888:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c088c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0890:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0894:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0898:	0f b6 12             	movzbl (%rdx),%edx
  2c089b:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c089d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08a1:	48 83 e8 01          	sub    $0x1,%rax
  2c08a5:	0f b6 00             	movzbl (%rax),%eax
  2c08a8:	84 c0                	test   %al,%al
  2c08aa:	75 d4                	jne    2c0880 <strcpy+0x18>
    return dst;
  2c08ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c08b0:	c9                   	leave
  2c08b1:	c3                   	ret

00000000002c08b2 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c08b2:	55                   	push   %rbp
  2c08b3:	48 89 e5             	mov    %rsp,%rbp
  2c08b6:	48 83 ec 10          	sub    $0x10,%rsp
  2c08ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c08be:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c08c2:	eb 0a                	jmp    2c08ce <strcmp+0x1c>
        ++a, ++b;
  2c08c4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c08c9:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c08ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08d2:	0f b6 00             	movzbl (%rax),%eax
  2c08d5:	84 c0                	test   %al,%al
  2c08d7:	74 1d                	je     2c08f6 <strcmp+0x44>
  2c08d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c08dd:	0f b6 00             	movzbl (%rax),%eax
  2c08e0:	84 c0                	test   %al,%al
  2c08e2:	74 12                	je     2c08f6 <strcmp+0x44>
  2c08e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08e8:	0f b6 10             	movzbl (%rax),%edx
  2c08eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c08ef:	0f b6 00             	movzbl (%rax),%eax
  2c08f2:	38 c2                	cmp    %al,%dl
  2c08f4:	74 ce                	je     2c08c4 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c08f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08fa:	0f b6 00             	movzbl (%rax),%eax
  2c08fd:	89 c2                	mov    %eax,%edx
  2c08ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0903:	0f b6 00             	movzbl (%rax),%eax
  2c0906:	38 d0                	cmp    %dl,%al
  2c0908:	0f 92 c0             	setb   %al
  2c090b:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c090e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0912:	0f b6 00             	movzbl (%rax),%eax
  2c0915:	89 c1                	mov    %eax,%ecx
  2c0917:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c091b:	0f b6 00             	movzbl (%rax),%eax
  2c091e:	38 c1                	cmp    %al,%cl
  2c0920:	0f 92 c0             	setb   %al
  2c0923:	0f b6 c0             	movzbl %al,%eax
  2c0926:	29 c2                	sub    %eax,%edx
  2c0928:	89 d0                	mov    %edx,%eax
}
  2c092a:	c9                   	leave
  2c092b:	c3                   	ret

00000000002c092c <strchr>:

char* strchr(const char* s, int c) {
  2c092c:	55                   	push   %rbp
  2c092d:	48 89 e5             	mov    %rsp,%rbp
  2c0930:	48 83 ec 10          	sub    $0x10,%rsp
  2c0934:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0938:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c093b:	eb 05                	jmp    2c0942 <strchr+0x16>
        ++s;
  2c093d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0942:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0946:	0f b6 00             	movzbl (%rax),%eax
  2c0949:	84 c0                	test   %al,%al
  2c094b:	74 0e                	je     2c095b <strchr+0x2f>
  2c094d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0951:	0f b6 00             	movzbl (%rax),%eax
  2c0954:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0957:	38 d0                	cmp    %dl,%al
  2c0959:	75 e2                	jne    2c093d <strchr+0x11>
    }
    if (*s == (char) c) {
  2c095b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c095f:	0f b6 00             	movzbl (%rax),%eax
  2c0962:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0965:	38 d0                	cmp    %dl,%al
  2c0967:	75 06                	jne    2c096f <strchr+0x43>
        return (char*) s;
  2c0969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c096d:	eb 05                	jmp    2c0974 <strchr+0x48>
    } else {
        return NULL;
  2c096f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0974:	c9                   	leave
  2c0975:	c3                   	ret

00000000002c0976 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0976:	55                   	push   %rbp
  2c0977:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c097a:	8b 05 90 16 00 00    	mov    0x1690(%rip),%eax        # 2c2010 <rand_seed_set>
  2c0980:	85 c0                	test   %eax,%eax
  2c0982:	75 0a                	jne    2c098e <rand+0x18>
        srand(819234718U);
  2c0984:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0989:	e8 24 00 00 00       	call   2c09b2 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c098e:	8b 05 80 16 00 00    	mov    0x1680(%rip),%eax        # 2c2014 <rand_seed>
  2c0994:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c099a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c099f:	89 05 6f 16 00 00    	mov    %eax,0x166f(%rip)        # 2c2014 <rand_seed>
    return rand_seed & RAND_MAX;
  2c09a5:	8b 05 69 16 00 00    	mov    0x1669(%rip),%eax        # 2c2014 <rand_seed>
  2c09ab:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c09b0:	5d                   	pop    %rbp
  2c09b1:	c3                   	ret

00000000002c09b2 <srand>:

void srand(unsigned seed) {
  2c09b2:	55                   	push   %rbp
  2c09b3:	48 89 e5             	mov    %rsp,%rbp
  2c09b6:	48 83 ec 08          	sub    $0x8,%rsp
  2c09ba:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c09bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c09c0:	89 05 4e 16 00 00    	mov    %eax,0x164e(%rip)        # 2c2014 <rand_seed>
    rand_seed_set = 1;
  2c09c6:	c7 05 40 16 00 00 01 	movl   $0x1,0x1640(%rip)        # 2c2010 <rand_seed_set>
  2c09cd:	00 00 00 
}
  2c09d0:	90                   	nop
  2c09d1:	c9                   	leave
  2c09d2:	c3                   	ret

00000000002c09d3 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c09d3:	55                   	push   %rbp
  2c09d4:	48 89 e5             	mov    %rsp,%rbp
  2c09d7:	48 83 ec 28          	sub    $0x28,%rsp
  2c09db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c09df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c09e3:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c09e6:	48 c7 45 f8 e0 19 2c 	movq   $0x2c19e0,-0x8(%rbp)
  2c09ed:	00 
    if (base < 0) {
  2c09ee:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c09f2:	79 0b                	jns    2c09ff <fill_numbuf+0x2c>
        digits = lower_digits;
  2c09f4:	48 c7 45 f8 00 1a 2c 	movq   $0x2c1a00,-0x8(%rbp)
  2c09fb:	00 
        base = -base;
  2c09fc:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c09ff:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0a04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a08:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0a0b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0a0e:	48 63 c8             	movslq %eax,%rcx
  2c0a11:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a15:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0a1a:	48 f7 f1             	div    %rcx
  2c0a1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a21:	48 01 d0             	add    %rdx,%rax
  2c0a24:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0a29:	0f b6 10             	movzbl (%rax),%edx
  2c0a2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a30:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0a32:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0a35:	48 63 f0             	movslq %eax,%rsi
  2c0a38:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a3c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0a41:	48 f7 f6             	div    %rsi
  2c0a44:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0a48:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0a4d:	75 bc                	jne    2c0a0b <fill_numbuf+0x38>
    return numbuf_end;
  2c0a4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0a53:	c9                   	leave
  2c0a54:	c3                   	ret

00000000002c0a55 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0a55:	55                   	push   %rbp
  2c0a56:	48 89 e5             	mov    %rsp,%rbp
  2c0a59:	53                   	push   %rbx
  2c0a5a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0a61:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0a68:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0a6e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0a75:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0a7c:	e9 8a 09 00 00       	jmp    2c140b <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0a81:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a88:	0f b6 00             	movzbl (%rax),%eax
  2c0a8b:	3c 25                	cmp    $0x25,%al
  2c0a8d:	74 31                	je     2c0ac0 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0a8f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0a96:	4c 8b 00             	mov    (%rax),%r8
  2c0a99:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0aa0:	0f b6 00             	movzbl (%rax),%eax
  2c0aa3:	0f b6 c8             	movzbl %al,%ecx
  2c0aa6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0aac:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0ab3:	89 ce                	mov    %ecx,%esi
  2c0ab5:	48 89 c7             	mov    %rax,%rdi
  2c0ab8:	41 ff d0             	call   *%r8
            continue;
  2c0abb:	e9 43 09 00 00       	jmp    2c1403 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0ac0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0ac7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ace:	01 
  2c0acf:	eb 44                	jmp    2c0b15 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0ad1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ad8:	0f b6 00             	movzbl (%rax),%eax
  2c0adb:	0f be c0             	movsbl %al,%eax
  2c0ade:	89 c6                	mov    %eax,%esi
  2c0ae0:	bf 00 18 2c 00       	mov    $0x2c1800,%edi
  2c0ae5:	e8 42 fe ff ff       	call   2c092c <strchr>
  2c0aea:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0aee:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0af3:	74 30                	je     2c0b25 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0af5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0af9:	48 2d 00 18 2c 00    	sub    $0x2c1800,%rax
  2c0aff:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0b04:	89 c1                	mov    %eax,%ecx
  2c0b06:	d3 e2                	shl    %cl,%edx
  2c0b08:	89 d0                	mov    %edx,%eax
  2c0b0a:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0b0d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0b14:	01 
  2c0b15:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b1c:	0f b6 00             	movzbl (%rax),%eax
  2c0b1f:	84 c0                	test   %al,%al
  2c0b21:	75 ae                	jne    2c0ad1 <printer_vprintf+0x7c>
  2c0b23:	eb 01                	jmp    2c0b26 <printer_vprintf+0xd1>
            } else {
                break;
  2c0b25:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0b26:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0b2d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b34:	0f b6 00             	movzbl (%rax),%eax
  2c0b37:	3c 30                	cmp    $0x30,%al
  2c0b39:	7e 67                	jle    2c0ba2 <printer_vprintf+0x14d>
  2c0b3b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b42:	0f b6 00             	movzbl (%rax),%eax
  2c0b45:	3c 39                	cmp    $0x39,%al
  2c0b47:	7f 59                	jg     2c0ba2 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0b49:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0b50:	eb 2e                	jmp    2c0b80 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0b52:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0b55:	89 d0                	mov    %edx,%eax
  2c0b57:	c1 e0 02             	shl    $0x2,%eax
  2c0b5a:	01 d0                	add    %edx,%eax
  2c0b5c:	01 c0                	add    %eax,%eax
  2c0b5e:	89 c1                	mov    %eax,%ecx
  2c0b60:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b67:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0b6b:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0b72:	0f b6 00             	movzbl (%rax),%eax
  2c0b75:	0f be c0             	movsbl %al,%eax
  2c0b78:	01 c8                	add    %ecx,%eax
  2c0b7a:	83 e8 30             	sub    $0x30,%eax
  2c0b7d:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0b80:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b87:	0f b6 00             	movzbl (%rax),%eax
  2c0b8a:	3c 2f                	cmp    $0x2f,%al
  2c0b8c:	0f 8e 85 00 00 00    	jle    2c0c17 <printer_vprintf+0x1c2>
  2c0b92:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b99:	0f b6 00             	movzbl (%rax),%eax
  2c0b9c:	3c 39                	cmp    $0x39,%al
  2c0b9e:	7e b2                	jle    2c0b52 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0ba0:	eb 75                	jmp    2c0c17 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0ba2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ba9:	0f b6 00             	movzbl (%rax),%eax
  2c0bac:	3c 2a                	cmp    $0x2a,%al
  2c0bae:	75 68                	jne    2c0c18 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0bb0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bb7:	8b 00                	mov    (%rax),%eax
  2c0bb9:	83 f8 2f             	cmp    $0x2f,%eax
  2c0bbc:	77 30                	ja     2c0bee <printer_vprintf+0x199>
  2c0bbe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bc5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0bc9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bd0:	8b 00                	mov    (%rax),%eax
  2c0bd2:	89 c0                	mov    %eax,%eax
  2c0bd4:	48 01 d0             	add    %rdx,%rax
  2c0bd7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bde:	8b 12                	mov    (%rdx),%edx
  2c0be0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0be3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bea:	89 0a                	mov    %ecx,(%rdx)
  2c0bec:	eb 1a                	jmp    2c0c08 <printer_vprintf+0x1b3>
  2c0bee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bf5:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0bf9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0bfd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c04:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c08:	8b 00                	mov    (%rax),%eax
  2c0c0a:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0c0d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c14:	01 
  2c0c15:	eb 01                	jmp    2c0c18 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0c17:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0c18:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0c1f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c26:	0f b6 00             	movzbl (%rax),%eax
  2c0c29:	3c 2e                	cmp    $0x2e,%al
  2c0c2b:	0f 85 00 01 00 00    	jne    2c0d31 <printer_vprintf+0x2dc>
            ++format;
  2c0c31:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c38:	01 
            if (*format >= '0' && *format <= '9') {
  2c0c39:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c40:	0f b6 00             	movzbl (%rax),%eax
  2c0c43:	3c 2f                	cmp    $0x2f,%al
  2c0c45:	7e 67                	jle    2c0cae <printer_vprintf+0x259>
  2c0c47:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c4e:	0f b6 00             	movzbl (%rax),%eax
  2c0c51:	3c 39                	cmp    $0x39,%al
  2c0c53:	7f 59                	jg     2c0cae <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0c55:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0c5c:	eb 2e                	jmp    2c0c8c <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0c5e:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0c61:	89 d0                	mov    %edx,%eax
  2c0c63:	c1 e0 02             	shl    $0x2,%eax
  2c0c66:	01 d0                	add    %edx,%eax
  2c0c68:	01 c0                	add    %eax,%eax
  2c0c6a:	89 c1                	mov    %eax,%ecx
  2c0c6c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c73:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0c77:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0c7e:	0f b6 00             	movzbl (%rax),%eax
  2c0c81:	0f be c0             	movsbl %al,%eax
  2c0c84:	01 c8                	add    %ecx,%eax
  2c0c86:	83 e8 30             	sub    $0x30,%eax
  2c0c89:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0c8c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c93:	0f b6 00             	movzbl (%rax),%eax
  2c0c96:	3c 2f                	cmp    $0x2f,%al
  2c0c98:	0f 8e 85 00 00 00    	jle    2c0d23 <printer_vprintf+0x2ce>
  2c0c9e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ca5:	0f b6 00             	movzbl (%rax),%eax
  2c0ca8:	3c 39                	cmp    $0x39,%al
  2c0caa:	7e b2                	jle    2c0c5e <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0cac:	eb 75                	jmp    2c0d23 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0cae:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cb5:	0f b6 00             	movzbl (%rax),%eax
  2c0cb8:	3c 2a                	cmp    $0x2a,%al
  2c0cba:	75 68                	jne    2c0d24 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0cbc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cc3:	8b 00                	mov    (%rax),%eax
  2c0cc5:	83 f8 2f             	cmp    $0x2f,%eax
  2c0cc8:	77 30                	ja     2c0cfa <printer_vprintf+0x2a5>
  2c0cca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cd1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0cd5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cdc:	8b 00                	mov    (%rax),%eax
  2c0cde:	89 c0                	mov    %eax,%eax
  2c0ce0:	48 01 d0             	add    %rdx,%rax
  2c0ce3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cea:	8b 12                	mov    (%rdx),%edx
  2c0cec:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0cef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cf6:	89 0a                	mov    %ecx,(%rdx)
  2c0cf8:	eb 1a                	jmp    2c0d14 <printer_vprintf+0x2bf>
  2c0cfa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d01:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d05:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d09:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d10:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d14:	8b 00                	mov    (%rax),%eax
  2c0d16:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0d19:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d20:	01 
  2c0d21:	eb 01                	jmp    2c0d24 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c0d23:	90                   	nop
            }
            if (precision < 0) {
  2c0d24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0d28:	79 07                	jns    2c0d31 <printer_vprintf+0x2dc>
                precision = 0;
  2c0d2a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0d31:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0d38:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0d3f:	00 
        int length = 0;
  2c0d40:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0d47:	48 c7 45 c8 06 18 2c 	movq   $0x2c1806,-0x38(%rbp)
  2c0d4e:	00 
    again:
        switch (*format) {
  2c0d4f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d56:	0f b6 00             	movzbl (%rax),%eax
  2c0d59:	0f be c0             	movsbl %al,%eax
  2c0d5c:	83 e8 43             	sub    $0x43,%eax
  2c0d5f:	83 f8 37             	cmp    $0x37,%eax
  2c0d62:	0f 87 9f 03 00 00    	ja     2c1107 <printer_vprintf+0x6b2>
  2c0d68:	89 c0                	mov    %eax,%eax
  2c0d6a:	48 8b 04 c5 18 18 2c 	mov    0x2c1818(,%rax,8),%rax
  2c0d71:	00 
  2c0d72:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0d74:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0d7b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d82:	01 
            goto again;
  2c0d83:	eb ca                	jmp    2c0d4f <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0d85:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0d89:	74 5d                	je     2c0de8 <printer_vprintf+0x393>
  2c0d8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d92:	8b 00                	mov    (%rax),%eax
  2c0d94:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d97:	77 30                	ja     2c0dc9 <printer_vprintf+0x374>
  2c0d99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0da0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0da4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dab:	8b 00                	mov    (%rax),%eax
  2c0dad:	89 c0                	mov    %eax,%eax
  2c0daf:	48 01 d0             	add    %rdx,%rax
  2c0db2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0db9:	8b 12                	mov    (%rdx),%edx
  2c0dbb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0dbe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dc5:	89 0a                	mov    %ecx,(%rdx)
  2c0dc7:	eb 1a                	jmp    2c0de3 <printer_vprintf+0x38e>
  2c0dc9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dd0:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0dd4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0dd8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ddf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0de3:	48 8b 00             	mov    (%rax),%rax
  2c0de6:	eb 5c                	jmp    2c0e44 <printer_vprintf+0x3ef>
  2c0de8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0def:	8b 00                	mov    (%rax),%eax
  2c0df1:	83 f8 2f             	cmp    $0x2f,%eax
  2c0df4:	77 30                	ja     2c0e26 <printer_vprintf+0x3d1>
  2c0df6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dfd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e01:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e08:	8b 00                	mov    (%rax),%eax
  2c0e0a:	89 c0                	mov    %eax,%eax
  2c0e0c:	48 01 d0             	add    %rdx,%rax
  2c0e0f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e16:	8b 12                	mov    (%rdx),%edx
  2c0e18:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e1b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e22:	89 0a                	mov    %ecx,(%rdx)
  2c0e24:	eb 1a                	jmp    2c0e40 <printer_vprintf+0x3eb>
  2c0e26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e2d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e31:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e35:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e3c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e40:	8b 00                	mov    (%rax),%eax
  2c0e42:	48 98                	cltq
  2c0e44:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0e48:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e4c:	48 c1 f8 38          	sar    $0x38,%rax
  2c0e50:	25 80 00 00 00       	and    $0x80,%eax
  2c0e55:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0e58:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0e5c:	74 09                	je     2c0e67 <printer_vprintf+0x412>
  2c0e5e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e62:	48 f7 d8             	neg    %rax
  2c0e65:	eb 04                	jmp    2c0e6b <printer_vprintf+0x416>
  2c0e67:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e6b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0e6f:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0e72:	83 c8 60             	or     $0x60,%eax
  2c0e75:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0e78:	e9 cf 02 00 00       	jmp    2c114c <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0e7d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0e81:	74 5d                	je     2c0ee0 <printer_vprintf+0x48b>
  2c0e83:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e8a:	8b 00                	mov    (%rax),%eax
  2c0e8c:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e8f:	77 30                	ja     2c0ec1 <printer_vprintf+0x46c>
  2c0e91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e98:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e9c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ea3:	8b 00                	mov    (%rax),%eax
  2c0ea5:	89 c0                	mov    %eax,%eax
  2c0ea7:	48 01 d0             	add    %rdx,%rax
  2c0eaa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eb1:	8b 12                	mov    (%rdx),%edx
  2c0eb3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0eb6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ebd:	89 0a                	mov    %ecx,(%rdx)
  2c0ebf:	eb 1a                	jmp    2c0edb <printer_vprintf+0x486>
  2c0ec1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ec8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ecc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ed0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ed7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0edb:	48 8b 00             	mov    (%rax),%rax
  2c0ede:	eb 5c                	jmp    2c0f3c <printer_vprintf+0x4e7>
  2c0ee0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ee7:	8b 00                	mov    (%rax),%eax
  2c0ee9:	83 f8 2f             	cmp    $0x2f,%eax
  2c0eec:	77 30                	ja     2c0f1e <printer_vprintf+0x4c9>
  2c0eee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ef5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0ef9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f00:	8b 00                	mov    (%rax),%eax
  2c0f02:	89 c0                	mov    %eax,%eax
  2c0f04:	48 01 d0             	add    %rdx,%rax
  2c0f07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f0e:	8b 12                	mov    (%rdx),%edx
  2c0f10:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f13:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f1a:	89 0a                	mov    %ecx,(%rdx)
  2c0f1c:	eb 1a                	jmp    2c0f38 <printer_vprintf+0x4e3>
  2c0f1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f25:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f29:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f34:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f38:	8b 00                	mov    (%rax),%eax
  2c0f3a:	89 c0                	mov    %eax,%eax
  2c0f3c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0f40:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0f44:	e9 03 02 00 00       	jmp    2c114c <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c0f49:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0f50:	e9 28 ff ff ff       	jmp    2c0e7d <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c0f55:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0f5c:	e9 1c ff ff ff       	jmp    2c0e7d <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0f61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f68:	8b 00                	mov    (%rax),%eax
  2c0f6a:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f6d:	77 30                	ja     2c0f9f <printer_vprintf+0x54a>
  2c0f6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f76:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f81:	8b 00                	mov    (%rax),%eax
  2c0f83:	89 c0                	mov    %eax,%eax
  2c0f85:	48 01 d0             	add    %rdx,%rax
  2c0f88:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f8f:	8b 12                	mov    (%rdx),%edx
  2c0f91:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f94:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f9b:	89 0a                	mov    %ecx,(%rdx)
  2c0f9d:	eb 1a                	jmp    2c0fb9 <printer_vprintf+0x564>
  2c0f9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fa6:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0faa:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fb5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fb9:	48 8b 00             	mov    (%rax),%rax
  2c0fbc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0fc0:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0fc7:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0fce:	e9 79 01 00 00       	jmp    2c114c <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c0fd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fda:	8b 00                	mov    (%rax),%eax
  2c0fdc:	83 f8 2f             	cmp    $0x2f,%eax
  2c0fdf:	77 30                	ja     2c1011 <printer_vprintf+0x5bc>
  2c0fe1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fe8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0fec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ff3:	8b 00                	mov    (%rax),%eax
  2c0ff5:	89 c0                	mov    %eax,%eax
  2c0ff7:	48 01 d0             	add    %rdx,%rax
  2c0ffa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1001:	8b 12                	mov    (%rdx),%edx
  2c1003:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1006:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c100d:	89 0a                	mov    %ecx,(%rdx)
  2c100f:	eb 1a                	jmp    2c102b <printer_vprintf+0x5d6>
  2c1011:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1018:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c101c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1020:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1027:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c102b:	48 8b 00             	mov    (%rax),%rax
  2c102e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c1032:	e9 15 01 00 00       	jmp    2c114c <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c1037:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c103e:	8b 00                	mov    (%rax),%eax
  2c1040:	83 f8 2f             	cmp    $0x2f,%eax
  2c1043:	77 30                	ja     2c1075 <printer_vprintf+0x620>
  2c1045:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c104c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1050:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1057:	8b 00                	mov    (%rax),%eax
  2c1059:	89 c0                	mov    %eax,%eax
  2c105b:	48 01 d0             	add    %rdx,%rax
  2c105e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1065:	8b 12                	mov    (%rdx),%edx
  2c1067:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c106a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1071:	89 0a                	mov    %ecx,(%rdx)
  2c1073:	eb 1a                	jmp    2c108f <printer_vprintf+0x63a>
  2c1075:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c107c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1080:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1084:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c108b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c108f:	8b 00                	mov    (%rax),%eax
  2c1091:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c1097:	e9 67 03 00 00       	jmp    2c1403 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c109c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c10a0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c10a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10ab:	8b 00                	mov    (%rax),%eax
  2c10ad:	83 f8 2f             	cmp    $0x2f,%eax
  2c10b0:	77 30                	ja     2c10e2 <printer_vprintf+0x68d>
  2c10b2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10b9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c10bd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10c4:	8b 00                	mov    (%rax),%eax
  2c10c6:	89 c0                	mov    %eax,%eax
  2c10c8:	48 01 d0             	add    %rdx,%rax
  2c10cb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10d2:	8b 12                	mov    (%rdx),%edx
  2c10d4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c10d7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10de:	89 0a                	mov    %ecx,(%rdx)
  2c10e0:	eb 1a                	jmp    2c10fc <printer_vprintf+0x6a7>
  2c10e2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10e9:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10ed:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c10f1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10f8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10fc:	8b 00                	mov    (%rax),%eax
  2c10fe:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1101:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c1105:	eb 45                	jmp    2c114c <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c1107:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c110b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c110f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1116:	0f b6 00             	movzbl (%rax),%eax
  2c1119:	84 c0                	test   %al,%al
  2c111b:	74 0c                	je     2c1129 <printer_vprintf+0x6d4>
  2c111d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1124:	0f b6 00             	movzbl (%rax),%eax
  2c1127:	eb 05                	jmp    2c112e <printer_vprintf+0x6d9>
  2c1129:	b8 25 00 00 00       	mov    $0x25,%eax
  2c112e:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1131:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c1135:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c113c:	0f b6 00             	movzbl (%rax),%eax
  2c113f:	84 c0                	test   %al,%al
  2c1141:	75 08                	jne    2c114b <printer_vprintf+0x6f6>
                format--;
  2c1143:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c114a:	01 
            }
            break;
  2c114b:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c114c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c114f:	83 e0 20             	and    $0x20,%eax
  2c1152:	85 c0                	test   %eax,%eax
  2c1154:	74 1e                	je     2c1174 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c1156:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c115a:	48 83 c0 18          	add    $0x18,%rax
  2c115e:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1161:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1165:	48 89 ce             	mov    %rcx,%rsi
  2c1168:	48 89 c7             	mov    %rax,%rdi
  2c116b:	e8 63 f8 ff ff       	call   2c09d3 <fill_numbuf>
  2c1170:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1174:	48 c7 45 c0 06 18 2c 	movq   $0x2c1806,-0x40(%rbp)
  2c117b:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c117c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c117f:	83 e0 20             	and    $0x20,%eax
  2c1182:	85 c0                	test   %eax,%eax
  2c1184:	74 48                	je     2c11ce <printer_vprintf+0x779>
  2c1186:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1189:	83 e0 40             	and    $0x40,%eax
  2c118c:	85 c0                	test   %eax,%eax
  2c118e:	74 3e                	je     2c11ce <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c1190:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1193:	25 80 00 00 00       	and    $0x80,%eax
  2c1198:	85 c0                	test   %eax,%eax
  2c119a:	74 0a                	je     2c11a6 <printer_vprintf+0x751>
                prefix = "-";
  2c119c:	48 c7 45 c0 07 18 2c 	movq   $0x2c1807,-0x40(%rbp)
  2c11a3:	00 
            if (flags & FLAG_NEGATIVE) {
  2c11a4:	eb 73                	jmp    2c1219 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c11a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11a9:	83 e0 10             	and    $0x10,%eax
  2c11ac:	85 c0                	test   %eax,%eax
  2c11ae:	74 0a                	je     2c11ba <printer_vprintf+0x765>
                prefix = "+";
  2c11b0:	48 c7 45 c0 09 18 2c 	movq   $0x2c1809,-0x40(%rbp)
  2c11b7:	00 
            if (flags & FLAG_NEGATIVE) {
  2c11b8:	eb 5f                	jmp    2c1219 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c11ba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11bd:	83 e0 08             	and    $0x8,%eax
  2c11c0:	85 c0                	test   %eax,%eax
  2c11c2:	74 55                	je     2c1219 <printer_vprintf+0x7c4>
                prefix = " ";
  2c11c4:	48 c7 45 c0 0b 18 2c 	movq   $0x2c180b,-0x40(%rbp)
  2c11cb:	00 
            if (flags & FLAG_NEGATIVE) {
  2c11cc:	eb 4b                	jmp    2c1219 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c11ce:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11d1:	83 e0 20             	and    $0x20,%eax
  2c11d4:	85 c0                	test   %eax,%eax
  2c11d6:	74 42                	je     2c121a <printer_vprintf+0x7c5>
  2c11d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11db:	83 e0 01             	and    $0x1,%eax
  2c11de:	85 c0                	test   %eax,%eax
  2c11e0:	74 38                	je     2c121a <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c11e2:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c11e6:	74 06                	je     2c11ee <printer_vprintf+0x799>
  2c11e8:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c11ec:	75 2c                	jne    2c121a <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c11ee:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c11f3:	75 0c                	jne    2c1201 <printer_vprintf+0x7ac>
  2c11f5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11f8:	25 00 01 00 00       	and    $0x100,%eax
  2c11fd:	85 c0                	test   %eax,%eax
  2c11ff:	74 19                	je     2c121a <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c1201:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1205:	75 07                	jne    2c120e <printer_vprintf+0x7b9>
  2c1207:	b8 0d 18 2c 00       	mov    $0x2c180d,%eax
  2c120c:	eb 05                	jmp    2c1213 <printer_vprintf+0x7be>
  2c120e:	b8 10 18 2c 00       	mov    $0x2c1810,%eax
  2c1213:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1217:	eb 01                	jmp    2c121a <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c1219:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c121a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c121e:	78 24                	js     2c1244 <printer_vprintf+0x7ef>
  2c1220:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1223:	83 e0 20             	and    $0x20,%eax
  2c1226:	85 c0                	test   %eax,%eax
  2c1228:	75 1a                	jne    2c1244 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c122a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c122d:	48 63 d0             	movslq %eax,%rdx
  2c1230:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1234:	48 89 d6             	mov    %rdx,%rsi
  2c1237:	48 89 c7             	mov    %rax,%rdi
  2c123a:	e8 ea f5 ff ff       	call   2c0829 <strnlen>
  2c123f:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1242:	eb 0f                	jmp    2c1253 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c1244:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1248:	48 89 c7             	mov    %rax,%rdi
  2c124b:	e8 a8 f5 ff ff       	call   2c07f8 <strlen>
  2c1250:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c1253:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1256:	83 e0 20             	and    $0x20,%eax
  2c1259:	85 c0                	test   %eax,%eax
  2c125b:	74 20                	je     2c127d <printer_vprintf+0x828>
  2c125d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1261:	78 1a                	js     2c127d <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c1263:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1266:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1269:	7e 08                	jle    2c1273 <printer_vprintf+0x81e>
  2c126b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c126e:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1271:	eb 05                	jmp    2c1278 <printer_vprintf+0x823>
  2c1273:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1278:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c127b:	eb 5c                	jmp    2c12d9 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c127d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1280:	83 e0 20             	and    $0x20,%eax
  2c1283:	85 c0                	test   %eax,%eax
  2c1285:	74 4b                	je     2c12d2 <printer_vprintf+0x87d>
  2c1287:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c128a:	83 e0 02             	and    $0x2,%eax
  2c128d:	85 c0                	test   %eax,%eax
  2c128f:	74 41                	je     2c12d2 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c1291:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1294:	83 e0 04             	and    $0x4,%eax
  2c1297:	85 c0                	test   %eax,%eax
  2c1299:	75 37                	jne    2c12d2 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c129b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c129f:	48 89 c7             	mov    %rax,%rdi
  2c12a2:	e8 51 f5 ff ff       	call   2c07f8 <strlen>
  2c12a7:	89 c2                	mov    %eax,%edx
  2c12a9:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c12ac:	01 d0                	add    %edx,%eax
  2c12ae:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c12b1:	7e 1f                	jle    2c12d2 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c12b3:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c12b6:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c12b9:	89 c3                	mov    %eax,%ebx
  2c12bb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c12bf:	48 89 c7             	mov    %rax,%rdi
  2c12c2:	e8 31 f5 ff ff       	call   2c07f8 <strlen>
  2c12c7:	89 c2                	mov    %eax,%edx
  2c12c9:	89 d8                	mov    %ebx,%eax
  2c12cb:	29 d0                	sub    %edx,%eax
  2c12cd:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c12d0:	eb 07                	jmp    2c12d9 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c12d2:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c12d9:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c12dc:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c12df:	01 d0                	add    %edx,%eax
  2c12e1:	48 63 d8             	movslq %eax,%rbx
  2c12e4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c12e8:	48 89 c7             	mov    %rax,%rdi
  2c12eb:	e8 08 f5 ff ff       	call   2c07f8 <strlen>
  2c12f0:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c12f4:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c12f7:	29 d0                	sub    %edx,%eax
  2c12f9:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c12fc:	eb 25                	jmp    2c1323 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c12fe:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1305:	48 8b 08             	mov    (%rax),%rcx
  2c1308:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c130e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1315:	be 20 00 00 00       	mov    $0x20,%esi
  2c131a:	48 89 c7             	mov    %rax,%rdi
  2c131d:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c131f:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1323:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1326:	83 e0 04             	and    $0x4,%eax
  2c1329:	85 c0                	test   %eax,%eax
  2c132b:	75 36                	jne    2c1363 <printer_vprintf+0x90e>
  2c132d:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1331:	7f cb                	jg     2c12fe <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c1333:	eb 2e                	jmp    2c1363 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c1335:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c133c:	4c 8b 00             	mov    (%rax),%r8
  2c133f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1343:	0f b6 00             	movzbl (%rax),%eax
  2c1346:	0f b6 c8             	movzbl %al,%ecx
  2c1349:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c134f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1356:	89 ce                	mov    %ecx,%esi
  2c1358:	48 89 c7             	mov    %rax,%rdi
  2c135b:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c135e:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c1363:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1367:	0f b6 00             	movzbl (%rax),%eax
  2c136a:	84 c0                	test   %al,%al
  2c136c:	75 c7                	jne    2c1335 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c136e:	eb 25                	jmp    2c1395 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c1370:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1377:	48 8b 08             	mov    (%rax),%rcx
  2c137a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1380:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1387:	be 30 00 00 00       	mov    $0x30,%esi
  2c138c:	48 89 c7             	mov    %rax,%rdi
  2c138f:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1391:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c1395:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1399:	7f d5                	jg     2c1370 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c139b:	eb 32                	jmp    2c13cf <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c139d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13a4:	4c 8b 00             	mov    (%rax),%r8
  2c13a7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c13ab:	0f b6 00             	movzbl (%rax),%eax
  2c13ae:	0f b6 c8             	movzbl %al,%ecx
  2c13b1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c13b7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13be:	89 ce                	mov    %ecx,%esi
  2c13c0:	48 89 c7             	mov    %rax,%rdi
  2c13c3:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c13c6:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c13cb:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c13cf:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c13d3:	7f c8                	jg     2c139d <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c13d5:	eb 25                	jmp    2c13fc <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c13d7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13de:	48 8b 08             	mov    (%rax),%rcx
  2c13e1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c13e7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13ee:	be 20 00 00 00       	mov    $0x20,%esi
  2c13f3:	48 89 c7             	mov    %rax,%rdi
  2c13f6:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c13f8:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c13fc:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1400:	7f d5                	jg     2c13d7 <printer_vprintf+0x982>
        }
    done: ;
  2c1402:	90                   	nop
    for (; *format; ++format) {
  2c1403:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c140a:	01 
  2c140b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1412:	0f b6 00             	movzbl (%rax),%eax
  2c1415:	84 c0                	test   %al,%al
  2c1417:	0f 85 64 f6 ff ff    	jne    2c0a81 <printer_vprintf+0x2c>
    }
}
  2c141d:	90                   	nop
  2c141e:	90                   	nop
  2c141f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1423:	c9                   	leave
  2c1424:	c3                   	ret

00000000002c1425 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1425:	55                   	push   %rbp
  2c1426:	48 89 e5             	mov    %rsp,%rbp
  2c1429:	48 83 ec 20          	sub    $0x20,%rsp
  2c142d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1431:	89 f0                	mov    %esi,%eax
  2c1433:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1436:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1439:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c143d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1441:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1445:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1449:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c144e:	48 39 d0             	cmp    %rdx,%rax
  2c1451:	72 0c                	jb     2c145f <console_putc+0x3a>
        cp->cursor = console;
  2c1453:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1457:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c145e:	00 
    }
    if (c == '\n') {
  2c145f:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1463:	75 78                	jne    2c14dd <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c1465:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1469:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c146d:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1473:	48 d1 f8             	sar    %rax
  2c1476:	48 89 c1             	mov    %rax,%rcx
  2c1479:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1480:	66 66 66 
  2c1483:	48 89 c8             	mov    %rcx,%rax
  2c1486:	48 f7 ea             	imul   %rdx
  2c1489:	48 c1 fa 05          	sar    $0x5,%rdx
  2c148d:	48 89 c8             	mov    %rcx,%rax
  2c1490:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c1494:	48 29 c2             	sub    %rax,%rdx
  2c1497:	48 89 d0             	mov    %rdx,%rax
  2c149a:	48 c1 e0 02          	shl    $0x2,%rax
  2c149e:	48 01 d0             	add    %rdx,%rax
  2c14a1:	48 c1 e0 04          	shl    $0x4,%rax
  2c14a5:	48 29 c1             	sub    %rax,%rcx
  2c14a8:	48 89 ca             	mov    %rcx,%rdx
  2c14ab:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c14ae:	eb 25                	jmp    2c14d5 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c14b0:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c14b3:	83 c8 20             	or     $0x20,%eax
  2c14b6:	89 c6                	mov    %eax,%esi
  2c14b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14bc:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14c0:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c14c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c14c8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14cc:	89 f2                	mov    %esi,%edx
  2c14ce:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c14d1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c14d5:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c14d9:	75 d5                	jne    2c14b0 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c14db:	eb 24                	jmp    2c1501 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c14dd:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c14e1:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c14e4:	09 d0                	or     %edx,%eax
  2c14e6:	89 c6                	mov    %eax,%esi
  2c14e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14ec:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14f0:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c14f4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c14f8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14fc:	89 f2                	mov    %esi,%edx
  2c14fe:	66 89 10             	mov    %dx,(%rax)
}
  2c1501:	90                   	nop
  2c1502:	c9                   	leave
  2c1503:	c3                   	ret

00000000002c1504 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1504:	55                   	push   %rbp
  2c1505:	48 89 e5             	mov    %rsp,%rbp
  2c1508:	48 83 ec 30          	sub    $0x30,%rsp
  2c150c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c150f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1512:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1516:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c151a:	48 c7 45 f0 25 14 2c 	movq   $0x2c1425,-0x10(%rbp)
  2c1521:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1522:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1526:	78 09                	js     2c1531 <console_vprintf+0x2d>
  2c1528:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c152f:	7e 07                	jle    2c1538 <console_vprintf+0x34>
        cpos = 0;
  2c1531:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1538:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c153b:	48 98                	cltq
  2c153d:	48 01 c0             	add    %rax,%rax
  2c1540:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c1546:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c154a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c154e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1552:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c1555:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1559:	48 89 c7             	mov    %rax,%rdi
  2c155c:	e8 f4 f4 ff ff       	call   2c0a55 <printer_vprintf>
    return cp.cursor - console;
  2c1561:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1565:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c156b:	48 d1 f8             	sar    %rax
}
  2c156e:	c9                   	leave
  2c156f:	c3                   	ret

00000000002c1570 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1570:	55                   	push   %rbp
  2c1571:	48 89 e5             	mov    %rsp,%rbp
  2c1574:	48 83 ec 60          	sub    $0x60,%rsp
  2c1578:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c157b:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c157e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1582:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1586:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c158a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c158e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1595:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1599:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c159d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c15a1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c15a5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c15a9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c15ad:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c15b0:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c15b3:	89 c7                	mov    %eax,%edi
  2c15b5:	e8 4a ff ff ff       	call   2c1504 <console_vprintf>
  2c15ba:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c15bd:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c15c0:	c9                   	leave
  2c15c1:	c3                   	ret

00000000002c15c2 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c15c2:	55                   	push   %rbp
  2c15c3:	48 89 e5             	mov    %rsp,%rbp
  2c15c6:	48 83 ec 20          	sub    $0x20,%rsp
  2c15ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c15ce:	89 f0                	mov    %esi,%eax
  2c15d0:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c15d3:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c15d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c15da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c15de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15e2:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c15e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15ea:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c15ee:	48 39 c2             	cmp    %rax,%rdx
  2c15f1:	73 1a                	jae    2c160d <string_putc+0x4b>
        *sp->s++ = c;
  2c15f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15f7:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c15fb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c15ff:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1603:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1607:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c160b:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c160d:	90                   	nop
  2c160e:	c9                   	leave
  2c160f:	c3                   	ret

00000000002c1610 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1610:	55                   	push   %rbp
  2c1611:	48 89 e5             	mov    %rsp,%rbp
  2c1614:	48 83 ec 40          	sub    $0x40,%rsp
  2c1618:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c161c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1620:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1624:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1628:	48 c7 45 e8 c2 15 2c 	movq   $0x2c15c2,-0x18(%rbp)
  2c162f:	00 
    sp.s = s;
  2c1630:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1634:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1638:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c163d:	74 33                	je     2c1672 <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c163f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1643:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1647:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c164b:	48 01 d0             	add    %rdx,%rax
  2c164e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1652:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1656:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c165a:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c165e:	be 00 00 00 00       	mov    $0x0,%esi
  2c1663:	48 89 c7             	mov    %rax,%rdi
  2c1666:	e8 ea f3 ff ff       	call   2c0a55 <printer_vprintf>
        *sp.s = 0;
  2c166b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c166f:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1672:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1676:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c167a:	c9                   	leave
  2c167b:	c3                   	ret

00000000002c167c <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c167c:	55                   	push   %rbp
  2c167d:	48 89 e5             	mov    %rsp,%rbp
  2c1680:	48 83 ec 70          	sub    $0x70,%rsp
  2c1684:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1688:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c168c:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1690:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1694:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1698:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c169c:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c16a3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c16a7:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c16ab:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c16af:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c16b3:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c16b7:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c16bb:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c16bf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c16c3:	48 89 c7             	mov    %rax,%rdi
  2c16c6:	e8 45 ff ff ff       	call   2c1610 <vsnprintf>
  2c16cb:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c16ce:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c16d1:	c9                   	leave
  2c16d2:	c3                   	ret

00000000002c16d3 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c16d3:	55                   	push   %rbp
  2c16d4:	48 89 e5             	mov    %rsp,%rbp
  2c16d7:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c16db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c16e2:	eb 13                	jmp    2c16f7 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c16e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c16e7:	48 98                	cltq
  2c16e9:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c16f0:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c16f3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c16f7:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c16fe:	7e e4                	jle    2c16e4 <console_clear+0x11>
    }
    cursorpos = 0;
  2c1700:	c7 05 f2 78 df ff 00 	movl   $0x0,-0x20870e(%rip)        # b8ffc <cursorpos>
  2c1707:	00 00 00 
}
  2c170a:	90                   	nop
  2c170b:	c9                   	leave
  2c170c:	c3                   	ret
