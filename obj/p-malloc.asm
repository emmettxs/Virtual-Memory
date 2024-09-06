
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 27 30 10 00       	mov    $0x103027,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 1f 00 00 	mov    %rax,0x1fe9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 1f 00 00 	mov    %rax,0x1fcd(%rip)        # 102000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 9e 06 00 00       	call   1006da <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 3f 00 00 00       	call   1000a3 <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
	}
	yield();
    }
    // After running out of memory, do nothing forever
    while (1) {
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <align>:
// this creates the first node of the linked list
node *head = NULL;

// Function to align sizes to the nearest multiple of 8
size_t align(size_t size) {
    return (size + ALIGNMENT - 1) & ~(ALIGNMENT - 1);
  100071:	48 8d 47 07          	lea    0x7(%rdi),%rax
  100075:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  100079:	c3                   	ret

000000000010007a <free>:

// finished
void free(void *ptr) {
    // if the pointer is null already return NULL
    if (ptr == NULL)
  10007a:	48 85 ff             	test   %rdi,%rdi
  10007d:	74 1b                	je     10009a <free+0x20>
    {
        // will do nothing and just reeturn
        return;
    }
    //creates a new node to loop through thel inked list
    node * current = head;
  10007f:	48 8b 05 8a 1f 00 00 	mov    0x1f8a(%rip),%rax        # 102010 <head>
    // while loop to loop through the lsit
    while (current != NULL)
  100086:	48 85 c0             	test   %rax,%rax
  100089:	74 0f                	je     10009a <free+0x20>
    {   
        // checks if that current pt_data is equal to requested pointer
        // if it is then
        if (current->pt_data == ptr)
  10008b:	48 39 78 20          	cmp    %rdi,0x20(%rax)
  10008f:	74 0a                	je     10009b <free+0x21>
            // sets the current to free -- this means sets to 1
            // current = 1 so that node is free
            current->free = 1;
            break;
        }
        current = current->next;
  100091:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (current != NULL)
  100095:	48 85 c0             	test   %rax,%rax
  100098:	75 f1                	jne    10008b <free+0x11>
    }

    // this will break out and just return
    return;

}
  10009a:	c3                   	ret
            current->free = 1;
  10009b:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
            break;
  1000a2:	c3                   	ret

00000000001000a3 <malloc>:


// finished
void *malloc(uint64_t numbytes) {
    // if the number of bytes is 0 then return NULL
    if (numbytes == 0) {
  1000a3:	48 85 ff             	test   %rdi,%rdi
  1000a6:	0f 84 eb 00 00 00    	je     100197 <malloc+0xf4>
    return (size + ALIGNMENT - 1) & ~(ALIGNMENT - 1);
  1000ac:	48 8d 57 07          	lea    0x7(%rdi),%rdx
  1000b0:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx

    // this will align number of bytes
    numbytes = align(numbytes);

    // this is the total size
    uint64_t total_size = numbytes + NODE_SIZE;
  1000b4:	48 8d 7a 28          	lea    0x28(%rdx),%rdi

    // this checks if numbytes is greater than the max amount of energy
    if (numbytes > (0xffffffffffffffff - (uint64_t) NODE_SIZE))
  1000b8:	48 83 fa d7          	cmp    $0xffffffffffffffd7,%rdx
  1000bc:	0f 87 db 00 00 00    	ja     10019d <malloc+0xfa>
        return NULL;
    }

    // this will first create a node equal to head
    // allows for while loop
    node *current = head;
  1000c2:	48 8b 05 47 1f 00 00 	mov    0x1f47(%rip),%rax        # 102010 <head>

    // this will store the block found
    node *found = NULL;

    // searches for a free or suitable block
    while (current != NULL) {
  1000c9:	48 85 c0             	test   %rax,%rax
  1000cc:	75 62                	jne    100130 <malloc+0x8d>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1000ce:	cd 3a                	int    $0x3a
  1000d0:	48 89 05 41 1f 00 00 	mov    %rax,0x1f41(%rip)        # 102018 <result.0>

    // heap expansion
    // create a node for expanding the heap
    node *expanded = sbrk(total_size);
    // if sbrk did not work then return NULL
    if (expanded == (void *)-1) {
  1000d7:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1000db:	0f 84 c2 00 00 00    	je     1001a3 <malloc+0x100>
        return NULL;
    }

    // if expanded node assigns the size to numbytes
    // expanded size = num bytes
    expanded->size = numbytes;
  1000e1:	89 10                	mov    %edx,(%rax)
    // makes the node not free
    expanded->free = 0;
  1000e3:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    // expanded pt_data is equal to size of expanded + metadata
    expanded->pt_data = (char*)expanded + NODE_SIZE;
  1000ea:	48 8d 50 28          	lea    0x28(%rax),%rdx
  1000ee:	48 89 50 20          	mov    %rdx,0x20(%rax)
    // sets to end NULL since last node
    expanded->next = NULL;
  1000f2:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  1000f9:	00 
    // if no list has been created then make first
    // make first node in linked list
    if (head == NULL)
  1000fa:	48 8b 15 0f 1f 00 00 	mov    0x1f0f(%rip),%rdx        # 102010 <head>
  100101:	48 89 50 08          	mov    %rdx,0x8(%rax)
    {
        expanded->prev = head;
    }

    // if no list has been created then make first
    if (head == NULL) {
  100105:	48 85 d2             	test   %rdx,%rdx
  100108:	0f 84 80 00 00 00    	je     10018e <malloc+0xeb>
        head = expanded;
    } else {
        // if list exists then have to find the last one
        node *last = head;
        // this while loop finds the last one
        while (last->next != NULL) {
  10010e:	48 89 d1             	mov    %rdx,%rcx
  100111:	48 8b 52 10          	mov    0x10(%rdx),%rdx
  100115:	48 85 d2             	test   %rdx,%rdx
  100118:	75 f4                	jne    10010e <malloc+0x6b>
            last = last->next;
        }
        last->next = expanded;
  10011a:	48 89 41 10          	mov    %rax,0x10(%rcx)
        expanded->prev = last;
  10011e:	48 89 48 08          	mov    %rcx,0x8(%rax)
    }

    // returns the node point data
    return expanded->pt_data;
  100122:	48 8b 40 20          	mov    0x20(%rax),%rax
  100126:	c3                   	ret
        current = current->next;
  100127:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (current != NULL) {
  10012b:	48 85 c0             	test   %rax,%rax
  10012e:	74 9e                	je     1000ce <malloc+0x2b>
        if (current->free == 1 && (uint64_t) current->size >= total_size) {
  100130:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  100134:	75 f1                	jne    100127 <malloc+0x84>
  100136:	48 63 08             	movslq (%rax),%rcx
  100139:	48 39 f9             	cmp    %rdi,%rcx
  10013c:	72 e9                	jb     100127 <malloc+0x84>
        if (found->size - total_size >= NODE_SIZE) {
  10013e:	8b 30                	mov    (%rax),%esi
  100140:	48 63 ce             	movslq %esi,%rcx
  100143:	48 29 f9             	sub    %rdi,%rcx
  100146:	48 83 f9 27          	cmp    $0x27,%rcx
  10014a:	76 36                	jbe    100182 <malloc+0xdf>
            node *new_node = (node *)((char *)found + total_size);
  10014c:	48 8d 0c 38          	lea    (%rax,%rdi,1),%rcx
            new_node->size = found->size - total_size;
  100150:	29 fe                	sub    %edi,%esi
  100152:	89 31                	mov    %esi,(%rcx)
            new_node->prev = found;
  100154:	48 89 41 08          	mov    %rax,0x8(%rcx)
            new_node->free = 1;
  100158:	c7 41 18 01 00 00 00 	movl   $0x1,0x18(%rcx)
            new_node->next = found->next;
  10015f:	48 8b 70 10          	mov    0x10(%rax),%rsi
  100163:	48 89 71 10          	mov    %rsi,0x10(%rcx)
            new_node->pt_data = (char *)new_node + NODE_SIZE;
  100167:	48 8d 71 28          	lea    0x28(%rcx),%rsi
  10016b:	48 89 71 20          	mov    %rsi,0x20(%rcx)
            if (found->next != NULL) {
  10016f:	48 8b 70 10          	mov    0x10(%rax),%rsi
  100173:	48 85 f6             	test   %rsi,%rsi
  100176:	74 04                	je     10017c <malloc+0xd9>
                found->next->prev = new_node;
  100178:	48 89 4e 08          	mov    %rcx,0x8(%rsi)
            found->next = new_node;
  10017c:	48 89 48 10          	mov    %rcx,0x10(%rax)
            found->size = numbytes;
  100180:	89 10                	mov    %edx,(%rax)
        found->free = 0;
  100182:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        return found->pt_data;
  100189:	48 8b 40 20          	mov    0x20(%rax),%rax
  10018d:	c3                   	ret
        head = expanded;
  10018e:	48 89 05 7b 1e 00 00 	mov    %rax,0x1e7b(%rip)        # 102010 <head>
  100195:	eb 8b                	jmp    100122 <malloc+0x7f>
        return NULL;
  100197:	b8 00 00 00 00       	mov    $0x0,%eax
  10019c:	c3                   	ret
        return NULL;
  10019d:	b8 00 00 00 00       	mov    $0x0,%eax
  1001a2:	c3                   	ret
        return NULL;
  1001a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1001a8:	c3                   	ret

00000000001001a9 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  1001a9:	55                   	push   %rbp
  1001aa:	48 89 e5             	mov    %rsp,%rbp
  1001ad:	41 54                	push   %r12
  1001af:	53                   	push   %rbx
    // edge case if num or sz is equal to 0, then calloc returns NULL
    //sz or num == 0
    // size or num is 0
    if (num == 0 || sz == 0)
  1001b0:	48 85 ff             	test   %rdi,%rdi
  1001b3:	74 4e                	je     100203 <calloc+0x5a>
  1001b5:	48 85 f6             	test   %rsi,%rsi
  1001b8:	74 49                	je     100203 <calloc+0x5a>
    // creates pointer
    void* pointer = NULL;
    // this checks if the number of bytes allocated is greater than total space available
    // checks max - node size divided by size
    // the second parts tells how many nums you can possibly have
    if (num > (0xffffffffffffffff - NODE_SIZE)/sz)
  1001ba:	48 c7 c0 d7 ff ff ff 	mov    $0xffffffffffffffd7,%rax
  1001c1:	ba 00 00 00 00       	mov    $0x0,%edx
  1001c6:	48 f7 f6             	div    %rsi
    {
        return NULL;
  1001c9:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if (num > (0xffffffffffffffff - NODE_SIZE)/sz)
  1001cf:	48 39 f8             	cmp    %rdi,%rax
  1001d2:	72 27                	jb     1001fb <calloc+0x52>
    uint64_t total = num * sz;
  1001d4:	48 89 fb             	mov    %rdi,%rbx
  1001d7:	48 0f af de          	imul   %rsi,%rbx
    }
    else
    {
        // malloc a certain total
        pointer = malloc(total);
  1001db:	48 89 df             	mov    %rbx,%rdi
  1001de:	e8 c0 fe ff ff       	call   1000a3 <malloc>
  1001e3:	49 89 c4             	mov    %rax,%r12
        //this if the pointer is empty
        // this goes in if the pointer is NULL
        if (pointer != NULL){
  1001e6:	48 85 c0             	test   %rax,%rax
  1001e9:	74 10                	je     1001fb <calloc+0x52>
            // this sets pointer to be 0 for total size if null pointer
            memset(pointer, 0, total);
  1001eb:	48 89 da             	mov    %rbx,%rdx
  1001ee:	be 00 00 00 00       	mov    $0x0,%esi
  1001f3:	48 89 c7             	mov    %rax,%rdi
  1001f6:	e8 22 03 00 00       	call   10051d <memset>
        }
    }
    
    return pointer;
}
  1001fb:	4c 89 e0             	mov    %r12,%rax
  1001fe:	5b                   	pop    %rbx
  1001ff:	41 5c                	pop    %r12
  100201:	5d                   	pop    %rbp
  100202:	c3                   	ret
        return NULL;
  100203:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100209:	eb f0                	jmp    1001fb <calloc+0x52>

000000000010020b <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  10020b:	55                   	push   %rbp
  10020c:	48 89 e5             	mov    %rsp,%rbp
  10020f:	41 54                	push   %r12
  100211:	53                   	push   %rbx
  100212:	48 89 fb             	mov    %rdi,%rbx
    // this checks if size is 0
    // if size is 0 then returns null
    if (sz == 0)
  100215:	48 85 f6             	test   %rsi,%rsi
  100218:	75 25                	jne    10023f <realloc+0x34>
    {
        // if ptr not null then free ptr
        if (ptr != NULL)
  10021a:	48 85 ff             	test   %rdi,%rdi
  10021d:	75 13                	jne    100232 <realloc+0x27>
    // this checks if the ptr is null
    // if pointer is NULL then call malloc
    if (ptr == NULL)
    {
        // if it is then just returns the malloc
        return malloc(sz);
  10021f:	48 89 f7             	mov    %rsi,%rdi
  100222:	e8 7c fe ff ff       	call   1000a3 <malloc>
  100227:	49 89 c4             	mov    %rax,%r12
    

    // returns the new location
    return new_node;

}
  10022a:	4c 89 e0             	mov    %r12,%rax
  10022d:	5b                   	pop    %rbx
  10022e:	41 5c                	pop    %r12
  100230:	5d                   	pop    %rbp
  100231:	c3                   	ret
            free(ptr);
  100232:	e8 43 fe ff ff       	call   10007a <free>
            return NULL;
  100237:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  10023d:	eb eb                	jmp    10022a <realloc+0x1f>
    if (ptr == NULL)
  10023f:	48 85 ff             	test   %rdi,%rdi
  100242:	74 db                	je     10021f <realloc+0x14>
    if (sz < (uint64_t) header->size)
  100244:	48 63 87 c0 f9 ff ff 	movslq -0x640(%rdi),%rax
        return ptr;
  10024b:	49 89 fc             	mov    %rdi,%r12
    if (sz < (uint64_t) header->size)
  10024e:	48 39 c6             	cmp    %rax,%rsi
  100251:	72 d7                	jb     10022a <realloc+0x1f>
        if (sz > (0xffffffffffffffff - (uint64_t) NODE_SIZE))
  100253:	48 83 fe d7          	cmp    $0xffffffffffffffd7,%rsi
  100257:	77 31                	ja     10028a <realloc+0x7f>
  100259:	48 39 f0             	cmp    %rsi,%rax
  10025c:	74 2c                	je     10028a <realloc+0x7f>
        new_node = malloc(sz);
  10025e:	48 89 f7             	mov    %rsi,%rdi
  100261:	e8 3d fe ff ff       	call   1000a3 <malloc>
  100266:	49 89 c4             	mov    %rax,%r12
        if (new_node == NULL)
  100269:	48 85 c0             	test   %rax,%rax
  10026c:	74 bc                	je     10022a <realloc+0x1f>
        memcpy(new_node, ptr, header->size);
  10026e:	48 63 93 c0 f9 ff ff 	movslq -0x640(%rbx),%rdx
  100275:	48 89 de             	mov    %rbx,%rsi
  100278:	48 89 c7             	mov    %rax,%rdi
  10027b:	e8 9f 01 00 00       	call   10041f <memcpy>
        free(ptr);
  100280:	48 89 df             	mov    %rbx,%rdi
  100283:	e8 f2 fd ff ff       	call   10007a <free>
  100288:	eb a0                	jmp    10022a <realloc+0x1f>
            return NULL;
  10028a:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100290:	eb 98                	jmp    10022a <realloc+0x1f>

0000000000100292 <defrag>:

// finished
void defrag() {
    // creates a node to loop through the linked list
    node *current = head;
  100292:	48 8b 05 77 1d 00 00 	mov    0x1d77(%rip),%rax        # 102010 <head>
    
    while (current != NULL && current->next != NULL) {
  100299:	48 85 c0             	test   %rax,%rax
  10029c:	75 08                	jne    1002a6 <defrag+0x14>
  10029e:	c3                   	ret
            // this is needed for the doubly linked list
            // that means something after next
            if (next->next != NULL) {
                // sets the previous one to it before
                // sets the next next previous to be the current one
                next->next->prev = current;
  10029f:	48 89 41 08          	mov    %rax,0x8(%rcx)
    while (current != NULL && current->next != NULL) {
  1002a3:	48 89 d0             	mov    %rdx,%rax
  1002a6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1002aa:	48 85 d2             	test   %rdx,%rdx
  1002ad:	74 22                	je     1002d1 <defrag+0x3f>
        if (current->free == 1 && current->next->free == 1) {
  1002af:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  1002b3:	75 ee                	jne    1002a3 <defrag+0x11>
  1002b5:	83 7a 18 01          	cmpl   $0x1,0x18(%rdx)
  1002b9:	75 e8                	jne    1002a3 <defrag+0x11>
            current->size += next->size;  
  1002bb:	8b 0a                	mov    (%rdx),%ecx
  1002bd:	01 08                	add    %ecx,(%rax)
            current->next = next->next;
  1002bf:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  1002c3:	48 89 48 10          	mov    %rcx,0x10(%rax)
            if (next->next != NULL) {
  1002c7:	48 89 c2             	mov    %rax,%rdx
  1002ca:	48 85 c9             	test   %rcx,%rcx
  1002cd:	75 d0                	jne    10029f <defrag+0xd>
  1002cf:	eb d2                	jmp    1002a3 <defrag+0x11>
        } else {
            //that means just move on
            current = current->next;
        }
    }
}
  1002d1:	c3                   	ret

00000000001002d2 <heap_info>:

int heap_info(heap_info_struct *info) {
  1002d2:	55                   	push   %rbp
  1002d3:	48 89 e5             	mov    %rsp,%rbp
  1002d6:	41 55                	push   %r13
  1002d8:	41 54                	push   %r12
  1002da:	53                   	push   %rbx
  1002db:	48 83 ec 08          	sub    $0x8,%rsp
  1002df:	48 89 fb             	mov    %rdi,%rbx

    long * size_array = NULL;
    // allocates for array
    void **ptr_array = NULL;
    // Traverse the list to gather data
    node *current = head;
  1002e2:	48 8b 05 27 1d 00 00 	mov    0x1d27(%rip),%rax        # 102010 <head>

    while (current != NULL) {
  1002e9:	48 85 c0             	test   %rax,%rax
  1002ec:	0f 84 f9 00 00 00    	je     1003eb <heap_info+0x119>
    int largest_free_chunk = 0;
  1002f2:	b9 00 00 00 00       	mov    $0x0,%ecx
    int total_free_space = 0;
  1002f7:	be 00 00 00 00       	mov    $0x0,%esi
    int num_allocs = 0;
  1002fc:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100302:	eb 0d                	jmp    100311 <heap_info+0x3f>
                largest_free_chunk = current->size;
            }
        } else if (current->free == 0) {
            // this counts for how much allocations has been made
            // or non free nodes
            num_allocs++;
  100304:	41 83 c4 01          	add    $0x1,%r12d
        }
        current = current->next;
  100308:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (current != NULL) {
  10030c:	48 85 c0             	test   %rax,%rax
  10030f:	74 11                	je     100322 <heap_info+0x50>
        if (current->free) {
  100311:	83 78 18 00          	cmpl   $0x0,0x18(%rax)
  100315:	74 ed                	je     100304 <heap_info+0x32>
            total_free_space += current->size;
  100317:	8b 10                	mov    (%rax),%edx
  100319:	01 d6                	add    %edx,%esi
            if (current->size > largest_free_chunk) {
  10031b:	39 d1                	cmp    %edx,%ecx
  10031d:	0f 4c ca             	cmovl  %edx,%ecx
  100320:	eb e6                	jmp    100308 <heap_info+0x36>
    }

    // This will set the fields for the heap-info struct
    // this will set the fields for heap-info struct
    
    info->free_space = total_free_space;
  100322:	89 73 18             	mov    %esi,0x18(%rbx)
    info->largest_free_chunk = largest_free_chunk;
  100325:	89 4b 1c             	mov    %ecx,0x1c(%rbx)

    // if there are no allocations then arrays are null
    if (num_allocs == 0)
  100328:	45 85 e4             	test   %r12d,%r12d
  10032b:	0f 84 c8 00 00 00    	je     1003f9 <heap_info+0x127>
    //info->num_allocs = num_allocs;

    // after this while loop, you have largest free chunk, free space and num_allocs

    // allocates space for the array
    info->size_array = (long *)malloc((uint64_t) num_allocs * sizeof(long *));
  100331:	4d 63 ec             	movslq %r12d,%r13
  100334:	49 c1 e5 03          	shl    $0x3,%r13
  100338:	4c 89 ef             	mov    %r13,%rdi
  10033b:	e8 63 fd ff ff       	call   1000a3 <malloc>
  100340:	48 89 43 08          	mov    %rax,0x8(%rbx)
    // allocates for array
    info->ptr_array = malloc(num_allocs * sizeof(uintptr_t));
  100344:	4c 89 ef             	mov    %r13,%rdi
  100347:	e8 57 fd ff ff       	call   1000a3 <malloc>
  10034c:	48 89 43 10          	mov    %rax,0x10(%rbx)

    // if cannot malloc space correctly
    // returns -1
    if (info->ptr_array == NULL || info->size_array == NULL)
  100350:	48 85 c0             	test   %rax,%rax
  100353:	74 7a                	je     1003cf <heap_info+0xfd>
  100355:	48 83 7b 08 00       	cmpq   $0x0,0x8(%rbx)
  10035a:	74 7a                	je     1003d6 <heap_info+0x104>
        current = current->next;
    }

    // This will sort the arrays based on descending order
    // this is for buble sort
    for (int i = 0; i < num_allocs - 1; i++) {
  10035c:	41 83 fc 01          	cmp    $0x1,%r12d
  100360:	7e 7b                	jle    1003dd <heap_info+0x10b>
  100362:	45 89 e2             	mov    %r12d,%r10d
  100365:	eb 53                	jmp    1003ba <heap_info+0xe8>
        for (int j = 0; j < num_allocs - i - 1; j++) {
  100367:	4c 39 c0             	cmp    %r8,%rax
  10036a:	74 44                	je     1003b0 <heap_info+0xde>
            // this compares the size array between current and the next one
            if (info->size_array[j] < info->size_array[j + 1]) {
  10036c:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  100370:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
  100374:	48 8b 0e             	mov    (%rsi),%rcx
  100377:	48 89 c7             	mov    %rax,%rdi
  10037a:	48 83 c0 08          	add    $0x8,%rax
  10037e:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
  100382:	48 39 d1             	cmp    %rdx,%rcx
  100385:	7d e0                	jge    100367 <heap_info+0x95>

                long temp_size = info->size_array[j];
                void *temp_ptr = info->ptr_array[j];
  100387:	4c 8b 4b 10          	mov    0x10(%rbx),%r9
  10038b:	4d 8b 0c 39          	mov    (%r9,%rdi,1),%r9
                // this will flip the next and other one next to each other
                info->size_array[j] = info->size_array[j + 1];
  10038f:	48 89 16             	mov    %rdx,(%rsi)
                info->ptr_array[j] = info->ptr_array[j + 1];
  100392:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  100396:	48 8b 34 02          	mov    (%rdx,%rax,1),%rsi
  10039a:	48 89 34 3a          	mov    %rsi,(%rdx,%rdi,1)
                // this will also change ptr_array
                info->size_array[j + 1] = temp_size;
  10039e:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  1003a2:	48 89 0c 02          	mov    %rcx,(%rdx,%rax,1)
                info->ptr_array[j + 1] = temp_ptr;
  1003a6:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  1003aa:	4c 89 0c 02          	mov    %r9,(%rdx,%rax,1)
  1003ae:	eb b7                	jmp    100367 <heap_info+0x95>
    for (int i = 0; i < num_allocs - 1; i++) {
  1003b0:	41 83 ea 01          	sub    $0x1,%r10d
  1003b4:	41 83 fa 01          	cmp    $0x1,%r10d
  1003b8:	74 2a                	je     1003e4 <heap_info+0x112>
        for (int j = 0; j < num_allocs - i - 1; j++) {
  1003ba:	41 83 fa 01          	cmp    $0x1,%r10d
  1003be:	7e 59                	jle    100419 <heap_info+0x147>
  1003c0:	45 8d 42 ff          	lea    -0x1(%r10),%r8d
  1003c4:	49 c1 e0 03          	shl    $0x3,%r8
  1003c8:	b8 00 00 00 00       	mov    $0x0,%eax
  1003cd:	eb 9d                	jmp    10036c <heap_info+0x9a>
        return -1;
  1003cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1003d4:	eb 38                	jmp    10040e <heap_info+0x13c>
  1003d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1003db:	eb 31                	jmp    10040e <heap_info+0x13c>
            }
        }
    }

    // returns a 0 if successful
    return 0; 
  1003dd:	b8 00 00 00 00       	mov    $0x0,%eax
  1003e2:	eb 2a                	jmp    10040e <heap_info+0x13c>
  1003e4:	b8 00 00 00 00       	mov    $0x0,%eax
  1003e9:	eb 23                	jmp    10040e <heap_info+0x13c>
    info->free_space = total_free_space;
  1003eb:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = largest_free_chunk;
  1003f2:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
        info->size_array = NULL;
  1003f9:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  100400:	00 
        info->ptr_array = NULL;
  100401:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  100408:	00 
        return 0;
  100409:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10040e:	48 83 c4 08          	add    $0x8,%rsp
  100412:	5b                   	pop    %rbx
  100413:	41 5c                	pop    %r12
  100415:	41 5d                	pop    %r13
  100417:	5d                   	pop    %rbp
  100418:	c3                   	ret
    for (int i = 0; i < num_allocs - 1; i++) {
  100419:	41 83 ea 01          	sub    $0x1,%r10d
  10041d:	eb 9b                	jmp    1003ba <heap_info+0xe8>

000000000010041f <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10041f:	55                   	push   %rbp
  100420:	48 89 e5             	mov    %rsp,%rbp
  100423:	48 83 ec 28          	sub    $0x28,%rsp
  100427:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10042b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10042f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100433:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100437:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10043b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10043f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100443:	eb 1c                	jmp    100461 <memcpy+0x42>
        *d = *s;
  100445:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100449:	0f b6 10             	movzbl (%rax),%edx
  10044c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100450:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100452:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100457:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10045c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100461:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100466:	75 dd                	jne    100445 <memcpy+0x26>
    }
    return dst;
  100468:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10046c:	c9                   	leave
  10046d:	c3                   	ret

000000000010046e <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10046e:	55                   	push   %rbp
  10046f:	48 89 e5             	mov    %rsp,%rbp
  100472:	48 83 ec 28          	sub    $0x28,%rsp
  100476:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10047a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10047e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100482:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100486:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10048a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10048e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100492:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100496:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10049a:	73 6a                	jae    100506 <memmove+0x98>
  10049c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1004a0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004a4:	48 01 d0             	add    %rdx,%rax
  1004a7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1004ab:	73 59                	jae    100506 <memmove+0x98>
        s += n, d += n;
  1004ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004b1:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1004b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004b9:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1004bd:	eb 17                	jmp    1004d6 <memmove+0x68>
            *--d = *--s;
  1004bf:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1004c4:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1004c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004cd:	0f b6 10             	movzbl (%rax),%edx
  1004d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004d4:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1004d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1004da:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1004de:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1004e2:	48 85 c0             	test   %rax,%rax
  1004e5:	75 d8                	jne    1004bf <memmove+0x51>
    if (s < d && s + n > d) {
  1004e7:	eb 2e                	jmp    100517 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1004e9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1004ed:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1004f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004f9:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004fd:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100501:	0f b6 12             	movzbl (%rdx),%edx
  100504:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100506:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10050a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10050e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100512:	48 85 c0             	test   %rax,%rax
  100515:	75 d2                	jne    1004e9 <memmove+0x7b>
        }
    }
    return dst;
  100517:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10051b:	c9                   	leave
  10051c:	c3                   	ret

000000000010051d <memset>:

void* memset(void* v, int c, size_t n) {
  10051d:	55                   	push   %rbp
  10051e:	48 89 e5             	mov    %rsp,%rbp
  100521:	48 83 ec 28          	sub    $0x28,%rsp
  100525:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100529:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10052c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100530:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100534:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100538:	eb 15                	jmp    10054f <memset+0x32>
        *p = c;
  10053a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10053d:	89 c2                	mov    %eax,%edx
  10053f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100543:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100545:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10054a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10054f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100554:	75 e4                	jne    10053a <memset+0x1d>
    }
    return v;
  100556:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10055a:	c9                   	leave
  10055b:	c3                   	ret

000000000010055c <strlen>:

size_t strlen(const char* s) {
  10055c:	55                   	push   %rbp
  10055d:	48 89 e5             	mov    %rsp,%rbp
  100560:	48 83 ec 18          	sub    $0x18,%rsp
  100564:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100568:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10056f:	00 
  100570:	eb 0a                	jmp    10057c <strlen+0x20>
        ++n;
  100572:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100577:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10057c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100580:	0f b6 00             	movzbl (%rax),%eax
  100583:	84 c0                	test   %al,%al
  100585:	75 eb                	jne    100572 <strlen+0x16>
    }
    return n;
  100587:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10058b:	c9                   	leave
  10058c:	c3                   	ret

000000000010058d <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10058d:	55                   	push   %rbp
  10058e:	48 89 e5             	mov    %rsp,%rbp
  100591:	48 83 ec 20          	sub    $0x20,%rsp
  100595:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100599:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10059d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1005a4:	00 
  1005a5:	eb 0a                	jmp    1005b1 <strnlen+0x24>
        ++n;
  1005a7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1005ac:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1005b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005b5:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1005b9:	74 0b                	je     1005c6 <strnlen+0x39>
  1005bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005bf:	0f b6 00             	movzbl (%rax),%eax
  1005c2:	84 c0                	test   %al,%al
  1005c4:	75 e1                	jne    1005a7 <strnlen+0x1a>
    }
    return n;
  1005c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1005ca:	c9                   	leave
  1005cb:	c3                   	ret

00000000001005cc <strcpy>:

char* strcpy(char* dst, const char* src) {
  1005cc:	55                   	push   %rbp
  1005cd:	48 89 e5             	mov    %rsp,%rbp
  1005d0:	48 83 ec 20          	sub    $0x20,%rsp
  1005d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1005d8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1005dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005e0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1005e4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1005e8:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1005ec:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1005f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005f4:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1005f8:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1005fc:	0f b6 12             	movzbl (%rdx),%edx
  1005ff:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100601:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100605:	48 83 e8 01          	sub    $0x1,%rax
  100609:	0f b6 00             	movzbl (%rax),%eax
  10060c:	84 c0                	test   %al,%al
  10060e:	75 d4                	jne    1005e4 <strcpy+0x18>
    return dst;
  100610:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100614:	c9                   	leave
  100615:	c3                   	ret

0000000000100616 <strcmp>:

int strcmp(const char* a, const char* b) {
  100616:	55                   	push   %rbp
  100617:	48 89 e5             	mov    %rsp,%rbp
  10061a:	48 83 ec 10          	sub    $0x10,%rsp
  10061e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100622:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100626:	eb 0a                	jmp    100632 <strcmp+0x1c>
        ++a, ++b;
  100628:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10062d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100632:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100636:	0f b6 00             	movzbl (%rax),%eax
  100639:	84 c0                	test   %al,%al
  10063b:	74 1d                	je     10065a <strcmp+0x44>
  10063d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100641:	0f b6 00             	movzbl (%rax),%eax
  100644:	84 c0                	test   %al,%al
  100646:	74 12                	je     10065a <strcmp+0x44>
  100648:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10064c:	0f b6 10             	movzbl (%rax),%edx
  10064f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100653:	0f b6 00             	movzbl (%rax),%eax
  100656:	38 c2                	cmp    %al,%dl
  100658:	74 ce                	je     100628 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10065a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10065e:	0f b6 00             	movzbl (%rax),%eax
  100661:	89 c2                	mov    %eax,%edx
  100663:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100667:	0f b6 00             	movzbl (%rax),%eax
  10066a:	38 d0                	cmp    %dl,%al
  10066c:	0f 92 c0             	setb   %al
  10066f:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100672:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100676:	0f b6 00             	movzbl (%rax),%eax
  100679:	89 c1                	mov    %eax,%ecx
  10067b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10067f:	0f b6 00             	movzbl (%rax),%eax
  100682:	38 c1                	cmp    %al,%cl
  100684:	0f 92 c0             	setb   %al
  100687:	0f b6 c0             	movzbl %al,%eax
  10068a:	29 c2                	sub    %eax,%edx
  10068c:	89 d0                	mov    %edx,%eax
}
  10068e:	c9                   	leave
  10068f:	c3                   	ret

0000000000100690 <strchr>:

char* strchr(const char* s, int c) {
  100690:	55                   	push   %rbp
  100691:	48 89 e5             	mov    %rsp,%rbp
  100694:	48 83 ec 10          	sub    $0x10,%rsp
  100698:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10069c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  10069f:	eb 05                	jmp    1006a6 <strchr+0x16>
        ++s;
  1006a1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1006a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006aa:	0f b6 00             	movzbl (%rax),%eax
  1006ad:	84 c0                	test   %al,%al
  1006af:	74 0e                	je     1006bf <strchr+0x2f>
  1006b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006b5:	0f b6 00             	movzbl (%rax),%eax
  1006b8:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1006bb:	38 d0                	cmp    %dl,%al
  1006bd:	75 e2                	jne    1006a1 <strchr+0x11>
    }
    if (*s == (char) c) {
  1006bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006c3:	0f b6 00             	movzbl (%rax),%eax
  1006c6:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1006c9:	38 d0                	cmp    %dl,%al
  1006cb:	75 06                	jne    1006d3 <strchr+0x43>
        return (char*) s;
  1006cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006d1:	eb 05                	jmp    1006d8 <strchr+0x48>
    } else {
        return NULL;
  1006d3:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1006d8:	c9                   	leave
  1006d9:	c3                   	ret

00000000001006da <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1006da:	55                   	push   %rbp
  1006db:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1006de:	8b 05 3c 19 00 00    	mov    0x193c(%rip),%eax        # 102020 <rand_seed_set>
  1006e4:	85 c0                	test   %eax,%eax
  1006e6:	75 0a                	jne    1006f2 <rand+0x18>
        srand(819234718U);
  1006e8:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1006ed:	e8 24 00 00 00       	call   100716 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1006f2:	8b 05 2c 19 00 00    	mov    0x192c(%rip),%eax        # 102024 <rand_seed>
  1006f8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1006fe:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100703:	89 05 1b 19 00 00    	mov    %eax,0x191b(%rip)        # 102024 <rand_seed>
    return rand_seed & RAND_MAX;
  100709:	8b 05 15 19 00 00    	mov    0x1915(%rip),%eax        # 102024 <rand_seed>
  10070f:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100714:	5d                   	pop    %rbp
  100715:	c3                   	ret

0000000000100716 <srand>:

void srand(unsigned seed) {
  100716:	55                   	push   %rbp
  100717:	48 89 e5             	mov    %rsp,%rbp
  10071a:	48 83 ec 08          	sub    $0x8,%rsp
  10071e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100721:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100724:	89 05 fa 18 00 00    	mov    %eax,0x18fa(%rip)        # 102024 <rand_seed>
    rand_seed_set = 1;
  10072a:	c7 05 ec 18 00 00 01 	movl   $0x1,0x18ec(%rip)        # 102020 <rand_seed_set>
  100731:	00 00 00 
}
  100734:	90                   	nop
  100735:	c9                   	leave
  100736:	c3                   	ret

0000000000100737 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100737:	55                   	push   %rbp
  100738:	48 89 e5             	mov    %rsp,%rbp
  10073b:	48 83 ec 28          	sub    $0x28,%rsp
  10073f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100743:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100747:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10074a:	48 c7 45 f8 60 16 10 	movq   $0x101660,-0x8(%rbp)
  100751:	00 
    if (base < 0) {
  100752:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100756:	79 0b                	jns    100763 <fill_numbuf+0x2c>
        digits = lower_digits;
  100758:	48 c7 45 f8 80 16 10 	movq   $0x101680,-0x8(%rbp)
  10075f:	00 
        base = -base;
  100760:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100763:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100768:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10076c:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  10076f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100772:	48 63 c8             	movslq %eax,%rcx
  100775:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100779:	ba 00 00 00 00       	mov    $0x0,%edx
  10077e:	48 f7 f1             	div    %rcx
  100781:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100785:	48 01 d0             	add    %rdx,%rax
  100788:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10078d:	0f b6 10             	movzbl (%rax),%edx
  100790:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100794:	88 10                	mov    %dl,(%rax)
        val /= base;
  100796:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100799:	48 63 f0             	movslq %eax,%rsi
  10079c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1007a0:	ba 00 00 00 00       	mov    $0x0,%edx
  1007a5:	48 f7 f6             	div    %rsi
  1007a8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1007ac:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1007b1:	75 bc                	jne    10076f <fill_numbuf+0x38>
    return numbuf_end;
  1007b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1007b7:	c9                   	leave
  1007b8:	c3                   	ret

00000000001007b9 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1007b9:	55                   	push   %rbp
  1007ba:	48 89 e5             	mov    %rsp,%rbp
  1007bd:	53                   	push   %rbx
  1007be:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1007c5:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1007cc:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1007d2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007d9:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1007e0:	e9 8a 09 00 00       	jmp    10116f <printer_vprintf+0x9b6>
        if (*format != '%') {
  1007e5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ec:	0f b6 00             	movzbl (%rax),%eax
  1007ef:	3c 25                	cmp    $0x25,%al
  1007f1:	74 31                	je     100824 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1007f3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1007fa:	4c 8b 00             	mov    (%rax),%r8
  1007fd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100804:	0f b6 00             	movzbl (%rax),%eax
  100807:	0f b6 c8             	movzbl %al,%ecx
  10080a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100810:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100817:	89 ce                	mov    %ecx,%esi
  100819:	48 89 c7             	mov    %rax,%rdi
  10081c:	41 ff d0             	call   *%r8
            continue;
  10081f:	e9 43 09 00 00       	jmp    101167 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100824:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10082b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100832:	01 
  100833:	eb 44                	jmp    100879 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100835:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10083c:	0f b6 00             	movzbl (%rax),%eax
  10083f:	0f be c0             	movsbl %al,%eax
  100842:	89 c6                	mov    %eax,%esi
  100844:	bf 80 14 10 00       	mov    $0x101480,%edi
  100849:	e8 42 fe ff ff       	call   100690 <strchr>
  10084e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100852:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100857:	74 30                	je     100889 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100859:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  10085d:	48 2d 80 14 10 00    	sub    $0x101480,%rax
  100863:	ba 01 00 00 00       	mov    $0x1,%edx
  100868:	89 c1                	mov    %eax,%ecx
  10086a:	d3 e2                	shl    %cl,%edx
  10086c:	89 d0                	mov    %edx,%eax
  10086e:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100871:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100878:	01 
  100879:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100880:	0f b6 00             	movzbl (%rax),%eax
  100883:	84 c0                	test   %al,%al
  100885:	75 ae                	jne    100835 <printer_vprintf+0x7c>
  100887:	eb 01                	jmp    10088a <printer_vprintf+0xd1>
            } else {
                break;
  100889:	90                   	nop
            }
        }

        // process width
        int width = -1;
  10088a:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100891:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100898:	0f b6 00             	movzbl (%rax),%eax
  10089b:	3c 30                	cmp    $0x30,%al
  10089d:	7e 67                	jle    100906 <printer_vprintf+0x14d>
  10089f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008a6:	0f b6 00             	movzbl (%rax),%eax
  1008a9:	3c 39                	cmp    $0x39,%al
  1008ab:	7f 59                	jg     100906 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1008ad:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1008b4:	eb 2e                	jmp    1008e4 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  1008b6:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1008b9:	89 d0                	mov    %edx,%eax
  1008bb:	c1 e0 02             	shl    $0x2,%eax
  1008be:	01 d0                	add    %edx,%eax
  1008c0:	01 c0                	add    %eax,%eax
  1008c2:	89 c1                	mov    %eax,%ecx
  1008c4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008cb:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008cf:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008d6:	0f b6 00             	movzbl (%rax),%eax
  1008d9:	0f be c0             	movsbl %al,%eax
  1008dc:	01 c8                	add    %ecx,%eax
  1008de:	83 e8 30             	sub    $0x30,%eax
  1008e1:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1008e4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008eb:	0f b6 00             	movzbl (%rax),%eax
  1008ee:	3c 2f                	cmp    $0x2f,%al
  1008f0:	0f 8e 85 00 00 00    	jle    10097b <printer_vprintf+0x1c2>
  1008f6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008fd:	0f b6 00             	movzbl (%rax),%eax
  100900:	3c 39                	cmp    $0x39,%al
  100902:	7e b2                	jle    1008b6 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100904:	eb 75                	jmp    10097b <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100906:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10090d:	0f b6 00             	movzbl (%rax),%eax
  100910:	3c 2a                	cmp    $0x2a,%al
  100912:	75 68                	jne    10097c <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100914:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10091b:	8b 00                	mov    (%rax),%eax
  10091d:	83 f8 2f             	cmp    $0x2f,%eax
  100920:	77 30                	ja     100952 <printer_vprintf+0x199>
  100922:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100929:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10092d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100934:	8b 00                	mov    (%rax),%eax
  100936:	89 c0                	mov    %eax,%eax
  100938:	48 01 d0             	add    %rdx,%rax
  10093b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100942:	8b 12                	mov    (%rdx),%edx
  100944:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100947:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10094e:	89 0a                	mov    %ecx,(%rdx)
  100950:	eb 1a                	jmp    10096c <printer_vprintf+0x1b3>
  100952:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100959:	48 8b 40 08          	mov    0x8(%rax),%rax
  10095d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100961:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100968:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10096c:	8b 00                	mov    (%rax),%eax
  10096e:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100971:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100978:	01 
  100979:	eb 01                	jmp    10097c <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  10097b:	90                   	nop
        }

        // process precision
        int precision = -1;
  10097c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100983:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10098a:	0f b6 00             	movzbl (%rax),%eax
  10098d:	3c 2e                	cmp    $0x2e,%al
  10098f:	0f 85 00 01 00 00    	jne    100a95 <printer_vprintf+0x2dc>
            ++format;
  100995:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10099c:	01 
            if (*format >= '0' && *format <= '9') {
  10099d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009a4:	0f b6 00             	movzbl (%rax),%eax
  1009a7:	3c 2f                	cmp    $0x2f,%al
  1009a9:	7e 67                	jle    100a12 <printer_vprintf+0x259>
  1009ab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009b2:	0f b6 00             	movzbl (%rax),%eax
  1009b5:	3c 39                	cmp    $0x39,%al
  1009b7:	7f 59                	jg     100a12 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1009b9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1009c0:	eb 2e                	jmp    1009f0 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  1009c2:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1009c5:	89 d0                	mov    %edx,%eax
  1009c7:	c1 e0 02             	shl    $0x2,%eax
  1009ca:	01 d0                	add    %edx,%eax
  1009cc:	01 c0                	add    %eax,%eax
  1009ce:	89 c1                	mov    %eax,%ecx
  1009d0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009d7:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1009db:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009e2:	0f b6 00             	movzbl (%rax),%eax
  1009e5:	0f be c0             	movsbl %al,%eax
  1009e8:	01 c8                	add    %ecx,%eax
  1009ea:	83 e8 30             	sub    $0x30,%eax
  1009ed:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1009f0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009f7:	0f b6 00             	movzbl (%rax),%eax
  1009fa:	3c 2f                	cmp    $0x2f,%al
  1009fc:	0f 8e 85 00 00 00    	jle    100a87 <printer_vprintf+0x2ce>
  100a02:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a09:	0f b6 00             	movzbl (%rax),%eax
  100a0c:	3c 39                	cmp    $0x39,%al
  100a0e:	7e b2                	jle    1009c2 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100a10:	eb 75                	jmp    100a87 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100a12:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a19:	0f b6 00             	movzbl (%rax),%eax
  100a1c:	3c 2a                	cmp    $0x2a,%al
  100a1e:	75 68                	jne    100a88 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100a20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a27:	8b 00                	mov    (%rax),%eax
  100a29:	83 f8 2f             	cmp    $0x2f,%eax
  100a2c:	77 30                	ja     100a5e <printer_vprintf+0x2a5>
  100a2e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a35:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a39:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a40:	8b 00                	mov    (%rax),%eax
  100a42:	89 c0                	mov    %eax,%eax
  100a44:	48 01 d0             	add    %rdx,%rax
  100a47:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a4e:	8b 12                	mov    (%rdx),%edx
  100a50:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a5a:	89 0a                	mov    %ecx,(%rdx)
  100a5c:	eb 1a                	jmp    100a78 <printer_vprintf+0x2bf>
  100a5e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a65:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a69:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a74:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a78:	8b 00                	mov    (%rax),%eax
  100a7a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100a7d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a84:	01 
  100a85:	eb 01                	jmp    100a88 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100a87:	90                   	nop
            }
            if (precision < 0) {
  100a88:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100a8c:	79 07                	jns    100a95 <printer_vprintf+0x2dc>
                precision = 0;
  100a8e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100a95:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100a9c:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100aa3:	00 
        int length = 0;
  100aa4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100aab:	48 c7 45 c8 86 14 10 	movq   $0x101486,-0x38(%rbp)
  100ab2:	00 
    again:
        switch (*format) {
  100ab3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aba:	0f b6 00             	movzbl (%rax),%eax
  100abd:	0f be c0             	movsbl %al,%eax
  100ac0:	83 e8 43             	sub    $0x43,%eax
  100ac3:	83 f8 37             	cmp    $0x37,%eax
  100ac6:	0f 87 9f 03 00 00    	ja     100e6b <printer_vprintf+0x6b2>
  100acc:	89 c0                	mov    %eax,%eax
  100ace:	48 8b 04 c5 98 14 10 	mov    0x101498(,%rax,8),%rax
  100ad5:	00 
  100ad6:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100ad8:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100adf:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ae6:	01 
            goto again;
  100ae7:	eb ca                	jmp    100ab3 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100ae9:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100aed:	74 5d                	je     100b4c <printer_vprintf+0x393>
  100aef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af6:	8b 00                	mov    (%rax),%eax
  100af8:	83 f8 2f             	cmp    $0x2f,%eax
  100afb:	77 30                	ja     100b2d <printer_vprintf+0x374>
  100afd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b04:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b0f:	8b 00                	mov    (%rax),%eax
  100b11:	89 c0                	mov    %eax,%eax
  100b13:	48 01 d0             	add    %rdx,%rax
  100b16:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b1d:	8b 12                	mov    (%rdx),%edx
  100b1f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b22:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b29:	89 0a                	mov    %ecx,(%rdx)
  100b2b:	eb 1a                	jmp    100b47 <printer_vprintf+0x38e>
  100b2d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b34:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b38:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b3c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b43:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b47:	48 8b 00             	mov    (%rax),%rax
  100b4a:	eb 5c                	jmp    100ba8 <printer_vprintf+0x3ef>
  100b4c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b53:	8b 00                	mov    (%rax),%eax
  100b55:	83 f8 2f             	cmp    $0x2f,%eax
  100b58:	77 30                	ja     100b8a <printer_vprintf+0x3d1>
  100b5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b61:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b65:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b6c:	8b 00                	mov    (%rax),%eax
  100b6e:	89 c0                	mov    %eax,%eax
  100b70:	48 01 d0             	add    %rdx,%rax
  100b73:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b7a:	8b 12                	mov    (%rdx),%edx
  100b7c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b7f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b86:	89 0a                	mov    %ecx,(%rdx)
  100b88:	eb 1a                	jmp    100ba4 <printer_vprintf+0x3eb>
  100b8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b91:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b95:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b99:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ba0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ba4:	8b 00                	mov    (%rax),%eax
  100ba6:	48 98                	cltq
  100ba8:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100bac:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100bb0:	48 c1 f8 38          	sar    $0x38,%rax
  100bb4:	25 80 00 00 00       	and    $0x80,%eax
  100bb9:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100bbc:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100bc0:	74 09                	je     100bcb <printer_vprintf+0x412>
  100bc2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100bc6:	48 f7 d8             	neg    %rax
  100bc9:	eb 04                	jmp    100bcf <printer_vprintf+0x416>
  100bcb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100bcf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100bd3:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100bd6:	83 c8 60             	or     $0x60,%eax
  100bd9:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100bdc:	e9 cf 02 00 00       	jmp    100eb0 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100be1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100be5:	74 5d                	je     100c44 <printer_vprintf+0x48b>
  100be7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bee:	8b 00                	mov    (%rax),%eax
  100bf0:	83 f8 2f             	cmp    $0x2f,%eax
  100bf3:	77 30                	ja     100c25 <printer_vprintf+0x46c>
  100bf5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bfc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c00:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c07:	8b 00                	mov    (%rax),%eax
  100c09:	89 c0                	mov    %eax,%eax
  100c0b:	48 01 d0             	add    %rdx,%rax
  100c0e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c15:	8b 12                	mov    (%rdx),%edx
  100c17:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c1a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c21:	89 0a                	mov    %ecx,(%rdx)
  100c23:	eb 1a                	jmp    100c3f <printer_vprintf+0x486>
  100c25:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c30:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c34:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c3b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c3f:	48 8b 00             	mov    (%rax),%rax
  100c42:	eb 5c                	jmp    100ca0 <printer_vprintf+0x4e7>
  100c44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c4b:	8b 00                	mov    (%rax),%eax
  100c4d:	83 f8 2f             	cmp    $0x2f,%eax
  100c50:	77 30                	ja     100c82 <printer_vprintf+0x4c9>
  100c52:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c59:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c5d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c64:	8b 00                	mov    (%rax),%eax
  100c66:	89 c0                	mov    %eax,%eax
  100c68:	48 01 d0             	add    %rdx,%rax
  100c6b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c72:	8b 12                	mov    (%rdx),%edx
  100c74:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c77:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c7e:	89 0a                	mov    %ecx,(%rdx)
  100c80:	eb 1a                	jmp    100c9c <printer_vprintf+0x4e3>
  100c82:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c89:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c8d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c91:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c98:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c9c:	8b 00                	mov    (%rax),%eax
  100c9e:	89 c0                	mov    %eax,%eax
  100ca0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ca4:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100ca8:	e9 03 02 00 00       	jmp    100eb0 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100cad:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100cb4:	e9 28 ff ff ff       	jmp    100be1 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100cb9:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100cc0:	e9 1c ff ff ff       	jmp    100be1 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100cc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ccc:	8b 00                	mov    (%rax),%eax
  100cce:	83 f8 2f             	cmp    $0x2f,%eax
  100cd1:	77 30                	ja     100d03 <printer_vprintf+0x54a>
  100cd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cda:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cde:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce5:	8b 00                	mov    (%rax),%eax
  100ce7:	89 c0                	mov    %eax,%eax
  100ce9:	48 01 d0             	add    %rdx,%rax
  100cec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cf3:	8b 12                	mov    (%rdx),%edx
  100cf5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cf8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cff:	89 0a                	mov    %ecx,(%rdx)
  100d01:	eb 1a                	jmp    100d1d <printer_vprintf+0x564>
  100d03:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d0e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d12:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d19:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d1d:	48 8b 00             	mov    (%rax),%rax
  100d20:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100d24:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100d2b:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100d32:	e9 79 01 00 00       	jmp    100eb0 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100d37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d3e:	8b 00                	mov    (%rax),%eax
  100d40:	83 f8 2f             	cmp    $0x2f,%eax
  100d43:	77 30                	ja     100d75 <printer_vprintf+0x5bc>
  100d45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d4c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d57:	8b 00                	mov    (%rax),%eax
  100d59:	89 c0                	mov    %eax,%eax
  100d5b:	48 01 d0             	add    %rdx,%rax
  100d5e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d65:	8b 12                	mov    (%rdx),%edx
  100d67:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d6a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d71:	89 0a                	mov    %ecx,(%rdx)
  100d73:	eb 1a                	jmp    100d8f <printer_vprintf+0x5d6>
  100d75:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d7c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d80:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d84:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d8b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d8f:	48 8b 00             	mov    (%rax),%rax
  100d92:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100d96:	e9 15 01 00 00       	jmp    100eb0 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100d9b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100da2:	8b 00                	mov    (%rax),%eax
  100da4:	83 f8 2f             	cmp    $0x2f,%eax
  100da7:	77 30                	ja     100dd9 <printer_vprintf+0x620>
  100da9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100db4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dbb:	8b 00                	mov    (%rax),%eax
  100dbd:	89 c0                	mov    %eax,%eax
  100dbf:	48 01 d0             	add    %rdx,%rax
  100dc2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dc9:	8b 12                	mov    (%rdx),%edx
  100dcb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100dce:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dd5:	89 0a                	mov    %ecx,(%rdx)
  100dd7:	eb 1a                	jmp    100df3 <printer_vprintf+0x63a>
  100dd9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100de0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100de4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100de8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100def:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100df3:	8b 00                	mov    (%rax),%eax
  100df5:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100dfb:	e9 67 03 00 00       	jmp    101167 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100e00:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e04:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100e08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e0f:	8b 00                	mov    (%rax),%eax
  100e11:	83 f8 2f             	cmp    $0x2f,%eax
  100e14:	77 30                	ja     100e46 <printer_vprintf+0x68d>
  100e16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e1d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e21:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e28:	8b 00                	mov    (%rax),%eax
  100e2a:	89 c0                	mov    %eax,%eax
  100e2c:	48 01 d0             	add    %rdx,%rax
  100e2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e36:	8b 12                	mov    (%rdx),%edx
  100e38:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e42:	89 0a                	mov    %ecx,(%rdx)
  100e44:	eb 1a                	jmp    100e60 <printer_vprintf+0x6a7>
  100e46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e4d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e51:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e5c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e60:	8b 00                	mov    (%rax),%eax
  100e62:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100e65:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100e69:	eb 45                	jmp    100eb0 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100e6b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e6f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100e73:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e7a:	0f b6 00             	movzbl (%rax),%eax
  100e7d:	84 c0                	test   %al,%al
  100e7f:	74 0c                	je     100e8d <printer_vprintf+0x6d4>
  100e81:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e88:	0f b6 00             	movzbl (%rax),%eax
  100e8b:	eb 05                	jmp    100e92 <printer_vprintf+0x6d9>
  100e8d:	b8 25 00 00 00       	mov    $0x25,%eax
  100e92:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100e95:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100e99:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ea0:	0f b6 00             	movzbl (%rax),%eax
  100ea3:	84 c0                	test   %al,%al
  100ea5:	75 08                	jne    100eaf <printer_vprintf+0x6f6>
                format--;
  100ea7:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100eae:	01 
            }
            break;
  100eaf:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100eb0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eb3:	83 e0 20             	and    $0x20,%eax
  100eb6:	85 c0                	test   %eax,%eax
  100eb8:	74 1e                	je     100ed8 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100eba:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100ebe:	48 83 c0 18          	add    $0x18,%rax
  100ec2:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100ec5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100ec9:	48 89 ce             	mov    %rcx,%rsi
  100ecc:	48 89 c7             	mov    %rax,%rdi
  100ecf:	e8 63 f8 ff ff       	call   100737 <fill_numbuf>
  100ed4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100ed8:	48 c7 45 c0 86 14 10 	movq   $0x101486,-0x40(%rbp)
  100edf:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100ee0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ee3:	83 e0 20             	and    $0x20,%eax
  100ee6:	85 c0                	test   %eax,%eax
  100ee8:	74 48                	je     100f32 <printer_vprintf+0x779>
  100eea:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eed:	83 e0 40             	and    $0x40,%eax
  100ef0:	85 c0                	test   %eax,%eax
  100ef2:	74 3e                	je     100f32 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100ef4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ef7:	25 80 00 00 00       	and    $0x80,%eax
  100efc:	85 c0                	test   %eax,%eax
  100efe:	74 0a                	je     100f0a <printer_vprintf+0x751>
                prefix = "-";
  100f00:	48 c7 45 c0 87 14 10 	movq   $0x101487,-0x40(%rbp)
  100f07:	00 
            if (flags & FLAG_NEGATIVE) {
  100f08:	eb 73                	jmp    100f7d <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100f0a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f0d:	83 e0 10             	and    $0x10,%eax
  100f10:	85 c0                	test   %eax,%eax
  100f12:	74 0a                	je     100f1e <printer_vprintf+0x765>
                prefix = "+";
  100f14:	48 c7 45 c0 89 14 10 	movq   $0x101489,-0x40(%rbp)
  100f1b:	00 
            if (flags & FLAG_NEGATIVE) {
  100f1c:	eb 5f                	jmp    100f7d <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100f1e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f21:	83 e0 08             	and    $0x8,%eax
  100f24:	85 c0                	test   %eax,%eax
  100f26:	74 55                	je     100f7d <printer_vprintf+0x7c4>
                prefix = " ";
  100f28:	48 c7 45 c0 8b 14 10 	movq   $0x10148b,-0x40(%rbp)
  100f2f:	00 
            if (flags & FLAG_NEGATIVE) {
  100f30:	eb 4b                	jmp    100f7d <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100f32:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f35:	83 e0 20             	and    $0x20,%eax
  100f38:	85 c0                	test   %eax,%eax
  100f3a:	74 42                	je     100f7e <printer_vprintf+0x7c5>
  100f3c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f3f:	83 e0 01             	and    $0x1,%eax
  100f42:	85 c0                	test   %eax,%eax
  100f44:	74 38                	je     100f7e <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100f46:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100f4a:	74 06                	je     100f52 <printer_vprintf+0x799>
  100f4c:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f50:	75 2c                	jne    100f7e <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100f52:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100f57:	75 0c                	jne    100f65 <printer_vprintf+0x7ac>
  100f59:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f5c:	25 00 01 00 00       	and    $0x100,%eax
  100f61:	85 c0                	test   %eax,%eax
  100f63:	74 19                	je     100f7e <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100f65:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f69:	75 07                	jne    100f72 <printer_vprintf+0x7b9>
  100f6b:	b8 8d 14 10 00       	mov    $0x10148d,%eax
  100f70:	eb 05                	jmp    100f77 <printer_vprintf+0x7be>
  100f72:	b8 90 14 10 00       	mov    $0x101490,%eax
  100f77:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100f7b:	eb 01                	jmp    100f7e <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100f7d:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100f7e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f82:	78 24                	js     100fa8 <printer_vprintf+0x7ef>
  100f84:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f87:	83 e0 20             	and    $0x20,%eax
  100f8a:	85 c0                	test   %eax,%eax
  100f8c:	75 1a                	jne    100fa8 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100f8e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f91:	48 63 d0             	movslq %eax,%rdx
  100f94:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f98:	48 89 d6             	mov    %rdx,%rsi
  100f9b:	48 89 c7             	mov    %rax,%rdi
  100f9e:	e8 ea f5 ff ff       	call   10058d <strnlen>
  100fa3:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100fa6:	eb 0f                	jmp    100fb7 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100fa8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100fac:	48 89 c7             	mov    %rax,%rdi
  100faf:	e8 a8 f5 ff ff       	call   10055c <strlen>
  100fb4:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100fb7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fba:	83 e0 20             	and    $0x20,%eax
  100fbd:	85 c0                	test   %eax,%eax
  100fbf:	74 20                	je     100fe1 <printer_vprintf+0x828>
  100fc1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100fc5:	78 1a                	js     100fe1 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100fc7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100fca:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100fcd:	7e 08                	jle    100fd7 <printer_vprintf+0x81e>
  100fcf:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100fd2:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100fd5:	eb 05                	jmp    100fdc <printer_vprintf+0x823>
  100fd7:	b8 00 00 00 00       	mov    $0x0,%eax
  100fdc:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100fdf:	eb 5c                	jmp    10103d <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100fe1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fe4:	83 e0 20             	and    $0x20,%eax
  100fe7:	85 c0                	test   %eax,%eax
  100fe9:	74 4b                	je     101036 <printer_vprintf+0x87d>
  100feb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fee:	83 e0 02             	and    $0x2,%eax
  100ff1:	85 c0                	test   %eax,%eax
  100ff3:	74 41                	je     101036 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100ff5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ff8:	83 e0 04             	and    $0x4,%eax
  100ffb:	85 c0                	test   %eax,%eax
  100ffd:	75 37                	jne    101036 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100fff:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101003:	48 89 c7             	mov    %rax,%rdi
  101006:	e8 51 f5 ff ff       	call   10055c <strlen>
  10100b:	89 c2                	mov    %eax,%edx
  10100d:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101010:	01 d0                	add    %edx,%eax
  101012:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101015:	7e 1f                	jle    101036 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101017:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10101a:	2b 45 bc             	sub    -0x44(%rbp),%eax
  10101d:	89 c3                	mov    %eax,%ebx
  10101f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101023:	48 89 c7             	mov    %rax,%rdi
  101026:	e8 31 f5 ff ff       	call   10055c <strlen>
  10102b:	89 c2                	mov    %eax,%edx
  10102d:	89 d8                	mov    %ebx,%eax
  10102f:	29 d0                	sub    %edx,%eax
  101031:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101034:	eb 07                	jmp    10103d <printer_vprintf+0x884>
        } else {
            zeros = 0;
  101036:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  10103d:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101040:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101043:	01 d0                	add    %edx,%eax
  101045:	48 63 d8             	movslq %eax,%rbx
  101048:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10104c:	48 89 c7             	mov    %rax,%rdi
  10104f:	e8 08 f5 ff ff       	call   10055c <strlen>
  101054:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  101058:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10105b:	29 d0                	sub    %edx,%eax
  10105d:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101060:	eb 25                	jmp    101087 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  101062:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101069:	48 8b 08             	mov    (%rax),%rcx
  10106c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101072:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101079:	be 20 00 00 00       	mov    $0x20,%esi
  10107e:	48 89 c7             	mov    %rax,%rdi
  101081:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101083:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101087:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10108a:	83 e0 04             	and    $0x4,%eax
  10108d:	85 c0                	test   %eax,%eax
  10108f:	75 36                	jne    1010c7 <printer_vprintf+0x90e>
  101091:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101095:	7f cb                	jg     101062 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  101097:	eb 2e                	jmp    1010c7 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101099:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010a0:	4c 8b 00             	mov    (%rax),%r8
  1010a3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1010a7:	0f b6 00             	movzbl (%rax),%eax
  1010aa:	0f b6 c8             	movzbl %al,%ecx
  1010ad:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010b3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010ba:	89 ce                	mov    %ecx,%esi
  1010bc:	48 89 c7             	mov    %rax,%rdi
  1010bf:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1010c2:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1010c7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1010cb:	0f b6 00             	movzbl (%rax),%eax
  1010ce:	84 c0                	test   %al,%al
  1010d0:	75 c7                	jne    101099 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1010d2:	eb 25                	jmp    1010f9 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1010d4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010db:	48 8b 08             	mov    (%rax),%rcx
  1010de:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010e4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010eb:	be 30 00 00 00       	mov    $0x30,%esi
  1010f0:	48 89 c7             	mov    %rax,%rdi
  1010f3:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1010f5:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1010f9:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1010fd:	7f d5                	jg     1010d4 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  1010ff:	eb 32                	jmp    101133 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101101:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101108:	4c 8b 00             	mov    (%rax),%r8
  10110b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10110f:	0f b6 00             	movzbl (%rax),%eax
  101112:	0f b6 c8             	movzbl %al,%ecx
  101115:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10111b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101122:	89 ce                	mov    %ecx,%esi
  101124:	48 89 c7             	mov    %rax,%rdi
  101127:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10112a:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  10112f:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101133:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101137:	7f c8                	jg     101101 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101139:	eb 25                	jmp    101160 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  10113b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101142:	48 8b 08             	mov    (%rax),%rcx
  101145:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10114b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101152:	be 20 00 00 00       	mov    $0x20,%esi
  101157:	48 89 c7             	mov    %rax,%rdi
  10115a:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  10115c:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101160:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101164:	7f d5                	jg     10113b <printer_vprintf+0x982>
        }
    done: ;
  101166:	90                   	nop
    for (; *format; ++format) {
  101167:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10116e:	01 
  10116f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101176:	0f b6 00             	movzbl (%rax),%eax
  101179:	84 c0                	test   %al,%al
  10117b:	0f 85 64 f6 ff ff    	jne    1007e5 <printer_vprintf+0x2c>
    }
}
  101181:	90                   	nop
  101182:	90                   	nop
  101183:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101187:	c9                   	leave
  101188:	c3                   	ret

0000000000101189 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101189:	55                   	push   %rbp
  10118a:	48 89 e5             	mov    %rsp,%rbp
  10118d:	48 83 ec 20          	sub    $0x20,%rsp
  101191:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101195:	89 f0                	mov    %esi,%eax
  101197:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10119a:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  10119d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1011a1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011a9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011ad:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1011b2:	48 39 d0             	cmp    %rdx,%rax
  1011b5:	72 0c                	jb     1011c3 <console_putc+0x3a>
        cp->cursor = console;
  1011b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011bb:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1011c2:	00 
    }
    if (c == '\n') {
  1011c3:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1011c7:	75 78                	jne    101241 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1011c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011cd:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011d1:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1011d7:	48 d1 f8             	sar    %rax
  1011da:	48 89 c1             	mov    %rax,%rcx
  1011dd:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1011e4:	66 66 66 
  1011e7:	48 89 c8             	mov    %rcx,%rax
  1011ea:	48 f7 ea             	imul   %rdx
  1011ed:	48 c1 fa 05          	sar    $0x5,%rdx
  1011f1:	48 89 c8             	mov    %rcx,%rax
  1011f4:	48 c1 f8 3f          	sar    $0x3f,%rax
  1011f8:	48 29 c2             	sub    %rax,%rdx
  1011fb:	48 89 d0             	mov    %rdx,%rax
  1011fe:	48 c1 e0 02          	shl    $0x2,%rax
  101202:	48 01 d0             	add    %rdx,%rax
  101205:	48 c1 e0 04          	shl    $0x4,%rax
  101209:	48 29 c1             	sub    %rax,%rcx
  10120c:	48 89 ca             	mov    %rcx,%rdx
  10120f:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101212:	eb 25                	jmp    101239 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101214:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101217:	83 c8 20             	or     $0x20,%eax
  10121a:	89 c6                	mov    %eax,%esi
  10121c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101220:	48 8b 40 08          	mov    0x8(%rax),%rax
  101224:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101228:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10122c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101230:	89 f2                	mov    %esi,%edx
  101232:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101235:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101239:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  10123d:	75 d5                	jne    101214 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  10123f:	eb 24                	jmp    101265 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101241:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101245:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101248:	09 d0                	or     %edx,%eax
  10124a:	89 c6                	mov    %eax,%esi
  10124c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101250:	48 8b 40 08          	mov    0x8(%rax),%rax
  101254:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101258:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10125c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101260:	89 f2                	mov    %esi,%edx
  101262:	66 89 10             	mov    %dx,(%rax)
}
  101265:	90                   	nop
  101266:	c9                   	leave
  101267:	c3                   	ret

0000000000101268 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101268:	55                   	push   %rbp
  101269:	48 89 e5             	mov    %rsp,%rbp
  10126c:	48 83 ec 30          	sub    $0x30,%rsp
  101270:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101273:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101276:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10127a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10127e:	48 c7 45 f0 89 11 10 	movq   $0x101189,-0x10(%rbp)
  101285:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101286:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10128a:	78 09                	js     101295 <console_vprintf+0x2d>
  10128c:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101293:	7e 07                	jle    10129c <console_vprintf+0x34>
        cpos = 0;
  101295:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10129c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10129f:	48 98                	cltq
  1012a1:	48 01 c0             	add    %rax,%rax
  1012a4:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1012aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1012ae:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1012b2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1012b6:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1012b9:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1012bd:	48 89 c7             	mov    %rax,%rdi
  1012c0:	e8 f4 f4 ff ff       	call   1007b9 <printer_vprintf>
    return cp.cursor - console;
  1012c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012c9:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1012cf:	48 d1 f8             	sar    %rax
}
  1012d2:	c9                   	leave
  1012d3:	c3                   	ret

00000000001012d4 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1012d4:	55                   	push   %rbp
  1012d5:	48 89 e5             	mov    %rsp,%rbp
  1012d8:	48 83 ec 60          	sub    $0x60,%rsp
  1012dc:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1012df:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1012e2:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1012e6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1012ea:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1012ee:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1012f2:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1012f9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1012fd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101301:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101305:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101309:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10130d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101311:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101314:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101317:	89 c7                	mov    %eax,%edi
  101319:	e8 4a ff ff ff       	call   101268 <console_vprintf>
  10131e:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101321:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101324:	c9                   	leave
  101325:	c3                   	ret

0000000000101326 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101326:	55                   	push   %rbp
  101327:	48 89 e5             	mov    %rsp,%rbp
  10132a:	48 83 ec 20          	sub    $0x20,%rsp
  10132e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101332:	89 f0                	mov    %esi,%eax
  101334:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101337:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10133a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10133e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101342:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101346:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10134a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10134e:	48 8b 40 10          	mov    0x10(%rax),%rax
  101352:	48 39 c2             	cmp    %rax,%rdx
  101355:	73 1a                	jae    101371 <string_putc+0x4b>
        *sp->s++ = c;
  101357:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10135b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10135f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101363:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101367:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10136b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10136f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101371:	90                   	nop
  101372:	c9                   	leave
  101373:	c3                   	ret

0000000000101374 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101374:	55                   	push   %rbp
  101375:	48 89 e5             	mov    %rsp,%rbp
  101378:	48 83 ec 40          	sub    $0x40,%rsp
  10137c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101380:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101384:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101388:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10138c:	48 c7 45 e8 26 13 10 	movq   $0x101326,-0x18(%rbp)
  101393:	00 
    sp.s = s;
  101394:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101398:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10139c:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1013a1:	74 33                	je     1013d6 <vsnprintf+0x62>
        sp.end = s + size - 1;
  1013a3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1013a7:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1013ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1013af:	48 01 d0             	add    %rdx,%rax
  1013b2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1013b6:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1013ba:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1013be:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1013c2:	be 00 00 00 00       	mov    $0x0,%esi
  1013c7:	48 89 c7             	mov    %rax,%rdi
  1013ca:	e8 ea f3 ff ff       	call   1007b9 <printer_vprintf>
        *sp.s = 0;
  1013cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013d3:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1013d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013da:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1013de:	c9                   	leave
  1013df:	c3                   	ret

00000000001013e0 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1013e0:	55                   	push   %rbp
  1013e1:	48 89 e5             	mov    %rsp,%rbp
  1013e4:	48 83 ec 70          	sub    $0x70,%rsp
  1013e8:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1013ec:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1013f0:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1013f4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1013f8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1013fc:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101400:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101407:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10140b:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10140f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101413:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101417:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10141b:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10141f:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101423:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101427:	48 89 c7             	mov    %rax,%rdi
  10142a:	e8 45 ff ff ff       	call   101374 <vsnprintf>
  10142f:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101432:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101435:	c9                   	leave
  101436:	c3                   	ret

0000000000101437 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101437:	55                   	push   %rbp
  101438:	48 89 e5             	mov    %rsp,%rbp
  10143b:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10143f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101446:	eb 13                	jmp    10145b <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  101448:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10144b:	48 98                	cltq
  10144d:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101454:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101457:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10145b:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101462:	7e e4                	jle    101448 <console_clear+0x11>
    }
    cursorpos = 0;
  101464:	c7 05 8e 7b fb ff 00 	movl   $0x0,-0x48472(%rip)        # b8ffc <cursorpos>
  10146b:	00 00 00 
}
  10146e:	90                   	nop
  10146f:	c9                   	leave
  101470:	c3                   	ret
