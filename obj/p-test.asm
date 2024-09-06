
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 57                	push   %r15
  100006:	41 56                	push   %r14
  100008:	41 55                	push   %r13
  10000a:	41 54                	push   %r12
  10000c:	53                   	push   %rbx
  10000d:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100011:	cd 31                	int    $0x31
  100013:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  100015:	e8 00 09 00 00       	call   10091a <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10001a:	b8 2f 30 10 00       	mov    $0x10302f,%eax
  10001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100025:	48 89 05 e4 1f 00 00 	mov    %rax,0x1fe4(%rip)        # 102010 <heap_top>
  10002c:	48 89 05 d5 1f 00 00 	mov    %rax,0x1fd5(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100033:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100036:	48 83 e8 01          	sub    $0x1,%rax
  10003a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100040:	48 89 05 b9 1f 00 00 	mov    %rax,0x1fb9(%rip)        # 102000 <stack_bottom>
  100047:	bb 01 00 00 00       	mov    $0x1,%ebx
  10004c:	41 89 df             	mov    %ebx,%r15d
void process_main(void) {
  10004f:	49 89 de             	mov    %rbx,%r14
  100052:	41 89 dd             	mov    %ebx,%r13d
  100055:	41 bc 01 00 00 00    	mov    $0x1,%r12d

    /* Single elements on heap of varying sizes */
    for(int i = 1; i < 64; ++i) {
        for(int j = 1; j < 64; ++j) {
            void *ptr = calloc(i,j);
  10005b:	4c 89 e6             	mov    %r12,%rsi
  10005e:	48 89 df             	mov    %rbx,%rdi
  100061:	e8 47 03 00 00       	call   1003ad <calloc>
            assert(ptr != NULL);
  100066:	48 85 c0             	test   %rax,%rax
  100069:	74 55                	je     1000c0 <process_main+0xc0>

            for(int k = 0; k < i*j; ++k) {
  10006b:	48 89 c2             	mov    %rax,%rdx
  10006e:	4a 8d 0c 30          	lea    (%rax,%r14,1),%rcx
  100072:	45 85 ed             	test   %r13d,%r13d
  100075:	7e 0e                	jle    100085 <process_main+0x85>
                assert(((char *)ptr)[k] == 0);
  100077:	80 3a 00             	cmpb   $0x0,(%rdx)
  10007a:	75 58                	jne    1000d4 <process_main+0xd4>
            for(int k = 0; k < i*j; ++k) {
  10007c:	48 83 c2 01          	add    $0x1,%rdx
  100080:	48 39 ca             	cmp    %rcx,%rdx
  100083:	75 f2                	jne    100077 <process_main+0x77>
            }

            free(ptr);
  100085:	48 89 c7             	mov    %rax,%rdi
  100088:	e8 f1 01 00 00       	call   10027e <free>
        for(int j = 1; j < 64; ++j) {
  10008d:	49 83 c4 01          	add    $0x1,%r12
  100091:	45 01 fd             	add    %r15d,%r13d
  100094:	49 01 de             	add    %rbx,%r14
  100097:	49 83 fc 40          	cmp    $0x40,%r12
  10009b:	75 be                	jne    10005b <process_main+0x5b>
        }
	defrag();
  10009d:	b8 00 00 00 00       	mov    $0x0,%eax
  1000a2:	e8 ef 03 00 00       	call   100496 <defrag>
    for(int i = 1; i < 64; ++i) {
  1000a7:	48 83 c3 01          	add    $0x1,%rbx
  1000ab:	48 83 fb 40          	cmp    $0x40,%rbx
  1000af:	75 9b                	jne    10004c <process_main+0x4c>
    }

    TEST_PASS();
  1000b1:	bf b2 16 10 00       	mov    $0x1016b2,%edi
  1000b6:	b8 00 00 00 00       	mov    $0x0,%eax
  1000bb:	e8 b8 00 00 00       	call   100178 <kernel_panic>
            assert(ptr != NULL);
  1000c0:	ba 80 16 10 00       	mov    $0x101680,%edx
  1000c5:	be 19 00 00 00       	mov    $0x19,%esi
  1000ca:	bf 8c 16 10 00       	mov    $0x10168c,%edi
  1000cf:	e8 72 01 00 00       	call   100246 <assert_fail>
                assert(((char *)ptr)[k] == 0);
  1000d4:	ba 9c 16 10 00       	mov    $0x10169c,%edx
  1000d9:	be 1c 00 00 00       	mov    $0x1c,%esi
  1000de:	bf 8c 16 10 00       	mov    $0x10168c,%edi
  1000e3:	e8 5e 01 00 00       	call   100246 <assert_fail>

00000000001000e8 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1000e8:	55                   	push   %rbp
  1000e9:	48 89 e5             	mov    %rsp,%rbp
  1000ec:	48 83 ec 50          	sub    $0x50,%rsp
  1000f0:	49 89 f2             	mov    %rsi,%r10
  1000f3:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1000f7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000fb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1000ff:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100103:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100108:	85 ff                	test   %edi,%edi
  10010a:	78 2e                	js     10013a <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10010c:	48 63 ff             	movslq %edi,%rdi
  10010f:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100116:	cc cc cc 
  100119:	48 89 f8             	mov    %rdi,%rax
  10011c:	48 f7 e2             	mul    %rdx
  10011f:	48 89 d0             	mov    %rdx,%rax
  100122:	48 c1 e8 02          	shr    $0x2,%rax
  100126:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  10012a:	48 01 c2             	add    %rax,%rdx
  10012d:	48 29 d7             	sub    %rdx,%rdi
  100130:	0f b6 b7 05 17 10 00 	movzbl 0x101705(%rdi),%esi
  100137:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  10013a:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100141:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100145:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100149:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10014d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100151:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100155:	4c 89 d2             	mov    %r10,%rdx
  100158:	8b 3d 9e 8e fb ff    	mov    -0x47162(%rip),%edi        # b8ffc <cursorpos>
  10015e:	e8 09 13 00 00       	call   10146c <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100163:	3d 30 07 00 00       	cmp    $0x730,%eax
  100168:	ba 00 00 00 00       	mov    $0x0,%edx
  10016d:	0f 4d c2             	cmovge %edx,%eax
  100170:	89 05 86 8e fb ff    	mov    %eax,-0x4717a(%rip)        # b8ffc <cursorpos>
    }
}
  100176:	c9                   	leave
  100177:	c3                   	ret

0000000000100178 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100178:	55                   	push   %rbp
  100179:	48 89 e5             	mov    %rsp,%rbp
  10017c:	53                   	push   %rbx
  10017d:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100184:	48 89 fb             	mov    %rdi,%rbx
  100187:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10018b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10018f:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100193:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100197:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10019b:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001a2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001a6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1001aa:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1001ae:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1001b2:	ba 07 00 00 00       	mov    $0x7,%edx
  1001b7:	be cd 16 10 00       	mov    $0x1016cd,%esi
  1001bc:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1001c3:	e8 5b 04 00 00       	call   100623 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1001c8:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1001cc:	48 89 da             	mov    %rbx,%rdx
  1001cf:	be 99 00 00 00       	mov    $0x99,%esi
  1001d4:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1001db:	e8 98 13 00 00       	call   101578 <vsnprintf>
  1001e0:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1001e3:	85 d2                	test   %edx,%edx
  1001e5:	7e 0f                	jle    1001f6 <kernel_panic+0x7e>
  1001e7:	83 c0 06             	add    $0x6,%eax
  1001ea:	48 98                	cltq
  1001ec:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1001f3:	0a 
  1001f4:	75 2a                	jne    100220 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1001f6:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1001fd:	48 89 d9             	mov    %rbx,%rcx
  100200:	ba d7 16 10 00       	mov    $0x1016d7,%edx
  100205:	be 00 c0 00 00       	mov    $0xc000,%esi
  10020a:	bf 30 07 00 00       	mov    $0x730,%edi
  10020f:	b8 00 00 00 00       	mov    $0x0,%eax
  100214:	e8 bf 12 00 00       	call   1014d8 <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100219:	48 89 df             	mov    %rbx,%rdi
  10021c:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  10021e:	eb fe                	jmp    10021e <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100220:	48 63 c2             	movslq %edx,%rax
  100223:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100229:	0f 94 c2             	sete   %dl
  10022c:	0f b6 d2             	movzbl %dl,%edx
  10022f:	48 29 d0             	sub    %rdx,%rax
  100232:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100239:	ff 
  10023a:	be d5 16 10 00       	mov    $0x1016d5,%esi
  10023f:	e8 8c 05 00 00       	call   1007d0 <strcpy>
  100244:	eb b0                	jmp    1001f6 <kernel_panic+0x7e>

0000000000100246 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100246:	55                   	push   %rbp
  100247:	48 89 e5             	mov    %rsp,%rbp
  10024a:	48 89 f9             	mov    %rdi,%rcx
  10024d:	41 89 f0             	mov    %esi,%r8d
  100250:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100253:	ba e0 16 10 00       	mov    $0x1016e0,%edx
  100258:	be 00 c0 00 00       	mov    $0xc000,%esi
  10025d:	bf 30 07 00 00       	mov    $0x730,%edi
  100262:	b8 00 00 00 00       	mov    $0x0,%eax
  100267:	e8 6c 12 00 00       	call   1014d8 <console_printf>
    asm volatile ("int %0" : /* no result */
  10026c:	bf 00 00 00 00       	mov    $0x0,%edi
  100271:	cd 30                	int    $0x30
 loop: goto loop;
  100273:	eb fe                	jmp    100273 <assert_fail+0x2d>

0000000000100275 <align>:
// this creates the first node of the linked list
node *head = NULL;

// Function to align sizes to the nearest multiple of 8
size_t align(size_t size) {
    return (size + ALIGNMENT - 1) & ~(ALIGNMENT - 1);
  100275:	48 8d 47 07          	lea    0x7(%rdi),%rax
  100279:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  10027d:	c3                   	ret

000000000010027e <free>:

// finished
void free(void *ptr) {
    // if the pointer is null already return NULL
    if (ptr == NULL)
  10027e:	48 85 ff             	test   %rdi,%rdi
  100281:	74 1b                	je     10029e <free+0x20>
    {
        // will do nothing and just reeturn
        return;
    }
    //creates a new node to loop through thel inked list
    node * current = head;
  100283:	48 8b 05 8e 1d 00 00 	mov    0x1d8e(%rip),%rax        # 102018 <head>
    // while loop to loop through the lsit
    while (current != NULL)
  10028a:	48 85 c0             	test   %rax,%rax
  10028d:	74 0f                	je     10029e <free+0x20>
    {   
        // checks if that current pt_data is equal to requested pointer
        // if it is then
        if (current->pt_data == ptr)
  10028f:	48 39 78 20          	cmp    %rdi,0x20(%rax)
  100293:	74 0a                	je     10029f <free+0x21>
            // sets the current to free -- this means sets to 1
            // current = 1 so that node is free
            current->free = 1;
            break;
        }
        current = current->next;
  100295:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (current != NULL)
  100299:	48 85 c0             	test   %rax,%rax
  10029c:	75 f1                	jne    10028f <free+0x11>
    }

    // this will break out and just return
    return;

}
  10029e:	c3                   	ret
            current->free = 1;
  10029f:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
            break;
  1002a6:	c3                   	ret

00000000001002a7 <malloc>:


// finished
void *malloc(uint64_t numbytes) {
    // if the number of bytes is 0 then return NULL
    if (numbytes == 0) {
  1002a7:	48 85 ff             	test   %rdi,%rdi
  1002aa:	0f 84 eb 00 00 00    	je     10039b <malloc+0xf4>
    return (size + ALIGNMENT - 1) & ~(ALIGNMENT - 1);
  1002b0:	48 8d 57 07          	lea    0x7(%rdi),%rdx
  1002b4:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx

    // this will align number of bytes
    numbytes = align(numbytes);

    // this is the total size
    uint64_t total_size = numbytes + NODE_SIZE;
  1002b8:	48 8d 7a 28          	lea    0x28(%rdx),%rdi

    // this checks if numbytes is greater than the max amount of energy
    if (numbytes > (0xffffffffffffffff - (uint64_t) NODE_SIZE))
  1002bc:	48 83 fa d7          	cmp    $0xffffffffffffffd7,%rdx
  1002c0:	0f 87 db 00 00 00    	ja     1003a1 <malloc+0xfa>
        return NULL;
    }

    // this will first create a node equal to head
    // allows for while loop
    node *current = head;
  1002c6:	48 8b 05 4b 1d 00 00 	mov    0x1d4b(%rip),%rax        # 102018 <head>

    // this will store the block found
    node *found = NULL;

    // searches for a free or suitable block
    while (current != NULL) {
  1002cd:	48 85 c0             	test   %rax,%rax
  1002d0:	75 62                	jne    100334 <malloc+0x8d>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1002d2:	cd 3a                	int    $0x3a
  1002d4:	48 89 05 45 1d 00 00 	mov    %rax,0x1d45(%rip)        # 102020 <result.0>

    // heap expansion
    // create a node for expanding the heap
    node *expanded = sbrk(total_size);
    // if sbrk did not work then return NULL
    if (expanded == (void *)-1) {
  1002db:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1002df:	0f 84 c2 00 00 00    	je     1003a7 <malloc+0x100>
        return NULL;
    }

    // if expanded node assigns the size to numbytes
    // expanded size = num bytes
    expanded->size = numbytes;
  1002e5:	89 10                	mov    %edx,(%rax)
    // makes the node not free
    expanded->free = 0;
  1002e7:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    // expanded pt_data is equal to size of expanded + metadata
    expanded->pt_data = (char*)expanded + NODE_SIZE;
  1002ee:	48 8d 50 28          	lea    0x28(%rax),%rdx
  1002f2:	48 89 50 20          	mov    %rdx,0x20(%rax)
    // sets to end NULL since last node
    expanded->next = NULL;
  1002f6:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  1002fd:	00 
    // if no list has been created then make first
    // make first node in linked list
    if (head == NULL)
  1002fe:	48 8b 15 13 1d 00 00 	mov    0x1d13(%rip),%rdx        # 102018 <head>
  100305:	48 89 50 08          	mov    %rdx,0x8(%rax)
    {
        expanded->prev = head;
    }

    // if no list has been created then make first
    if (head == NULL) {
  100309:	48 85 d2             	test   %rdx,%rdx
  10030c:	0f 84 80 00 00 00    	je     100392 <malloc+0xeb>
        head = expanded;
    } else {
        // if list exists then have to find the last one
        node *last = head;
        // this while loop finds the last one
        while (last->next != NULL) {
  100312:	48 89 d1             	mov    %rdx,%rcx
  100315:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  100319:	48 85 d2             	test   %rdx,%rdx
  10031c:	75 f4                	jne    100312 <malloc+0x6b>
            last = last->next;
        }
        last->next = expanded;
  10031e:	48 89 41 10          	mov    %rax,0x10(%rcx)
        expanded->prev = last;
  100322:	48 89 48 08          	mov    %rcx,0x8(%rax)
    }

    // returns the node point data
    return expanded->pt_data;
  100326:	48 8b 40 20          	mov    0x20(%rax),%rax
  10032a:	c3                   	ret
        current = current->next;
  10032b:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (current != NULL) {
  10032f:	48 85 c0             	test   %rax,%rax
  100332:	74 9e                	je     1002d2 <malloc+0x2b>
        if (current->free == 1 && (uint64_t) current->size >= total_size) {
  100334:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  100338:	75 f1                	jne    10032b <malloc+0x84>
  10033a:	48 63 08             	movslq (%rax),%rcx
  10033d:	48 39 f9             	cmp    %rdi,%rcx
  100340:	72 e9                	jb     10032b <malloc+0x84>
        if (found->size - total_size >= NODE_SIZE) {
  100342:	8b 30                	mov    (%rax),%esi
  100344:	48 63 ce             	movslq %esi,%rcx
  100347:	48 29 f9             	sub    %rdi,%rcx
  10034a:	48 83 f9 27          	cmp    $0x27,%rcx
  10034e:	76 36                	jbe    100386 <malloc+0xdf>
            node *new_node = (node *)((char *)found + total_size);
  100350:	48 8d 0c 38          	lea    (%rax,%rdi,1),%rcx
            new_node->size = found->size - total_size;
  100354:	29 fe                	sub    %edi,%esi
  100356:	89 31                	mov    %esi,(%rcx)
            new_node->prev = found;
  100358:	48 89 41 08          	mov    %rax,0x8(%rcx)
            new_node->free = 1;
  10035c:	c7 41 18 01 00 00 00 	movl   $0x1,0x18(%rcx)
            new_node->next = found->next;
  100363:	48 8b 70 10          	mov    0x10(%rax),%rsi
  100367:	48 89 71 10          	mov    %rsi,0x10(%rcx)
            new_node->pt_data = (char *)new_node + NODE_SIZE;
  10036b:	48 8d 71 28          	lea    0x28(%rcx),%rsi
  10036f:	48 89 71 20          	mov    %rsi,0x20(%rcx)
            if (found->next != NULL) {
  100373:	48 8b 70 10          	mov    0x10(%rax),%rsi
  100377:	48 85 f6             	test   %rsi,%rsi
  10037a:	74 04                	je     100380 <malloc+0xd9>
                found->next->prev = new_node;
  10037c:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
            found->next = new_node;
  100380:	48 89 48 10          	mov    %rcx,0x10(%rax)
            found->size = numbytes;
  100384:	89 10                	mov    %edx,(%rax)
        found->free = 0;
  100386:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        return found->pt_data;
  10038d:	48 8b 40 20          	mov    0x20(%rax),%rax
  100391:	c3                   	ret
        head = expanded;
  100392:	48 89 05 7f 1c 00 00 	mov    %rax,0x1c7f(%rip)        # 102018 <head>
  100399:	eb 8b                	jmp    100326 <malloc+0x7f>
        return NULL;
  10039b:	b8 00 00 00 00       	mov    $0x0,%eax
  1003a0:	c3                   	ret
        return NULL;
  1003a1:	b8 00 00 00 00       	mov    $0x0,%eax
  1003a6:	c3                   	ret
        return NULL;
  1003a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1003ac:	c3                   	ret

00000000001003ad <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  1003ad:	55                   	push   %rbp
  1003ae:	48 89 e5             	mov    %rsp,%rbp
  1003b1:	41 54                	push   %r12
  1003b3:	53                   	push   %rbx
    // edge case if num or sz is equal to 0, then calloc returns NULL
    //sz or num == 0
    // size or num is 0
    if (num == 0 || sz == 0)
  1003b4:	48 85 ff             	test   %rdi,%rdi
  1003b7:	74 4e                	je     100407 <calloc+0x5a>
  1003b9:	48 85 f6             	test   %rsi,%rsi
  1003bc:	74 49                	je     100407 <calloc+0x5a>
    // creates pointer
    void* pointer = NULL;
    // this checks if the number of bytes allocated is greater than total space available
    // checks max - node size divided by size
    // the second parts tells how many nums you can possibly have
    if (num > (0xffffffffffffffff - NODE_SIZE)/sz)
  1003be:	48 c7 c0 d7 ff ff ff 	mov    $0xffffffffffffffd7,%rax
  1003c5:	ba 00 00 00 00       	mov    $0x0,%edx
  1003ca:	48 f7 f6             	div    %rsi
    {
        return NULL;
  1003cd:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if (num > (0xffffffffffffffff - NODE_SIZE)/sz)
  1003d3:	48 39 f8             	cmp    %rdi,%rax
  1003d6:	72 27                	jb     1003ff <calloc+0x52>
    uint64_t total = num * sz;
  1003d8:	48 89 fb             	mov    %rdi,%rbx
  1003db:	48 0f af de          	imul   %rsi,%rbx
    }
    else
    {
        // malloc a certain total
        pointer = malloc(total);
  1003df:	48 89 df             	mov    %rbx,%rdi
  1003e2:	e8 c0 fe ff ff       	call   1002a7 <malloc>
  1003e7:	49 89 c4             	mov    %rax,%r12
        //this if the pointer is empty
        // this goes in if the pointer is NULL
        if (pointer != NULL){
  1003ea:	48 85 c0             	test   %rax,%rax
  1003ed:	74 10                	je     1003ff <calloc+0x52>
            // this sets pointer to be 0 for total size if null pointer
            memset(pointer, 0, total);
  1003ef:	48 89 da             	mov    %rbx,%rdx
  1003f2:	be 00 00 00 00       	mov    $0x0,%esi
  1003f7:	48 89 c7             	mov    %rax,%rdi
  1003fa:	e8 22 03 00 00       	call   100721 <memset>
        }
    }
    
    return pointer;
}
  1003ff:	4c 89 e0             	mov    %r12,%rax
  100402:	5b                   	pop    %rbx
  100403:	41 5c                	pop    %r12
  100405:	5d                   	pop    %rbp
  100406:	c3                   	ret
        return NULL;
  100407:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  10040d:	eb f0                	jmp    1003ff <calloc+0x52>

000000000010040f <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  10040f:	55                   	push   %rbp
  100410:	48 89 e5             	mov    %rsp,%rbp
  100413:	41 54                	push   %r12
  100415:	53                   	push   %rbx
  100416:	48 89 fb             	mov    %rdi,%rbx
    // this checks if size is 0
    // if size is 0 then returns null
    if (sz == 0)
  100419:	48 85 f6             	test   %rsi,%rsi
  10041c:	75 25                	jne    100443 <realloc+0x34>
    {
        // if ptr not null then free ptr
        if (ptr != NULL)
  10041e:	48 85 ff             	test   %rdi,%rdi
  100421:	75 13                	jne    100436 <realloc+0x27>
    // this checks if the ptr is null
    // if pointer is NULL then call malloc
    if (ptr == NULL)
    {
        // if it is then just returns the malloc
        return malloc(sz);
  100423:	48 89 f7             	mov    %rsi,%rdi
  100426:	e8 7c fe ff ff       	call   1002a7 <malloc>
  10042b:	49 89 c4             	mov    %rax,%r12
    

    // returns the new location
    return new_node;

}
  10042e:	4c 89 e0             	mov    %r12,%rax
  100431:	5b                   	pop    %rbx
  100432:	41 5c                	pop    %r12
  100434:	5d                   	pop    %rbp
  100435:	c3                   	ret
            free(ptr);
  100436:	e8 43 fe ff ff       	call   10027e <free>
            return NULL;
  10043b:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100441:	eb eb                	jmp    10042e <realloc+0x1f>
    if (ptr == NULL)
  100443:	48 85 ff             	test   %rdi,%rdi
  100446:	74 db                	je     100423 <realloc+0x14>
    if (sz < (uint64_t) header->size)
  100448:	48 63 87 c0 f9 ff ff 	movslq -0x640(%rdi),%rax
        return ptr;
  10044f:	49 89 fc             	mov    %rdi,%r12
    if (sz < (uint64_t) header->size)
  100452:	48 39 c6             	cmp    %rax,%rsi
  100455:	72 d7                	jb     10042e <realloc+0x1f>
        if (sz > (0xffffffffffffffff - (uint64_t) NODE_SIZE))
  100457:	48 83 fe d7          	cmp    $0xffffffffffffffd7,%rsi
  10045b:	77 31                	ja     10048e <realloc+0x7f>
  10045d:	48 39 f0             	cmp    %rsi,%rax
  100460:	74 2c                	je     10048e <realloc+0x7f>
        new_node = malloc(sz);
  100462:	48 89 f7             	mov    %rsi,%rdi
  100465:	e8 3d fe ff ff       	call   1002a7 <malloc>
  10046a:	49 89 c4             	mov    %rax,%r12
        if (new_node == NULL)
  10046d:	48 85 c0             	test   %rax,%rax
  100470:	74 bc                	je     10042e <realloc+0x1f>
        memcpy(new_node, ptr, header->size);
  100472:	48 63 93 c0 f9 ff ff 	movslq -0x640(%rbx),%rdx
  100479:	48 89 de             	mov    %rbx,%rsi
  10047c:	48 89 c7             	mov    %rax,%rdi
  10047f:	e8 9f 01 00 00       	call   100623 <memcpy>
        free(ptr);
  100484:	48 89 df             	mov    %rbx,%rdi
  100487:	e8 f2 fd ff ff       	call   10027e <free>
  10048c:	eb a0                	jmp    10042e <realloc+0x1f>
            return NULL;
  10048e:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100494:	eb 98                	jmp    10042e <realloc+0x1f>

0000000000100496 <defrag>:

// finished
void defrag() {
    // creates a node to loop through the linked list
    node *current = head;
  100496:	48 8b 05 7b 1b 00 00 	mov    0x1b7b(%rip),%rax        # 102018 <head>
    
    while (current != NULL && current->next != NULL) {
  10049d:	48 85 c0             	test   %rax,%rax
  1004a0:	75 08                	jne    1004aa <defrag+0x14>
  1004a2:	c3                   	ret
            // this is needed for the doubly linked list
            // that means something after next
            if (next->next != NULL) {
                // sets the previous one to it before
                // sets the next next previous to be the current one
                next->next->prev = current;
  1004a3:	48 89 41 08          	mov    %rax,0x8(%rcx)
    while (current != NULL && current->next != NULL) {
  1004a7:	48 89 d0             	mov    %rdx,%rax
  1004aa:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1004ae:	48 85 d2             	test   %rdx,%rdx
  1004b1:	74 22                	je     1004d5 <defrag+0x3f>
        if (current->free == 1 && current->next->free == 1) {
  1004b3:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  1004b7:	75 ee                	jne    1004a7 <defrag+0x11>
  1004b9:	83 7a 18 01          	cmpl   $0x1,0x18(%rdx)
  1004bd:	75 e8                	jne    1004a7 <defrag+0x11>
            current->size += next->size;  
  1004bf:	8b 0a                	mov    (%rdx),%ecx
  1004c1:	01 08                	add    %ecx,(%rax)
            current->next = next->next;
  1004c3:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  1004c7:	48 89 48 10          	mov    %rcx,0x10(%rax)
            if (next->next != NULL) {
  1004cb:	48 89 c2             	mov    %rax,%rdx
  1004ce:	48 85 c9             	test   %rcx,%rcx
  1004d1:	75 d0                	jne    1004a3 <defrag+0xd>
  1004d3:	eb d2                	jmp    1004a7 <defrag+0x11>
        } else {
            //that means just move on
            current = current->next;
        }
    }
}
  1004d5:	c3                   	ret

00000000001004d6 <heap_info>:

int heap_info(heap_info_struct *info) {
  1004d6:	55                   	push   %rbp
  1004d7:	48 89 e5             	mov    %rsp,%rbp
  1004da:	41 55                	push   %r13
  1004dc:	41 54                	push   %r12
  1004de:	53                   	push   %rbx
  1004df:	48 83 ec 08          	sub    $0x8,%rsp
  1004e3:	48 89 fb             	mov    %rdi,%rbx

    long * size_array = NULL;
    // allocates for array
    void **ptr_array = NULL;
    // Traverse the list to gather data
    node *current = head;
  1004e6:	48 8b 05 2b 1b 00 00 	mov    0x1b2b(%rip),%rax        # 102018 <head>

    while (current != NULL) {
  1004ed:	48 85 c0             	test   %rax,%rax
  1004f0:	0f 84 f9 00 00 00    	je     1005ef <heap_info+0x119>
    int largest_free_chunk = 0;
  1004f6:	b9 00 00 00 00       	mov    $0x0,%ecx
    int total_free_space = 0;
  1004fb:	be 00 00 00 00       	mov    $0x0,%esi
    int num_allocs = 0;
  100500:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100506:	eb 0d                	jmp    100515 <heap_info+0x3f>
                largest_free_chunk = current->size;
            }
        } else if (current->free == 0) {
            // this counts for how much allocations has been made
            // or non free nodes
            num_allocs++;
  100508:	41 83 c4 01          	add    $0x1,%r12d
        }
        current = current->next;
  10050c:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (current != NULL) {
  100510:	48 85 c0             	test   %rax,%rax
  100513:	74 11                	je     100526 <heap_info+0x50>
        if (current->free) {
  100515:	83 78 18 00          	cmpl   $0x0,0x18(%rax)
  100519:	74 ed                	je     100508 <heap_info+0x32>
            total_free_space += current->size;
  10051b:	8b 10                	mov    (%rax),%edx
  10051d:	01 d6                	add    %edx,%esi
            if (current->size > largest_free_chunk) {
  10051f:	39 d1                	cmp    %edx,%ecx
  100521:	0f 4c ca             	cmovl  %edx,%ecx
  100524:	eb e6                	jmp    10050c <heap_info+0x36>
    }

    // This will set the fields for the heap-info struct
    // this will set the fields for heap-info struct
    
    info->free_space = total_free_space;
  100526:	89 73 18             	mov    %esi,0x18(%rbx)
    info->largest_free_chunk = largest_free_chunk;
  100529:	89 4b 1c             	mov    %ecx,0x1c(%rbx)

    // if there are no allocations then arrays are null
    if (num_allocs == 0)
  10052c:	45 85 e4             	test   %r12d,%r12d
  10052f:	0f 84 c8 00 00 00    	je     1005fd <heap_info+0x127>
    //info->num_allocs = num_allocs;

    // after this while loop, you have largest free chunk, free space and num_allocs

    // allocates space for the array
    info->size_array = (long *)malloc((uint64_t) num_allocs * sizeof(long *));
  100535:	4d 63 ec             	movslq %r12d,%r13
  100538:	49 c1 e5 03          	shl    $0x3,%r13
  10053c:	4c 89 ef             	mov    %r13,%rdi
  10053f:	e8 63 fd ff ff       	call   1002a7 <malloc>
  100544:	48 89 43 08          	mov    %rax,0x8(%rbx)
    // allocates for array
    info->ptr_array = malloc(num_allocs * sizeof(uintptr_t));
  100548:	4c 89 ef             	mov    %r13,%rdi
  10054b:	e8 57 fd ff ff       	call   1002a7 <malloc>
  100550:	48 89 43 10          	mov    %rax,0x10(%rbx)

    // if cannot malloc space correctly
    // returns -1
    if (info->ptr_array == NULL || info->size_array == NULL)
  100554:	48 85 c0             	test   %rax,%rax
  100557:	74 7a                	je     1005d3 <heap_info+0xfd>
  100559:	48 83 7b 08 00       	cmpq   $0x0,0x8(%rbx)
  10055e:	74 7a                	je     1005da <heap_info+0x104>
        current = current->next;
    }

    // This will sort the arrays based on descending order
    // this is for buble sort
    for (int i = 0; i < num_allocs - 1; i++) {
  100560:	41 83 fc 01          	cmp    $0x1,%r12d
  100564:	7e 7b                	jle    1005e1 <heap_info+0x10b>
  100566:	45 89 e2             	mov    %r12d,%r10d
  100569:	eb 53                	jmp    1005be <heap_info+0xe8>
        for (int j = 0; j < num_allocs - i - 1; j++) {
  10056b:	4c 39 c0             	cmp    %r8,%rax
  10056e:	74 44                	je     1005b4 <heap_info+0xde>
            // this compares the size array between current and the next one
            if (info->size_array[j] < info->size_array[j + 1]) {
  100570:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  100574:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
  100578:	48 8b 0e             	mov    (%rsi),%rcx
  10057b:	48 89 c7             	mov    %rax,%rdi
  10057e:	48 83 c0 08          	add    $0x8,%rax
  100582:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
  100586:	48 39 d1             	cmp    %rdx,%rcx
  100589:	7d e0                	jge    10056b <heap_info+0x95>

                long temp_size = info->size_array[j];
                void *temp_ptr = info->ptr_array[j];
  10058b:	4c 8b 4b 10          	mov    0x10(%rbx),%r9
  10058f:	4d 8b 0c 39          	mov    (%r9,%rdi,1),%r9
                // this will flip the next and other one next to each other
                info->size_array[j] = info->size_array[j + 1];
  100593:	48 89 16             	mov    %rdx,(%rsi)
                info->ptr_array[j] = info->ptr_array[j + 1];
  100596:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  10059a:	48 8b 34 02          	mov    (%rdx,%rax,1),%rsi
  10059e:	48 89 34 3a          	mov    %rsi,(%rdx,%rdi,1)
                // this will also change ptr_array
                info->size_array[j + 1] = temp_size;
  1005a2:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  1005a6:	48 89 0c 02          	mov    %rcx,(%rdx,%rax,1)
                info->ptr_array[j + 1] = temp_ptr;
  1005aa:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  1005ae:	4c 89 0c 02          	mov    %r9,(%rdx,%rax,1)
  1005b2:	eb b7                	jmp    10056b <heap_info+0x95>
    for (int i = 0; i < num_allocs - 1; i++) {
  1005b4:	41 83 ea 01          	sub    $0x1,%r10d
  1005b8:	41 83 fa 01          	cmp    $0x1,%r10d
  1005bc:	74 2a                	je     1005e8 <heap_info+0x112>
        for (int j = 0; j < num_allocs - i - 1; j++) {
  1005be:	41 83 fa 01          	cmp    $0x1,%r10d
  1005c2:	7e 59                	jle    10061d <heap_info+0x147>
  1005c4:	45 8d 42 ff          	lea    -0x1(%r10),%r8d
  1005c8:	49 c1 e0 03          	shl    $0x3,%r8
  1005cc:	b8 00 00 00 00       	mov    $0x0,%eax
  1005d1:	eb 9d                	jmp    100570 <heap_info+0x9a>
        return -1;
  1005d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005d8:	eb 38                	jmp    100612 <heap_info+0x13c>
  1005da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005df:	eb 31                	jmp    100612 <heap_info+0x13c>
            }
        }
    }

    // returns a 0 if successful
    return 0; 
  1005e1:	b8 00 00 00 00       	mov    $0x0,%eax
  1005e6:	eb 2a                	jmp    100612 <heap_info+0x13c>
  1005e8:	b8 00 00 00 00       	mov    $0x0,%eax
  1005ed:	eb 23                	jmp    100612 <heap_info+0x13c>
    info->free_space = total_free_space;
  1005ef:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = largest_free_chunk;
  1005f6:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
        info->size_array = NULL;
  1005fd:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  100604:	00 
        info->ptr_array = NULL;
  100605:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  10060c:	00 
        return 0;
  10060d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100612:	48 83 c4 08          	add    $0x8,%rsp
  100616:	5b                   	pop    %rbx
  100617:	41 5c                	pop    %r12
  100619:	41 5d                	pop    %r13
  10061b:	5d                   	pop    %rbp
  10061c:	c3                   	ret
    for (int i = 0; i < num_allocs - 1; i++) {
  10061d:	41 83 ea 01          	sub    $0x1,%r10d
  100621:	eb 9b                	jmp    1005be <heap_info+0xe8>

0000000000100623 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100623:	55                   	push   %rbp
  100624:	48 89 e5             	mov    %rsp,%rbp
  100627:	48 83 ec 28          	sub    $0x28,%rsp
  10062b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10062f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100633:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100637:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10063b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10063f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100643:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100647:	eb 1c                	jmp    100665 <memcpy+0x42>
        *d = *s;
  100649:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10064d:	0f b6 10             	movzbl (%rax),%edx
  100650:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100654:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100656:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10065b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100660:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100665:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10066a:	75 dd                	jne    100649 <memcpy+0x26>
    }
    return dst;
  10066c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100670:	c9                   	leave
  100671:	c3                   	ret

0000000000100672 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100672:	55                   	push   %rbp
  100673:	48 89 e5             	mov    %rsp,%rbp
  100676:	48 83 ec 28          	sub    $0x28,%rsp
  10067a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10067e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100682:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100686:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10068a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10068e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100692:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100696:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10069a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10069e:	73 6a                	jae    10070a <memmove+0x98>
  1006a0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1006a4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006a8:	48 01 d0             	add    %rdx,%rax
  1006ab:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1006af:	73 59                	jae    10070a <memmove+0x98>
        s += n, d += n;
  1006b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006b5:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1006b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006bd:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1006c1:	eb 17                	jmp    1006da <memmove+0x68>
            *--d = *--s;
  1006c3:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1006c8:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1006cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006d1:	0f b6 10             	movzbl (%rax),%edx
  1006d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006d8:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1006da:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006de:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1006e2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1006e6:	48 85 c0             	test   %rax,%rax
  1006e9:	75 d8                	jne    1006c3 <memmove+0x51>
    if (s < d && s + n > d) {
  1006eb:	eb 2e                	jmp    10071b <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1006ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1006f1:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1006f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1006f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006fd:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100701:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100705:	0f b6 12             	movzbl (%rdx),%edx
  100708:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10070a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10070e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100712:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100716:	48 85 c0             	test   %rax,%rax
  100719:	75 d2                	jne    1006ed <memmove+0x7b>
        }
    }
    return dst;
  10071b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10071f:	c9                   	leave
  100720:	c3                   	ret

0000000000100721 <memset>:

void* memset(void* v, int c, size_t n) {
  100721:	55                   	push   %rbp
  100722:	48 89 e5             	mov    %rsp,%rbp
  100725:	48 83 ec 28          	sub    $0x28,%rsp
  100729:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10072d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100730:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100734:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100738:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10073c:	eb 15                	jmp    100753 <memset+0x32>
        *p = c;
  10073e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100741:	89 c2                	mov    %eax,%edx
  100743:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100747:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100749:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10074e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100753:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100758:	75 e4                	jne    10073e <memset+0x1d>
    }
    return v;
  10075a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10075e:	c9                   	leave
  10075f:	c3                   	ret

0000000000100760 <strlen>:

size_t strlen(const char* s) {
  100760:	55                   	push   %rbp
  100761:	48 89 e5             	mov    %rsp,%rbp
  100764:	48 83 ec 18          	sub    $0x18,%rsp
  100768:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10076c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100773:	00 
  100774:	eb 0a                	jmp    100780 <strlen+0x20>
        ++n;
  100776:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10077b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100780:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100784:	0f b6 00             	movzbl (%rax),%eax
  100787:	84 c0                	test   %al,%al
  100789:	75 eb                	jne    100776 <strlen+0x16>
    }
    return n;
  10078b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10078f:	c9                   	leave
  100790:	c3                   	ret

0000000000100791 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100791:	55                   	push   %rbp
  100792:	48 89 e5             	mov    %rsp,%rbp
  100795:	48 83 ec 20          	sub    $0x20,%rsp
  100799:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10079d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1007a1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1007a8:	00 
  1007a9:	eb 0a                	jmp    1007b5 <strnlen+0x24>
        ++n;
  1007ab:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1007b0:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1007b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007b9:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1007bd:	74 0b                	je     1007ca <strnlen+0x39>
  1007bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007c3:	0f b6 00             	movzbl (%rax),%eax
  1007c6:	84 c0                	test   %al,%al
  1007c8:	75 e1                	jne    1007ab <strnlen+0x1a>
    }
    return n;
  1007ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1007ce:	c9                   	leave
  1007cf:	c3                   	ret

00000000001007d0 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1007d0:	55                   	push   %rbp
  1007d1:	48 89 e5             	mov    %rsp,%rbp
  1007d4:	48 83 ec 20          	sub    $0x20,%rsp
  1007d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1007dc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1007e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1007e8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1007ec:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1007f0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1007f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007f8:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1007fc:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100800:	0f b6 12             	movzbl (%rdx),%edx
  100803:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100805:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100809:	48 83 e8 01          	sub    $0x1,%rax
  10080d:	0f b6 00             	movzbl (%rax),%eax
  100810:	84 c0                	test   %al,%al
  100812:	75 d4                	jne    1007e8 <strcpy+0x18>
    return dst;
  100814:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100818:	c9                   	leave
  100819:	c3                   	ret

000000000010081a <strcmp>:

int strcmp(const char* a, const char* b) {
  10081a:	55                   	push   %rbp
  10081b:	48 89 e5             	mov    %rsp,%rbp
  10081e:	48 83 ec 10          	sub    $0x10,%rsp
  100822:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100826:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10082a:	eb 0a                	jmp    100836 <strcmp+0x1c>
        ++a, ++b;
  10082c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100831:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100836:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10083a:	0f b6 00             	movzbl (%rax),%eax
  10083d:	84 c0                	test   %al,%al
  10083f:	74 1d                	je     10085e <strcmp+0x44>
  100841:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100845:	0f b6 00             	movzbl (%rax),%eax
  100848:	84 c0                	test   %al,%al
  10084a:	74 12                	je     10085e <strcmp+0x44>
  10084c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100850:	0f b6 10             	movzbl (%rax),%edx
  100853:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100857:	0f b6 00             	movzbl (%rax),%eax
  10085a:	38 c2                	cmp    %al,%dl
  10085c:	74 ce                	je     10082c <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10085e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100862:	0f b6 00             	movzbl (%rax),%eax
  100865:	89 c2                	mov    %eax,%edx
  100867:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10086b:	0f b6 00             	movzbl (%rax),%eax
  10086e:	38 d0                	cmp    %dl,%al
  100870:	0f 92 c0             	setb   %al
  100873:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100876:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10087a:	0f b6 00             	movzbl (%rax),%eax
  10087d:	89 c1                	mov    %eax,%ecx
  10087f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100883:	0f b6 00             	movzbl (%rax),%eax
  100886:	38 c1                	cmp    %al,%cl
  100888:	0f 92 c0             	setb   %al
  10088b:	0f b6 c0             	movzbl %al,%eax
  10088e:	29 c2                	sub    %eax,%edx
  100890:	89 d0                	mov    %edx,%eax
}
  100892:	c9                   	leave
  100893:	c3                   	ret

0000000000100894 <strchr>:

char* strchr(const char* s, int c) {
  100894:	55                   	push   %rbp
  100895:	48 89 e5             	mov    %rsp,%rbp
  100898:	48 83 ec 10          	sub    $0x10,%rsp
  10089c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1008a0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1008a3:	eb 05                	jmp    1008aa <strchr+0x16>
        ++s;
  1008a5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1008aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008ae:	0f b6 00             	movzbl (%rax),%eax
  1008b1:	84 c0                	test   %al,%al
  1008b3:	74 0e                	je     1008c3 <strchr+0x2f>
  1008b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008b9:	0f b6 00             	movzbl (%rax),%eax
  1008bc:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1008bf:	38 d0                	cmp    %dl,%al
  1008c1:	75 e2                	jne    1008a5 <strchr+0x11>
    }
    if (*s == (char) c) {
  1008c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008c7:	0f b6 00             	movzbl (%rax),%eax
  1008ca:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1008cd:	38 d0                	cmp    %dl,%al
  1008cf:	75 06                	jne    1008d7 <strchr+0x43>
        return (char*) s;
  1008d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008d5:	eb 05                	jmp    1008dc <strchr+0x48>
    } else {
        return NULL;
  1008d7:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1008dc:	c9                   	leave
  1008dd:	c3                   	ret

00000000001008de <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1008de:	55                   	push   %rbp
  1008df:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1008e2:	8b 05 40 17 00 00    	mov    0x1740(%rip),%eax        # 102028 <rand_seed_set>
  1008e8:	85 c0                	test   %eax,%eax
  1008ea:	75 0a                	jne    1008f6 <rand+0x18>
        srand(819234718U);
  1008ec:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1008f1:	e8 24 00 00 00       	call   10091a <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1008f6:	8b 05 30 17 00 00    	mov    0x1730(%rip),%eax        # 10202c <rand_seed>
  1008fc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100902:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100907:	89 05 1f 17 00 00    	mov    %eax,0x171f(%rip)        # 10202c <rand_seed>
    return rand_seed & RAND_MAX;
  10090d:	8b 05 19 17 00 00    	mov    0x1719(%rip),%eax        # 10202c <rand_seed>
  100913:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100918:	5d                   	pop    %rbp
  100919:	c3                   	ret

000000000010091a <srand>:

void srand(unsigned seed) {
  10091a:	55                   	push   %rbp
  10091b:	48 89 e5             	mov    %rsp,%rbp
  10091e:	48 83 ec 08          	sub    $0x8,%rsp
  100922:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100925:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100928:	89 05 fe 16 00 00    	mov    %eax,0x16fe(%rip)        # 10202c <rand_seed>
    rand_seed_set = 1;
  10092e:	c7 05 f0 16 00 00 01 	movl   $0x1,0x16f0(%rip)        # 102028 <rand_seed_set>
  100935:	00 00 00 
}
  100938:	90                   	nop
  100939:	c9                   	leave
  10093a:	c3                   	ret

000000000010093b <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10093b:	55                   	push   %rbp
  10093c:	48 89 e5             	mov    %rsp,%rbp
  10093f:	48 83 ec 28          	sub    $0x28,%rsp
  100943:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100947:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10094b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10094e:	48 c7 45 f8 f0 18 10 	movq   $0x1018f0,-0x8(%rbp)
  100955:	00 
    if (base < 0) {
  100956:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10095a:	79 0b                	jns    100967 <fill_numbuf+0x2c>
        digits = lower_digits;
  10095c:	48 c7 45 f8 10 19 10 	movq   $0x101910,-0x8(%rbp)
  100963:	00 
        base = -base;
  100964:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100967:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10096c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100970:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100973:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100976:	48 63 c8             	movslq %eax,%rcx
  100979:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10097d:	ba 00 00 00 00       	mov    $0x0,%edx
  100982:	48 f7 f1             	div    %rcx
  100985:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100989:	48 01 d0             	add    %rdx,%rax
  10098c:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100991:	0f b6 10             	movzbl (%rax),%edx
  100994:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100998:	88 10                	mov    %dl,(%rax)
        val /= base;
  10099a:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10099d:	48 63 f0             	movslq %eax,%rsi
  1009a0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009a4:	ba 00 00 00 00       	mov    $0x0,%edx
  1009a9:	48 f7 f6             	div    %rsi
  1009ac:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1009b0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1009b5:	75 bc                	jne    100973 <fill_numbuf+0x38>
    return numbuf_end;
  1009b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009bb:	c9                   	leave
  1009bc:	c3                   	ret

00000000001009bd <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1009bd:	55                   	push   %rbp
  1009be:	48 89 e5             	mov    %rsp,%rbp
  1009c1:	53                   	push   %rbx
  1009c2:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1009c9:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1009d0:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1009d6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009dd:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1009e4:	e9 8a 09 00 00       	jmp    101373 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1009e9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009f0:	0f b6 00             	movzbl (%rax),%eax
  1009f3:	3c 25                	cmp    $0x25,%al
  1009f5:	74 31                	je     100a28 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1009f7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1009fe:	4c 8b 00             	mov    (%rax),%r8
  100a01:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a08:	0f b6 00             	movzbl (%rax),%eax
  100a0b:	0f b6 c8             	movzbl %al,%ecx
  100a0e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100a14:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a1b:	89 ce                	mov    %ecx,%esi
  100a1d:	48 89 c7             	mov    %rax,%rdi
  100a20:	41 ff d0             	call   *%r8
            continue;
  100a23:	e9 43 09 00 00       	jmp    10136b <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100a28:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a2f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a36:	01 
  100a37:	eb 44                	jmp    100a7d <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100a39:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a40:	0f b6 00             	movzbl (%rax),%eax
  100a43:	0f be c0             	movsbl %al,%eax
  100a46:	89 c6                	mov    %eax,%esi
  100a48:	bf 10 17 10 00       	mov    $0x101710,%edi
  100a4d:	e8 42 fe ff ff       	call   100894 <strchr>
  100a52:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100a56:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100a5b:	74 30                	je     100a8d <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100a5d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100a61:	48 2d 10 17 10 00    	sub    $0x101710,%rax
  100a67:	ba 01 00 00 00       	mov    $0x1,%edx
  100a6c:	89 c1                	mov    %eax,%ecx
  100a6e:	d3 e2                	shl    %cl,%edx
  100a70:	89 d0                	mov    %edx,%eax
  100a72:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a75:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a7c:	01 
  100a7d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a84:	0f b6 00             	movzbl (%rax),%eax
  100a87:	84 c0                	test   %al,%al
  100a89:	75 ae                	jne    100a39 <printer_vprintf+0x7c>
  100a8b:	eb 01                	jmp    100a8e <printer_vprintf+0xd1>
            } else {
                break;
  100a8d:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100a8e:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100a95:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a9c:	0f b6 00             	movzbl (%rax),%eax
  100a9f:	3c 30                	cmp    $0x30,%al
  100aa1:	7e 67                	jle    100b0a <printer_vprintf+0x14d>
  100aa3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aaa:	0f b6 00             	movzbl (%rax),%eax
  100aad:	3c 39                	cmp    $0x39,%al
  100aaf:	7f 59                	jg     100b0a <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100ab1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100ab8:	eb 2e                	jmp    100ae8 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100aba:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100abd:	89 d0                	mov    %edx,%eax
  100abf:	c1 e0 02             	shl    $0x2,%eax
  100ac2:	01 d0                	add    %edx,%eax
  100ac4:	01 c0                	add    %eax,%eax
  100ac6:	89 c1                	mov    %eax,%ecx
  100ac8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100acf:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100ad3:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100ada:	0f b6 00             	movzbl (%rax),%eax
  100add:	0f be c0             	movsbl %al,%eax
  100ae0:	01 c8                	add    %ecx,%eax
  100ae2:	83 e8 30             	sub    $0x30,%eax
  100ae5:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100ae8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aef:	0f b6 00             	movzbl (%rax),%eax
  100af2:	3c 2f                	cmp    $0x2f,%al
  100af4:	0f 8e 85 00 00 00    	jle    100b7f <printer_vprintf+0x1c2>
  100afa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b01:	0f b6 00             	movzbl (%rax),%eax
  100b04:	3c 39                	cmp    $0x39,%al
  100b06:	7e b2                	jle    100aba <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100b08:	eb 75                	jmp    100b7f <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100b0a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b11:	0f b6 00             	movzbl (%rax),%eax
  100b14:	3c 2a                	cmp    $0x2a,%al
  100b16:	75 68                	jne    100b80 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100b18:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b1f:	8b 00                	mov    (%rax),%eax
  100b21:	83 f8 2f             	cmp    $0x2f,%eax
  100b24:	77 30                	ja     100b56 <printer_vprintf+0x199>
  100b26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b2d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b38:	8b 00                	mov    (%rax),%eax
  100b3a:	89 c0                	mov    %eax,%eax
  100b3c:	48 01 d0             	add    %rdx,%rax
  100b3f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b46:	8b 12                	mov    (%rdx),%edx
  100b48:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b4b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b52:	89 0a                	mov    %ecx,(%rdx)
  100b54:	eb 1a                	jmp    100b70 <printer_vprintf+0x1b3>
  100b56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b61:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b6c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b70:	8b 00                	mov    (%rax),%eax
  100b72:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100b75:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b7c:	01 
  100b7d:	eb 01                	jmp    100b80 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100b7f:	90                   	nop
        }

        // process precision
        int precision = -1;
  100b80:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100b87:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b8e:	0f b6 00             	movzbl (%rax),%eax
  100b91:	3c 2e                	cmp    $0x2e,%al
  100b93:	0f 85 00 01 00 00    	jne    100c99 <printer_vprintf+0x2dc>
            ++format;
  100b99:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ba0:	01 
            if (*format >= '0' && *format <= '9') {
  100ba1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ba8:	0f b6 00             	movzbl (%rax),%eax
  100bab:	3c 2f                	cmp    $0x2f,%al
  100bad:	7e 67                	jle    100c16 <printer_vprintf+0x259>
  100baf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bb6:	0f b6 00             	movzbl (%rax),%eax
  100bb9:	3c 39                	cmp    $0x39,%al
  100bbb:	7f 59                	jg     100c16 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100bbd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100bc4:	eb 2e                	jmp    100bf4 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100bc6:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100bc9:	89 d0                	mov    %edx,%eax
  100bcb:	c1 e0 02             	shl    $0x2,%eax
  100bce:	01 d0                	add    %edx,%eax
  100bd0:	01 c0                	add    %eax,%eax
  100bd2:	89 c1                	mov    %eax,%ecx
  100bd4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bdb:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100bdf:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100be6:	0f b6 00             	movzbl (%rax),%eax
  100be9:	0f be c0             	movsbl %al,%eax
  100bec:	01 c8                	add    %ecx,%eax
  100bee:	83 e8 30             	sub    $0x30,%eax
  100bf1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100bf4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bfb:	0f b6 00             	movzbl (%rax),%eax
  100bfe:	3c 2f                	cmp    $0x2f,%al
  100c00:	0f 8e 85 00 00 00    	jle    100c8b <printer_vprintf+0x2ce>
  100c06:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c0d:	0f b6 00             	movzbl (%rax),%eax
  100c10:	3c 39                	cmp    $0x39,%al
  100c12:	7e b2                	jle    100bc6 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100c14:	eb 75                	jmp    100c8b <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100c16:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c1d:	0f b6 00             	movzbl (%rax),%eax
  100c20:	3c 2a                	cmp    $0x2a,%al
  100c22:	75 68                	jne    100c8c <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100c24:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2b:	8b 00                	mov    (%rax),%eax
  100c2d:	83 f8 2f             	cmp    $0x2f,%eax
  100c30:	77 30                	ja     100c62 <printer_vprintf+0x2a5>
  100c32:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c39:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c3d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c44:	8b 00                	mov    (%rax),%eax
  100c46:	89 c0                	mov    %eax,%eax
  100c48:	48 01 d0             	add    %rdx,%rax
  100c4b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c52:	8b 12                	mov    (%rdx),%edx
  100c54:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c57:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c5e:	89 0a                	mov    %ecx,(%rdx)
  100c60:	eb 1a                	jmp    100c7c <printer_vprintf+0x2bf>
  100c62:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c69:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c6d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c71:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c78:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c7c:	8b 00                	mov    (%rax),%eax
  100c7e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100c81:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c88:	01 
  100c89:	eb 01                	jmp    100c8c <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100c8b:	90                   	nop
            }
            if (precision < 0) {
  100c8c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100c90:	79 07                	jns    100c99 <printer_vprintf+0x2dc>
                precision = 0;
  100c92:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100c99:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100ca0:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100ca7:	00 
        int length = 0;
  100ca8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100caf:	48 c7 45 c8 16 17 10 	movq   $0x101716,-0x38(%rbp)
  100cb6:	00 
    again:
        switch (*format) {
  100cb7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cbe:	0f b6 00             	movzbl (%rax),%eax
  100cc1:	0f be c0             	movsbl %al,%eax
  100cc4:	83 e8 43             	sub    $0x43,%eax
  100cc7:	83 f8 37             	cmp    $0x37,%eax
  100cca:	0f 87 9f 03 00 00    	ja     10106f <printer_vprintf+0x6b2>
  100cd0:	89 c0                	mov    %eax,%eax
  100cd2:	48 8b 04 c5 28 17 10 	mov    0x101728(,%rax,8),%rax
  100cd9:	00 
  100cda:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100cdc:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100ce3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100cea:	01 
            goto again;
  100ceb:	eb ca                	jmp    100cb7 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100ced:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100cf1:	74 5d                	je     100d50 <printer_vprintf+0x393>
  100cf3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cfa:	8b 00                	mov    (%rax),%eax
  100cfc:	83 f8 2f             	cmp    $0x2f,%eax
  100cff:	77 30                	ja     100d31 <printer_vprintf+0x374>
  100d01:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d08:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d0c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d13:	8b 00                	mov    (%rax),%eax
  100d15:	89 c0                	mov    %eax,%eax
  100d17:	48 01 d0             	add    %rdx,%rax
  100d1a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d21:	8b 12                	mov    (%rdx),%edx
  100d23:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d2d:	89 0a                	mov    %ecx,(%rdx)
  100d2f:	eb 1a                	jmp    100d4b <printer_vprintf+0x38e>
  100d31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d38:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d3c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d40:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d47:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d4b:	48 8b 00             	mov    (%rax),%rax
  100d4e:	eb 5c                	jmp    100dac <printer_vprintf+0x3ef>
  100d50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d57:	8b 00                	mov    (%rax),%eax
  100d59:	83 f8 2f             	cmp    $0x2f,%eax
  100d5c:	77 30                	ja     100d8e <printer_vprintf+0x3d1>
  100d5e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d65:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d69:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d70:	8b 00                	mov    (%rax),%eax
  100d72:	89 c0                	mov    %eax,%eax
  100d74:	48 01 d0             	add    %rdx,%rax
  100d77:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d7e:	8b 12                	mov    (%rdx),%edx
  100d80:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d83:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d8a:	89 0a                	mov    %ecx,(%rdx)
  100d8c:	eb 1a                	jmp    100da8 <printer_vprintf+0x3eb>
  100d8e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d95:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d99:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d9d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100da4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100da8:	8b 00                	mov    (%rax),%eax
  100daa:	48 98                	cltq
  100dac:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100db0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100db4:	48 c1 f8 38          	sar    $0x38,%rax
  100db8:	25 80 00 00 00       	and    $0x80,%eax
  100dbd:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100dc0:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100dc4:	74 09                	je     100dcf <printer_vprintf+0x412>
  100dc6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100dca:	48 f7 d8             	neg    %rax
  100dcd:	eb 04                	jmp    100dd3 <printer_vprintf+0x416>
  100dcf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100dd3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100dd7:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100dda:	83 c8 60             	or     $0x60,%eax
  100ddd:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100de0:	e9 cf 02 00 00       	jmp    1010b4 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100de5:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100de9:	74 5d                	je     100e48 <printer_vprintf+0x48b>
  100deb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100df2:	8b 00                	mov    (%rax),%eax
  100df4:	83 f8 2f             	cmp    $0x2f,%eax
  100df7:	77 30                	ja     100e29 <printer_vprintf+0x46c>
  100df9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e00:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e0b:	8b 00                	mov    (%rax),%eax
  100e0d:	89 c0                	mov    %eax,%eax
  100e0f:	48 01 d0             	add    %rdx,%rax
  100e12:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e19:	8b 12                	mov    (%rdx),%edx
  100e1b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e1e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e25:	89 0a                	mov    %ecx,(%rdx)
  100e27:	eb 1a                	jmp    100e43 <printer_vprintf+0x486>
  100e29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e30:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e34:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e38:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e3f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e43:	48 8b 00             	mov    (%rax),%rax
  100e46:	eb 5c                	jmp    100ea4 <printer_vprintf+0x4e7>
  100e48:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e4f:	8b 00                	mov    (%rax),%eax
  100e51:	83 f8 2f             	cmp    $0x2f,%eax
  100e54:	77 30                	ja     100e86 <printer_vprintf+0x4c9>
  100e56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e5d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e68:	8b 00                	mov    (%rax),%eax
  100e6a:	89 c0                	mov    %eax,%eax
  100e6c:	48 01 d0             	add    %rdx,%rax
  100e6f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e76:	8b 12                	mov    (%rdx),%edx
  100e78:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e7b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e82:	89 0a                	mov    %ecx,(%rdx)
  100e84:	eb 1a                	jmp    100ea0 <printer_vprintf+0x4e3>
  100e86:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e8d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e91:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e95:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e9c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ea0:	8b 00                	mov    (%rax),%eax
  100ea2:	89 c0                	mov    %eax,%eax
  100ea4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ea8:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100eac:	e9 03 02 00 00       	jmp    1010b4 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100eb1:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100eb8:	e9 28 ff ff ff       	jmp    100de5 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100ebd:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100ec4:	e9 1c ff ff ff       	jmp    100de5 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100ec9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ed0:	8b 00                	mov    (%rax),%eax
  100ed2:	83 f8 2f             	cmp    $0x2f,%eax
  100ed5:	77 30                	ja     100f07 <printer_vprintf+0x54a>
  100ed7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ede:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ee2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ee9:	8b 00                	mov    (%rax),%eax
  100eeb:	89 c0                	mov    %eax,%eax
  100eed:	48 01 d0             	add    %rdx,%rax
  100ef0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ef7:	8b 12                	mov    (%rdx),%edx
  100ef9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100efc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f03:	89 0a                	mov    %ecx,(%rdx)
  100f05:	eb 1a                	jmp    100f21 <printer_vprintf+0x564>
  100f07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f0e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f12:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f16:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f1d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f21:	48 8b 00             	mov    (%rax),%rax
  100f24:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100f28:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100f2f:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100f36:	e9 79 01 00 00       	jmp    1010b4 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100f3b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f42:	8b 00                	mov    (%rax),%eax
  100f44:	83 f8 2f             	cmp    $0x2f,%eax
  100f47:	77 30                	ja     100f79 <printer_vprintf+0x5bc>
  100f49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f50:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f5b:	8b 00                	mov    (%rax),%eax
  100f5d:	89 c0                	mov    %eax,%eax
  100f5f:	48 01 d0             	add    %rdx,%rax
  100f62:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f69:	8b 12                	mov    (%rdx),%edx
  100f6b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f6e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f75:	89 0a                	mov    %ecx,(%rdx)
  100f77:	eb 1a                	jmp    100f93 <printer_vprintf+0x5d6>
  100f79:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f80:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f84:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f88:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f8f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f93:	48 8b 00             	mov    (%rax),%rax
  100f96:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100f9a:	e9 15 01 00 00       	jmp    1010b4 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100f9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fa6:	8b 00                	mov    (%rax),%eax
  100fa8:	83 f8 2f             	cmp    $0x2f,%eax
  100fab:	77 30                	ja     100fdd <printer_vprintf+0x620>
  100fad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fb8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fbf:	8b 00                	mov    (%rax),%eax
  100fc1:	89 c0                	mov    %eax,%eax
  100fc3:	48 01 d0             	add    %rdx,%rax
  100fc6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fcd:	8b 12                	mov    (%rdx),%edx
  100fcf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fd2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fd9:	89 0a                	mov    %ecx,(%rdx)
  100fdb:	eb 1a                	jmp    100ff7 <printer_vprintf+0x63a>
  100fdd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe4:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fe8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ff3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ff7:	8b 00                	mov    (%rax),%eax
  100ff9:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100fff:	e9 67 03 00 00       	jmp    10136b <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  101004:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101008:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  10100c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101013:	8b 00                	mov    (%rax),%eax
  101015:	83 f8 2f             	cmp    $0x2f,%eax
  101018:	77 30                	ja     10104a <printer_vprintf+0x68d>
  10101a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101021:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101025:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10102c:	8b 00                	mov    (%rax),%eax
  10102e:	89 c0                	mov    %eax,%eax
  101030:	48 01 d0             	add    %rdx,%rax
  101033:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10103a:	8b 12                	mov    (%rdx),%edx
  10103c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10103f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101046:	89 0a                	mov    %ecx,(%rdx)
  101048:	eb 1a                	jmp    101064 <printer_vprintf+0x6a7>
  10104a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101051:	48 8b 40 08          	mov    0x8(%rax),%rax
  101055:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101059:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101060:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101064:	8b 00                	mov    (%rax),%eax
  101066:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101069:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  10106d:	eb 45                	jmp    1010b4 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  10106f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101073:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  101077:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10107e:	0f b6 00             	movzbl (%rax),%eax
  101081:	84 c0                	test   %al,%al
  101083:	74 0c                	je     101091 <printer_vprintf+0x6d4>
  101085:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10108c:	0f b6 00             	movzbl (%rax),%eax
  10108f:	eb 05                	jmp    101096 <printer_vprintf+0x6d9>
  101091:	b8 25 00 00 00       	mov    $0x25,%eax
  101096:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101099:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  10109d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010a4:	0f b6 00             	movzbl (%rax),%eax
  1010a7:	84 c0                	test   %al,%al
  1010a9:	75 08                	jne    1010b3 <printer_vprintf+0x6f6>
                format--;
  1010ab:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  1010b2:	01 
            }
            break;
  1010b3:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  1010b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010b7:	83 e0 20             	and    $0x20,%eax
  1010ba:	85 c0                	test   %eax,%eax
  1010bc:	74 1e                	je     1010dc <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  1010be:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1010c2:	48 83 c0 18          	add    $0x18,%rax
  1010c6:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1010c9:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1010cd:	48 89 ce             	mov    %rcx,%rsi
  1010d0:	48 89 c7             	mov    %rax,%rdi
  1010d3:	e8 63 f8 ff ff       	call   10093b <fill_numbuf>
  1010d8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  1010dc:	48 c7 45 c0 16 17 10 	movq   $0x101716,-0x40(%rbp)
  1010e3:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1010e4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010e7:	83 e0 20             	and    $0x20,%eax
  1010ea:	85 c0                	test   %eax,%eax
  1010ec:	74 48                	je     101136 <printer_vprintf+0x779>
  1010ee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010f1:	83 e0 40             	and    $0x40,%eax
  1010f4:	85 c0                	test   %eax,%eax
  1010f6:	74 3e                	je     101136 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  1010f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010fb:	25 80 00 00 00       	and    $0x80,%eax
  101100:	85 c0                	test   %eax,%eax
  101102:	74 0a                	je     10110e <printer_vprintf+0x751>
                prefix = "-";
  101104:	48 c7 45 c0 17 17 10 	movq   $0x101717,-0x40(%rbp)
  10110b:	00 
            if (flags & FLAG_NEGATIVE) {
  10110c:	eb 73                	jmp    101181 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  10110e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101111:	83 e0 10             	and    $0x10,%eax
  101114:	85 c0                	test   %eax,%eax
  101116:	74 0a                	je     101122 <printer_vprintf+0x765>
                prefix = "+";
  101118:	48 c7 45 c0 19 17 10 	movq   $0x101719,-0x40(%rbp)
  10111f:	00 
            if (flags & FLAG_NEGATIVE) {
  101120:	eb 5f                	jmp    101181 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101122:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101125:	83 e0 08             	and    $0x8,%eax
  101128:	85 c0                	test   %eax,%eax
  10112a:	74 55                	je     101181 <printer_vprintf+0x7c4>
                prefix = " ";
  10112c:	48 c7 45 c0 1b 17 10 	movq   $0x10171b,-0x40(%rbp)
  101133:	00 
            if (flags & FLAG_NEGATIVE) {
  101134:	eb 4b                	jmp    101181 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101136:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101139:	83 e0 20             	and    $0x20,%eax
  10113c:	85 c0                	test   %eax,%eax
  10113e:	74 42                	je     101182 <printer_vprintf+0x7c5>
  101140:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101143:	83 e0 01             	and    $0x1,%eax
  101146:	85 c0                	test   %eax,%eax
  101148:	74 38                	je     101182 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  10114a:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  10114e:	74 06                	je     101156 <printer_vprintf+0x799>
  101150:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101154:	75 2c                	jne    101182 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  101156:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10115b:	75 0c                	jne    101169 <printer_vprintf+0x7ac>
  10115d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101160:	25 00 01 00 00       	and    $0x100,%eax
  101165:	85 c0                	test   %eax,%eax
  101167:	74 19                	je     101182 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  101169:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  10116d:	75 07                	jne    101176 <printer_vprintf+0x7b9>
  10116f:	b8 1d 17 10 00       	mov    $0x10171d,%eax
  101174:	eb 05                	jmp    10117b <printer_vprintf+0x7be>
  101176:	b8 20 17 10 00       	mov    $0x101720,%eax
  10117b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10117f:	eb 01                	jmp    101182 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  101181:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101182:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101186:	78 24                	js     1011ac <printer_vprintf+0x7ef>
  101188:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10118b:	83 e0 20             	and    $0x20,%eax
  10118e:	85 c0                	test   %eax,%eax
  101190:	75 1a                	jne    1011ac <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  101192:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101195:	48 63 d0             	movslq %eax,%rdx
  101198:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10119c:	48 89 d6             	mov    %rdx,%rsi
  10119f:	48 89 c7             	mov    %rax,%rdi
  1011a2:	e8 ea f5 ff ff       	call   100791 <strnlen>
  1011a7:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1011aa:	eb 0f                	jmp    1011bb <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  1011ac:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1011b0:	48 89 c7             	mov    %rax,%rdi
  1011b3:	e8 a8 f5 ff ff       	call   100760 <strlen>
  1011b8:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1011bb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011be:	83 e0 20             	and    $0x20,%eax
  1011c1:	85 c0                	test   %eax,%eax
  1011c3:	74 20                	je     1011e5 <printer_vprintf+0x828>
  1011c5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1011c9:	78 1a                	js     1011e5 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  1011cb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011ce:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1011d1:	7e 08                	jle    1011db <printer_vprintf+0x81e>
  1011d3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011d6:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1011d9:	eb 05                	jmp    1011e0 <printer_vprintf+0x823>
  1011db:	b8 00 00 00 00       	mov    $0x0,%eax
  1011e0:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1011e3:	eb 5c                	jmp    101241 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1011e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011e8:	83 e0 20             	and    $0x20,%eax
  1011eb:	85 c0                	test   %eax,%eax
  1011ed:	74 4b                	je     10123a <printer_vprintf+0x87d>
  1011ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011f2:	83 e0 02             	and    $0x2,%eax
  1011f5:	85 c0                	test   %eax,%eax
  1011f7:	74 41                	je     10123a <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1011f9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011fc:	83 e0 04             	and    $0x4,%eax
  1011ff:	85 c0                	test   %eax,%eax
  101201:	75 37                	jne    10123a <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101203:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101207:	48 89 c7             	mov    %rax,%rdi
  10120a:	e8 51 f5 ff ff       	call   100760 <strlen>
  10120f:	89 c2                	mov    %eax,%edx
  101211:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101214:	01 d0                	add    %edx,%eax
  101216:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101219:	7e 1f                	jle    10123a <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10121b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10121e:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101221:	89 c3                	mov    %eax,%ebx
  101223:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101227:	48 89 c7             	mov    %rax,%rdi
  10122a:	e8 31 f5 ff ff       	call   100760 <strlen>
  10122f:	89 c2                	mov    %eax,%edx
  101231:	89 d8                	mov    %ebx,%eax
  101233:	29 d0                	sub    %edx,%eax
  101235:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101238:	eb 07                	jmp    101241 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10123a:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101241:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101244:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101247:	01 d0                	add    %edx,%eax
  101249:	48 63 d8             	movslq %eax,%rbx
  10124c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101250:	48 89 c7             	mov    %rax,%rdi
  101253:	e8 08 f5 ff ff       	call   100760 <strlen>
  101258:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10125c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10125f:	29 d0                	sub    %edx,%eax
  101261:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101264:	eb 25                	jmp    10128b <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  101266:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10126d:	48 8b 08             	mov    (%rax),%rcx
  101270:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101276:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10127d:	be 20 00 00 00       	mov    $0x20,%esi
  101282:	48 89 c7             	mov    %rax,%rdi
  101285:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101287:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10128b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10128e:	83 e0 04             	and    $0x4,%eax
  101291:	85 c0                	test   %eax,%eax
  101293:	75 36                	jne    1012cb <printer_vprintf+0x90e>
  101295:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101299:	7f cb                	jg     101266 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  10129b:	eb 2e                	jmp    1012cb <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  10129d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012a4:	4c 8b 00             	mov    (%rax),%r8
  1012a7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012ab:	0f b6 00             	movzbl (%rax),%eax
  1012ae:	0f b6 c8             	movzbl %al,%ecx
  1012b1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012b7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012be:	89 ce                	mov    %ecx,%esi
  1012c0:	48 89 c7             	mov    %rax,%rdi
  1012c3:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1012c6:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1012cb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012cf:	0f b6 00             	movzbl (%rax),%eax
  1012d2:	84 c0                	test   %al,%al
  1012d4:	75 c7                	jne    10129d <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1012d6:	eb 25                	jmp    1012fd <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1012d8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012df:	48 8b 08             	mov    (%rax),%rcx
  1012e2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012e8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012ef:	be 30 00 00 00       	mov    $0x30,%esi
  1012f4:	48 89 c7             	mov    %rax,%rdi
  1012f7:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1012f9:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1012fd:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101301:	7f d5                	jg     1012d8 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101303:	eb 32                	jmp    101337 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101305:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10130c:	4c 8b 00             	mov    (%rax),%r8
  10130f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101313:	0f b6 00             	movzbl (%rax),%eax
  101316:	0f b6 c8             	movzbl %al,%ecx
  101319:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10131f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101326:	89 ce                	mov    %ecx,%esi
  101328:	48 89 c7             	mov    %rax,%rdi
  10132b:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10132e:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101333:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101337:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10133b:	7f c8                	jg     101305 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  10133d:	eb 25                	jmp    101364 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  10133f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101346:	48 8b 08             	mov    (%rax),%rcx
  101349:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10134f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101356:	be 20 00 00 00       	mov    $0x20,%esi
  10135b:	48 89 c7             	mov    %rax,%rdi
  10135e:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101360:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101364:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101368:	7f d5                	jg     10133f <printer_vprintf+0x982>
        }
    done: ;
  10136a:	90                   	nop
    for (; *format; ++format) {
  10136b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101372:	01 
  101373:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10137a:	0f b6 00             	movzbl (%rax),%eax
  10137d:	84 c0                	test   %al,%al
  10137f:	0f 85 64 f6 ff ff    	jne    1009e9 <printer_vprintf+0x2c>
    }
}
  101385:	90                   	nop
  101386:	90                   	nop
  101387:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10138b:	c9                   	leave
  10138c:	c3                   	ret

000000000010138d <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10138d:	55                   	push   %rbp
  10138e:	48 89 e5             	mov    %rsp,%rbp
  101391:	48 83 ec 20          	sub    $0x20,%rsp
  101395:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101399:	89 f0                	mov    %esi,%eax
  10139b:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10139e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1013a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1013a5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1013a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013ad:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013b1:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1013b6:	48 39 d0             	cmp    %rdx,%rax
  1013b9:	72 0c                	jb     1013c7 <console_putc+0x3a>
        cp->cursor = console;
  1013bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013bf:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1013c6:	00 
    }
    if (c == '\n') {
  1013c7:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1013cb:	75 78                	jne    101445 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1013cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013d1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013d5:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1013db:	48 d1 f8             	sar    %rax
  1013de:	48 89 c1             	mov    %rax,%rcx
  1013e1:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1013e8:	66 66 66 
  1013eb:	48 89 c8             	mov    %rcx,%rax
  1013ee:	48 f7 ea             	imul   %rdx
  1013f1:	48 c1 fa 05          	sar    $0x5,%rdx
  1013f5:	48 89 c8             	mov    %rcx,%rax
  1013f8:	48 c1 f8 3f          	sar    $0x3f,%rax
  1013fc:	48 29 c2             	sub    %rax,%rdx
  1013ff:	48 89 d0             	mov    %rdx,%rax
  101402:	48 c1 e0 02          	shl    $0x2,%rax
  101406:	48 01 d0             	add    %rdx,%rax
  101409:	48 c1 e0 04          	shl    $0x4,%rax
  10140d:	48 29 c1             	sub    %rax,%rcx
  101410:	48 89 ca             	mov    %rcx,%rdx
  101413:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101416:	eb 25                	jmp    10143d <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101418:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10141b:	83 c8 20             	or     $0x20,%eax
  10141e:	89 c6                	mov    %eax,%esi
  101420:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101424:	48 8b 40 08          	mov    0x8(%rax),%rax
  101428:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10142c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101430:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101434:	89 f2                	mov    %esi,%edx
  101436:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101439:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10143d:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101441:	75 d5                	jne    101418 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101443:	eb 24                	jmp    101469 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101445:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101449:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10144c:	09 d0                	or     %edx,%eax
  10144e:	89 c6                	mov    %eax,%esi
  101450:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101454:	48 8b 40 08          	mov    0x8(%rax),%rax
  101458:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10145c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101460:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101464:	89 f2                	mov    %esi,%edx
  101466:	66 89 10             	mov    %dx,(%rax)
}
  101469:	90                   	nop
  10146a:	c9                   	leave
  10146b:	c3                   	ret

000000000010146c <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10146c:	55                   	push   %rbp
  10146d:	48 89 e5             	mov    %rsp,%rbp
  101470:	48 83 ec 30          	sub    $0x30,%rsp
  101474:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101477:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10147a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10147e:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101482:	48 c7 45 f0 8d 13 10 	movq   $0x10138d,-0x10(%rbp)
  101489:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10148a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10148e:	78 09                	js     101499 <console_vprintf+0x2d>
  101490:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101497:	7e 07                	jle    1014a0 <console_vprintf+0x34>
        cpos = 0;
  101499:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1014a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014a3:	48 98                	cltq
  1014a5:	48 01 c0             	add    %rax,%rax
  1014a8:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1014ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1014b2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1014b6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1014ba:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1014bd:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1014c1:	48 89 c7             	mov    %rax,%rdi
  1014c4:	e8 f4 f4 ff ff       	call   1009bd <printer_vprintf>
    return cp.cursor - console;
  1014c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1014cd:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1014d3:	48 d1 f8             	sar    %rax
}
  1014d6:	c9                   	leave
  1014d7:	c3                   	ret

00000000001014d8 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1014d8:	55                   	push   %rbp
  1014d9:	48 89 e5             	mov    %rsp,%rbp
  1014dc:	48 83 ec 60          	sub    $0x60,%rsp
  1014e0:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1014e3:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1014e6:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1014ea:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1014ee:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1014f2:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1014f6:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1014fd:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101501:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101505:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101509:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10150d:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101511:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101515:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101518:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10151b:	89 c7                	mov    %eax,%edi
  10151d:	e8 4a ff ff ff       	call   10146c <console_vprintf>
  101522:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101525:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101528:	c9                   	leave
  101529:	c3                   	ret

000000000010152a <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10152a:	55                   	push   %rbp
  10152b:	48 89 e5             	mov    %rsp,%rbp
  10152e:	48 83 ec 20          	sub    $0x20,%rsp
  101532:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101536:	89 f0                	mov    %esi,%eax
  101538:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10153b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10153e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101542:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101546:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10154a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10154e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101552:	48 8b 40 10          	mov    0x10(%rax),%rax
  101556:	48 39 c2             	cmp    %rax,%rdx
  101559:	73 1a                	jae    101575 <string_putc+0x4b>
        *sp->s++ = c;
  10155b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10155f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101563:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101567:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10156b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10156f:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101573:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101575:	90                   	nop
  101576:	c9                   	leave
  101577:	c3                   	ret

0000000000101578 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101578:	55                   	push   %rbp
  101579:	48 89 e5             	mov    %rsp,%rbp
  10157c:	48 83 ec 40          	sub    $0x40,%rsp
  101580:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101584:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101588:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10158c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101590:	48 c7 45 e8 2a 15 10 	movq   $0x10152a,-0x18(%rbp)
  101597:	00 
    sp.s = s;
  101598:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10159c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1015a0:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1015a5:	74 33                	je     1015da <vsnprintf+0x62>
        sp.end = s + size - 1;
  1015a7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1015ab:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1015af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1015b3:	48 01 d0             	add    %rdx,%rax
  1015b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1015ba:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1015be:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1015c2:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1015c6:	be 00 00 00 00       	mov    $0x0,%esi
  1015cb:	48 89 c7             	mov    %rax,%rdi
  1015ce:	e8 ea f3 ff ff       	call   1009bd <printer_vprintf>
        *sp.s = 0;
  1015d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015d7:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1015da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015de:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1015e2:	c9                   	leave
  1015e3:	c3                   	ret

00000000001015e4 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1015e4:	55                   	push   %rbp
  1015e5:	48 89 e5             	mov    %rsp,%rbp
  1015e8:	48 83 ec 70          	sub    $0x70,%rsp
  1015ec:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1015f0:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1015f4:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1015f8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1015fc:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101600:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101604:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10160b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10160f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101613:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101617:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10161b:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10161f:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101623:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101627:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10162b:	48 89 c7             	mov    %rax,%rdi
  10162e:	e8 45 ff ff ff       	call   101578 <vsnprintf>
  101633:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101636:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101639:	c9                   	leave
  10163a:	c3                   	ret

000000000010163b <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10163b:	55                   	push   %rbp
  10163c:	48 89 e5             	mov    %rsp,%rbp
  10163f:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101643:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10164a:	eb 13                	jmp    10165f <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10164c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10164f:	48 98                	cltq
  101651:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101658:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10165b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10165f:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101666:	7e e4                	jle    10164c <console_clear+0x11>
    }
    cursorpos = 0;
  101668:	c7 05 8a 79 fb ff 00 	movl   $0x0,-0x48676(%rip)        # b8ffc <cursorpos>
  10166f:	00 00 00 
}
  101672:	90                   	nop
  101673:	c9                   	leave
  101674:	c3                   	ret
